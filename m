From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Wed, 31 Oct 2012 02:39:53 +0100
Message-ID: <CAMP44s0RcbAiUmvGACxO+H-b-anQSPXxUqUuZwYRKWfrpXYeew@mail.gmail.com>
References: <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
	<20121030185914.GI15167@elie.Belkin>
	<CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
	<CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
	<20121030214531.GN15167@elie.Belkin>
	<CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
	<20121030220717.GO15167@elie.Belkin>
	<CAMP44s3ArAQXH+-EbH4MHYaV6fTAWdwGzBdZwzn_qtCABHyonQ@mail.gmail.com>
	<20121030235506.GT15167@elie.Belkin>
	<CAMP44s1ftDijYpZW_Reu5qNi1T_L52_353ngNaRW3W1gz+k9jw@mail.gmail.com>
	<20121031010823.GX15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:40:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNHr-0005qj-DI
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 02:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab2JaBjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:39:55 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38760 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab2JaBjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:39:53 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so947764obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=diz17kqrlVcbifUDe0SmXjnf/gAnZU+8J9U07+3CTrw=;
        b=gb1elYpP0STZzjBQLfsLwyh4NTmmhcYqpBSJu3RD1hdnkU8et3JP+QATVBaVpdaYtb
         FUVuSrRv2Cy08QPUh5gJRd2G36Io6NtDbKWU4mSEj3f3vB0N3TcbWMW8MlLIF0zRF73/
         MyU8h572G/ErSx9jY3qtntZgbDrtsUKG/8tW1leJVVfR6W/BfL6BqIwOusK9hNd4Gwz2
         gYUswPPL1D537XFoB27X/RnOBDAa+uk2AAXMZqWP9J/JQp8y26ct/Lq44vVwxFoVsNYx
         Lq9G6G2dntMTOsdHT43ASDA7wjc+hZe4wq1swoSj/H9wTcUVzt24vgsPdWhsMtroeM05
         wlDw==
Received: by 10.182.38.101 with SMTP id f5mr29664511obk.80.1351647593211; Tue,
 30 Oct 2012 18:39:53 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 18:39:53 -0700 (PDT)
In-Reply-To: <20121031010823.GX15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208781>

On Wed, Oct 31, 2012 at 2:08 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> I don't think it's my job to explain to you how 'git fast-export'
>> works.
>
> Actually, if you are submitting a patch for inclusion, it is your job
> to explain to future readers what the patch does.

That's already explained.

> Yes, the reader
> might not be deeply familiar with the part of fast-export you are
> modifying.

This has nothing to do with what you said. I'm literally explaining to
you how 'git fast-export' works in situations that are completely
orthogonal to this patch, because you are using wrong examples as
grounds to prevent this patch from being accepted. It's not my job to
explain to you that 'git fast-export' doesn't work this way, you have
a command line to type those commands and see for yourself if they do
what you think they do with a vanilla version of git. That's exactly
what I did, to make sure I'm not using assumptions as basis  for
arguing, it took me a few minutes.

That being said, if your problem is that it's not clear to people not
deeply familiar with that part of fast-export, this extra paragraph in
addition to the current commit message should do the trick:

---
The reason this happens is that before traversing the commits,
fast-export checks if any of the refs point to the same object, and
any duplicated ref gets added to a list in order to issue 'reset'
commands after the traversing. Unfortunately, it's not even checking
if the commit is flagged as UNINTERESTING. The fix of course, is to do
precisely that.
---

And to get that all had to do is ask: "Can you please add an
explanation of what this part of the code does? For the ones of us not
familiar with it".

Not; "This patch looks unsafe", "This patch makes Sally mad", "This
patch causes regressions", and so on.

But hey, at least we are not arguing about what is wrong with this
patch (or so I hope).

Cheers.

-- 
Felipe Contreras
