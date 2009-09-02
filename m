From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: disconnect transport after fetching
Date: Wed, 02 Sep 2009 10:55:56 -0700
Message-ID: <7veiqp1b9v.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0909020159080.28290@iabervon.org>
 <20090902063647.GA29559@coredump.intra.peff.net>
 <alpine.LNX.2.00.0909021228570.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Sep 02 19:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu4H-0006ts-TS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbZIBR4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZIBR4O
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:56:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZIBR4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:56:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1535E2207F;
	Wed,  2 Sep 2009 13:56:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C6fU+YvbLq6muJ04RQEi5RvAT+4=; b=R16mt1
	fEQphLCNN+/gOYVNwJqVBk7l0xxXQv+e3FpDJj5kTa8XDNZNnifyNch2HoNuQsFF
	WTCSu5P8FwhSBRIsH3QhZiJF8salgL1IiYRwj8C7mRi8LFDZ/XhbnHXTwpX8/NPV
	iiROnB1H91G0+f5+bPRd4iT1IGsUteAlYkTW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mjI1vGQ8CerUP7IJcjRGdHc5WyfopEF5
	LlxYDc04QqzTcx6wUnSRFcTQ8MVnbHbDfeXt8glNMDZ/SGlf6biTp1XWHGrA/1er
	BHQ3/aQuSAwgosRExIZ/r/+BeT206jFsH+sJTF5Q6Di6qrAaJAAAB+OWLElL6F+h
	r/MQ3RSgics=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98CFE2207A;
	Wed,  2 Sep 2009 13:56:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D6A222078; Wed,  2 Sep
 2009 13:55:58 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0909021228570.28290@iabervon.org> (Daniel
 Barkalow's message of "Wed\, 2 Sep 2009 12\:38\:35 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E3FE2F8C-97E9-11DE-B7B7-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127613>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 2 Sep 2009, Jeff King wrote:
> ...
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> This was suggested by Daniel, so theoretically
>> 
>>   Acked-by: Daniel Barkalow <barkalow@iabervon.org>
>> 
>> :)
>
> This is what I intended, so:
>
> Acked-by: Daniel Barkalow <barkalow@iabervon.org>

Thanks, both.
