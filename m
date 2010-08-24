From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t2017: redo physical reflog existance check
Date: Tue, 24 Aug 2010 09:57:24 -0700
Message-ID: <7v8w3wx823.fsf@alter.siamese.dyndns.org>
References: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com>
 <7vlj93h120.fsf@alter.siamese.dyndns.org>
 <AANLkTilt5gx3Wj4eANfkIFm869Olns1rsMpCS81hS2BV@mail.gmail.com>
 <7vsk3bey1e.fsf@alter.siamese.dyndns.org>
 <AANLkTin76s-ONFuP+OWdxB5LJNf2D1Du+hKxB2s_WhTa@mail.gmail.com>
 <20100824040347.GA19817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 18:57:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onwoh-0000K0-NA
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 18:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab0HXQ5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 12:57:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab0HXQ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 12:57:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1E9CD09E5;
	Tue, 24 Aug 2010 12:57:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qn9Y1RUlqpEskjyOrfNbzW5O8Mo=; b=KTU3mW
	yccWRksW3mcIaRnWEanvOMGl4tifQXCHLJ6LbyshhTWiZoRjR8pjwX7kAFTXOdMP
	dVu+CeNKv2JopLOTMQA702Vz+p5mIJZM+12zXNEATgBaTd8WnvYqxEPkSva3dG3q
	VktqRiEwjkyE40MNZnAbFoeXlt/HwpgSMa52w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mC5XzkSw7lHIAsCxBVBbsM5yr19EbIw2
	kRnwDD9s+k6F4MkEbBpWmIrvHspNJ+MIOgCxYSwHkot8nboYb/G0gY8HapqzGjsf
	Jp81rto24+AwIOilTf68smLO3tXmfJzHm0+vDh3mdRyNvK2PnOMVTmbuOIQgwlyy
	uiX5VlLJu/k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8CD1D09E4;
	Tue, 24 Aug 2010 12:57:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC753D09DF; Tue, 24 Aug
 2010 12:57:26 -0400 (EDT)
In-Reply-To: <20100824040347.GA19817@burratino> (Jonathan Nieder's message of
 "Mon\, 23 Aug 2010 23\:03\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF64061E-AFA0-11DF-A4FE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154324>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The principle (though we do not always adhere to it) is that test
> scripts should pass or fail based only on advertised behavior, not
> implementation details.  That way, _later_ any person who wants to
> improve the implementation will not be impeded by tests.

Well and 'nuff said ;-)  Thanks.
