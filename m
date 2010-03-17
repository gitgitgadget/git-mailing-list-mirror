From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads
 is available
Date: Wed, 17 Mar 2010 15:19:31 -0700
Message-ID: <7vvdcuzj4c.fsf@alter.siamese.dyndns.org>
References: <cover.1267889072.git.j6t@kdbg.org>
 <201003092100.36616.j6t@kdbg.org> <7v7hpjq0aw.fsf@alter.siamese.dyndns.org>
 <201003172228.18939.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 17 23:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns1ad-0000qZ-TD
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 23:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab0CQWTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 18:19:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0CQWTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 18:19:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0899FA3021;
	Wed, 17 Mar 2010 18:19:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kRU0zfMyOkU7x5TjC7f04wstrpY=; b=nTz3kF
	W+V8Uuwk21LlWHMwKyqYFpPOerqPs8V2f64L4wDEbjxLvhZGnux+jkZk7FbcRaA7
	j9MI9IgIHHYdrh3zWeHR8fkQXwJHqWRd5gM8ZZV5pRFNjIv2PbKhys2+sro8+Xbi
	w6Uif+fCNc4ML0qeHtP8CqDNbkrUg6fUpXjIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YoCeI1S8acQepXT907Xs6OBuEebf40Qm
	ObX4JSM612RAE+M/UqfNR3B93q7VH9xBfs0J8f7PH7lkPRCH8s/K1wTuu0h9ursC
	IUD0+QRF9OZqFyKOTS9ppe7YOFBdwU1LRs/5SG1qRGDF2CwRSKGymWPPBz5JnPSu
	u3vLkEUK41w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3957A301E;
	Wed, 17 Mar 2010 18:19:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20D35A301B; Wed, 17 Mar
 2010 18:19:32 -0400 (EDT)
In-Reply-To: <201003172228.18939.j6t@kdbg.org> (Johannes Sixt's message of
 "Wed\, 17 Mar 2010 22\:28\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2BF5B936-3213-11DF-BA0F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142440>

Johannes Sixt <j6t@kdbg.org> writes:

>> Will queue in 'pu', but as Shawn said, we should probably give another
>> closer look at the callees that are started with this interface before
>> moving forward.
>
> So here is my analysis.
> ...
> This concludes my analysis.

Thanks; very much appreciated.

I'll read it over and start moving things to 'next', then.  I'll be slower
than my usual self for the coming few days, though.

A bit of patience please.
