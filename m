From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Promoting Git developers
Date: Thu, 12 Mar 2015 15:58:24 -0700
Message-ID: <xmqq7ful257z.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	<xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
	<20150311073129.GA5947@peff.net>
	<xmqq61a64xg8.fsf@gitster.dls.corp.google.com>
	<20150312223836.GB24492@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 23:58:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWC3k-00048u-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 23:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbbCLW61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 18:58:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750848AbbCLW60 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 18:58:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B2D13FC26;
	Thu, 12 Mar 2015 18:58:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EzD4KIrOKiWn6eEflgkpGTFk0NY=; b=st/ABp
	au4u+1/eeNgkoD2uWblToWS+P7YS/qDEoJAImfodjVCaIKVrWSjGjJHj9yJYKXIe
	0ssR1PoOnzeX2ZALhf3YppZ9Zzzb2gUvs5kIBaXyfmzRUaD8FW/FqGFItsAiYIlr
	+x37OO3wtchhnBvd7aBDI7jA9r0aB+TFvmp+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JC6k2xmNp2TFPFnIxweonLPVRydC02ad
	Dslync5hNlGcdL7tyKTw6i5WXe4xCAJQ/pnkkNXLsAFplBkCJ4vrVKUjXdXS+9p9
	u85EV4DHovJwCzWBGEGoHFJyPFLwQ/sj2QuEJEvN2v9e3HiB68HdSUlMGg+HIBIC
	i160yuaqOn8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3274F3FC25;
	Thu, 12 Mar 2015 18:58:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1CE83FC1D;
	Thu, 12 Mar 2015 18:58:25 -0400 (EDT)
In-Reply-To: <20150312223836.GB24492@peff.net> (Jeff King's message of "Thu,
	12 Mar 2015 18:38:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A5E34AE-C90B-11E4-9F48-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265381>

Jeff King <peff@peff.net> writes:

> Seeing my name in "shortlog" was nice, but not that exciting. I
> submitted a patch, it was taken, and of course it ends up in any
> automated lists of authors. What was much more rewarding was being
> mentioned specifically in "A note from the maintainer" as a helpful
> person. That had much more value because:
>
>   1. It was one of a handful of names.
>
>   2. It was picked by a human.
>
> So in that sense, it is quite the opposite of including shortlog output
> in the release announcements (I still think the shortlog thing we have
> been discussing is a good thing, but not at the same level).

Yes, and that cuts both ways, unfortunately. There always will be "I
am doing more reviews than X and my reviews are higher quality. Why
was X singled out and got thanked but not me?", "X is really doing a
good job reviewing in this cycle, but could other people who send
reviews of lessor quality (to my mind) feel that it is unjustified
if I thanked X and nobody else?", etc. A mechanically generated list
avoids these issues, but the satisfaction you get from being on the
list is not very high, exactly because it is not hand picked.

> I do not know that it is worth having a "Best of 2015" Git awards
> ceremony, but it is sometimes nice to thank people personally when
> you appreciate their efforts. I sometimes mail people off-list to
> do so.

Yeah, I do the same, but revealing that we do so would defeat what
we tried to achieve by doing so off-list in the first place. Now
those who haven't got such a piece of e-mail for a while can start
to suspect that they have fallen out of favour or something ;-(.
