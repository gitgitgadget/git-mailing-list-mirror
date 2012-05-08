From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] status: respect "-b" for porcelain format
Date: Mon, 07 May 2012 21:55:05 -0700
Message-ID: <7vtxzrz2za.fsf@alter.siamese.dyndns.org>
References: <20120507212125.GA19532@sigill.intra.peff.net>
 <20120507212504.GE19567@sigill.intra.peff.net>
 <20120507212836.GA19753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 08 06:55:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRcSD-0005Rv-6S
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 06:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab2EHEzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 00:55:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab2EHEzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 00:55:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 918EB4618;
	Tue,  8 May 2012 00:55:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zg3NlHCtofAssTR2W4t6hoYLZL0=; b=UEwZWA
	/zcuONHP5WUzmshpAoy+ve5QeCFBbhRScP66dRNTXaHKwyd+NaMyEkQN+SYU5B7f
	nWRqbE1i89Uvv3PctZnDEkPuPOwtDxHk8826CKVYjKsc9JXVQqE45BhVCDzGHBbQ
	4rAPVFFQlxBqsfTv73nMfQXvTASBuEr7TqptE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sHRxaiu80+yJ9DLkqEEvhcKXbkNo5FMA
	S3DZGR7Qpr+Lm3QXwmFJCRIQ3tPCB0wOPYSZxycAi/LoMaxJCOc8w1S7Go9qVZhF
	yvsK/gvNiiImSR5sXg6h8/0RsZ/1kE7Er8C+yGGJ5yjYd/qg1NmpKwcPvxEdOGe2
	YyEyiFo53iY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87ECE4617;
	Tue,  8 May 2012 00:55:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E97F4614; Tue,  8 May 2012
 00:55:06 -0400 (EDT)
In-Reply-To: <20120507212836.GA19753@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 7 May 2012 17:28:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB5AC6DE-98C9-11E1-AA80-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197338>

Jeff King <peff@peff.net> writes:

> On Mon, May 07, 2012 at 05:25:04PM -0400, Jeff King wrote:
>
>> There is no reason not to, as the user has to explicitly ask
>> for it, so we are not breaking compatibility by doing so. We
>> can do this simply by moving the "show_branch" flag into
>> the wt_status struct. As a bonus, this saves us from passing
>> it explicitly, simplifying the code.
>
> I forgot this, which should probably be squashed in:
>
> -- >8 --
> Subject: status: fix "--porcelain -z -b" documentation
>
> It is no longer the case that "-z" will not respect "-b".
>
> Signed-off-by: Jeff King <peff@peff.net>

All patches looked good.  I thought that this deserved to eventually land
on 'maint', so I did my usual "am first to master primarily to populate
the object database with exact blob objects, then rebase the result to
'maint' while resolving conflicts both textual and semantic, and finally
attempt to merge it back to 'master'" dance to come up with a two topic
branches.  The result is queued in 'pu'.

Thanks.
