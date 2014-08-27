From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2014, #04; Tue, 26)
Date: Wed, 27 Aug 2014 08:31:51 -0700
Message-ID: <xmqqfvgieyoo.fsf@gitster.dls.corp.google.com>
References: <xmqqy4uagaxt.fsf@gitster.dls.corp.google.com>
	<20140827081323.GA26538@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 17:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMfEj-0006E5-4g
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 17:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbaH0PcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 11:32:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64210 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935216AbaH0PcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 11:32:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11F9D33237;
	Wed, 27 Aug 2014 11:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g/BY0scx4VswV0sie8zH6Uz14W0=; b=NRGkof
	CUN5YdRGRYakt7rBOUVu2HadwtgoxkqBeKtMU4vROFCr2FkyJDyzZqbaoUagS8aD
	m4U0Mo1eszT0NUujc7pGcVJpXD+IPkiZk7sXngaIHJ7oqRMpRHiFbZONhHsj9nLr
	8egRsYncPxS8oJn9FU14oflNMVac6vpfMgyIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZvemmkppKHqQIbu4RVsSI7hdUHbIynam
	Ef1IT5c083otc61QO03lMfULmdyW/M4pQQywb3NTimaLOgC8MdW7w+jdd0Atxa9k
	HlNpktN3N6scurt4aIqGGwyZFuIuc/NzHssqmhpMckbXNW91waJtjPvkYut/q+Mw
	9zqN4STFkUY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 037A933236;
	Wed, 27 Aug 2014 11:32:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9DE2133229;
	Wed, 27 Aug 2014 11:31:53 -0400 (EDT)
In-Reply-To: <20140827081323.GA26538@peff.net> (Jeff King's message of "Wed,
	27 Aug 2014 04:13:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 45A9493C-2DFF-11E4-AFC0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256003>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 26, 2014 at 03:09:34PM -0700, Junio C Hamano wrote:
>
>> --------------------------------------------------
>> [New Topics]
>
> There are a few misc topics of mine that I'd like to ping on:
>
>   - jk/contrib-subtree-make-all; you picked up the topic, but it's not
>     in pu or "what's cooking". Just forgotten, I think?

Correct, I think. Will requeue.

>   - jk/send-pack-many-refspecs; this is in pu, but I didn't see it in
>     "what's cooking". I'm concerned that the "ulimit" test gave you
>     trouble and you punted on it. :)

It was picked up after the day's edition of "What's cooking" was
written, or something, I think.

>   - "fast-export --anonymize"; I noticed you didn't pick this up at all.
>     I agree it has yet to prove its worth, but I wonder if it is worth
>     shipping it (possibly labeled as experimental and not to be depended
>     on) to get it in the hands of users. The intended use is getting bug
>     reports from users, who are not always savvy enough to pick up (and
>     possibly rebase) a patch from the list. I dunno.

I was waiting for the topic to calm down a bit, without knowing if
there will or will not be a reroll with some low-hanging fruit
enhancement based on the discussion, to avoid an "oops, need to
replace the one I queued but haven't pushed out yet with the new
reroll".

Thanks.
