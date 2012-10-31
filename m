From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 16:58:59 +0100
Message-ID: <CAMP44s2u=M5RvkM0nsGuYy_BJ=0KSoFmA8Hq=CeumwvHOZYkRQ@mail.gmail.com>
References: <20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:59:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTahH-0004JF-6C
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 16:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935712Ab2JaP7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 11:59:01 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53510 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935693Ab2JaP7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 11:59:00 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1579102oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8vDUMjQeeY+VYfv/jvgE4g1KlZJMl7djGfmoEDeobTI=;
        b=LDmCcr7JIMC2XIR1Jq8UW7ZnC5u6zzJ2PjzkqfPWlwFsVTNMLlUWxiL2iFc94ttQhO
         LMf74e0DtoftwubHFhfAUqEmQy0BfQavogktYgCgU06qDUXNScLoKPXKHG7l+3gX8/hh
         OedBQMqc99rXOTGMafZir8+lBis1oyOQelq8kyKDlHsmRcTFazMeFisvI6gbWSEXXZKI
         M9UtOf/PU3oeZsoWggf6Awwc7iZAzC/nNdG1RKwdwNomSk7/Ns+hwMAhEVDKkFnhzHnN
         sAQBT+HK6AF+FQUKvQQLn7rNdUQ7TS/AxH518K+ooaReCOBN/xj2UfKDlXDvUYoQ92C0
         tYug==
Received: by 10.182.235.46 with SMTP id uj14mr25057683obc.40.1351699139614;
 Wed, 31 Oct 2012 08:58:59 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 08:58:59 -0700 (PDT)
In-Reply-To: <20121031102712.GB30879@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208836>

On Wed, Oct 31, 2012 at 11:27 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 31, 2012 at 10:30:50AM +0100, Michael J Gruber wrote:
>
>> For the record, Johannes is not the only one being kept from looking at
>> this series (further) by the tone of this discussion. Per hominem
>> attacks are neither professional nor helpful. We prefer to discuss code
>> here, just code. From my comments on an earlier version of your series
>> you can see I've tried. The way other comment threads on this series
>> unfolded made me choose to be a mere by-stander again.
>
> Me too. I really like some of the directions the series is taking, and
> as the maintainer, I'd like to pick it up. But there is a big question
> mark for me still about how it relates to the work in msysgit,
> especially:
>
>   - What advantages does this implementation have over the one in
>     msysgit (i.e., new features that the other one does not have)?

>From the top of my head:

 * Support for tags
 * Support for bookmarks
 * Support for hg-git compatibility
 * Extensive tests (truly extensive)
 * _Much_ simpler code
 * No dependencies

But let's forget about msysgit, because it's not really clear what
series of patches we are talking about. If we want to make a real try,
and a real comparison, we need a clear set of patches, which seem to
be available only on Max Horn's repo[1].

>   - What disadvantages? If this implementation goes into git.git,
>     the msysgit one is likely to wane in popularity. What will we be
>     losing by doing so? If the answer is not "nothing", how hard would
>     it be to port over the missing bits?

Honestly I am not aware of anything we would loose.

>   - The msysgit one got held up by fixes needed for fast-export. Why
>     aren't those a problem for this implementation? If we are using a
>     different strategy that avoids the issue, what are the limitations
>     (if any) of that strategy?

I explained that already. If indeed I was looking at the right
commits, then I already sent patches that tackle, or otherwise deal
with the very same problems (albet in much simpler way). These patches
should have held the code, as they are not _needed_ but merely
improving things. The rest of the patches would barely make any
difference.

This is of course my guess by reading the code, I have not tried it.

In short, only this patch helps:
http://article.gmane.org/gmane.comp.version-control.git/208729

And the rest of the code should work just fine on top of latest git.git.

> I have a feeling that some of those answers are buried deep within the
> discussion, but I have had a hard time following all of the back and
> forth due to the volume and tone of the discussion. Are we at a point
> now where some of the participants can try to summarize the situation?

Let me try to summarize the situation: Johannes is not willing to
collaborate, and nobody else has offered to push forward the patches
in msysgit.

> I am not saying that this implementation must be 100% better than the
> msysgit one. I do not want perfect to to be the enemy of good and end up
> with nothing. But at the same time, there really are two competing
> implementations, one of which has received substantially more field use.
> Even though the msysgit one is not in git.git, it seems like the path
> for making it happen exists (even if it has not been followed yet).
> Before merging an alternative implementation, I would want to know what
> we are potentially throwing away from the msysgit side, and make sure
> that we are not following a wrong path that msysgit has already tried
> and found to be lacking.

I also would like somebody to compare the two, so that we can have
healthy competition, and hopefully also cooperation. But that doesn't
seem to be likely.

So, what to do? Should I be the one making an analysis of that code?
Since nobody else is willing to try to compare the two, I don't see
many other choices, but when/if my conclusion is that my version is
superior, I presume nobody would take my word for it, so what would be
the point?

Cheers.

[1] http://github.com/fingolfin/git/tree/remote-hg

--
Felipe Contreras
