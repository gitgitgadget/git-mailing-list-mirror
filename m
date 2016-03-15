From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] clone tests: rename t57* => t56*
Date: Tue, 15 Mar 2016 15:00:09 -0700
Message-ID: <CAGZ79kZWMhL5kTHU8gdPvm=VqDb58H0ZkNyop=c=P6bLLY1JLg@mail.gmail.com>
References: <1458077150-15564-1-git-send-email-sbeller@google.com>
	<20160315215121.GA30011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 23:00:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afx0i-0001wV-FF
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 23:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbcCOWAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 18:00:13 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33842 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbcCOWAK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 18:00:10 -0400
Received: by mail-io0-f173.google.com with SMTP id m184so41524995iof.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nDPP5QJszP8Ghf1T5TnyaFCFsaFS0GYE/w9vEX9RMb0=;
        b=CemCSDLfJK5vx3oXPoFCuNZZBD2Ama28IpaRs3cO3l4G5k3f2VfDk37tVYShVwVNvW
         Wxn0CbOezfLYUcbAYbbcY3eC26TtBgJT7wLiaNOUi/DcNxZJ/i8aDLcvBRpXIpQ2txOZ
         bUOzL4Z8+FEt1jjG7JcwLhQeuD3HwzM0zQgdYqyzkkiSl+ZmjtaYEECrfMOWJRqRRc/3
         zs7eUn/TZ+Hg8Vp5xgX4FTkJutSxcIkfMJM/nEOrhkCQI3DC+NpVeCOd4wZrdF+BZA8Z
         nh1cSoE2iXV0eFKwR9XElL9Dk+x5DutmKn6uj0FBeyvCWjLTRfhZ5QUJNUJECrvaAmRx
         6mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nDPP5QJszP8Ghf1T5TnyaFCFsaFS0GYE/w9vEX9RMb0=;
        b=Hguy2WZWdUSGF12AdJoYuYWj8dY/c/W0SK4yRSdA4XIfW8GYkQtF/WRHYWA3WJN/HQ
         1xPTjn+65J/xF3mCYXAUYWsoOnhHnQiCyVAniPSG7GsSS8CqqVJBrKhYGBS1KAPAMpkI
         AoYG/hA+EP133DfN/BPNg2C2SvZwA7zCnNfc4E4jb+jeqz3YfjNZCdT5y6hwmUAcdt8c
         aOWi7cqb3d8s+IDn3MTlN7sKP8tdw8FBaja+lXSgB4FPKG4XMK+l0gxTVQPnrATIDH4X
         YY+EC6VJWV2IVo8QcMG4t3SbcQFaf1khkm5kOc0HGEJ686QUKF5A32yn7jMPlbbGX8W6
         3xnA==
X-Gm-Message-State: AD7BkJJcfu8q0ub+tZZYh8HA44yNh105cHf0DL6bYDTnqqjXUxfIyUtYUSNa0HYIyFeXLJhPcoB14oIFlLmq16u0
X-Received: by 10.107.167.80 with SMTP id q77mr1200386ioe.110.1458079209878;
 Tue, 15 Mar 2016 15:00:09 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 15 Mar 2016 15:00:09 -0700 (PDT)
In-Reply-To: <20160315215121.GA30011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288923>

On Tue, Mar 15, 2016 at 2:51 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 15, 2016 at 02:25:50PM -0700, Stefan Beller wrote:
>
>> When trying to find a good spot for testing clone with submodules, I
>> got confused where to add a new test file. There are both tests in t560*
>> as well as t57* both testing the clone command. t/README claims the
>> second digit is to indicate the command, which is inconsistent to the
>> current naming structure.
>>
>> Rename all t57* tests to be in t56* to follow the pattern of the digits
>> as laid out in t/README.
>>
>> It would have been less work to rename t56* => t57* because there are less
>> files, but the tests in t56* look more basic and I assumed the higher the
>> last digits the more complicated niche details are tested, so with the patch
>> now it looks more in order to me.
>
> This seems like a good change to me. There definitely is a general sense
> of "more complex things should come later" in the test suite[1], so
> preserving the existing ordering seems reasonable.
>
>> If there is a reason to have 2 separate spaces for clone testing,
>> and I missed it, we should document that why it is important to keep
>> them separate.
>
> It looks like it was just carelessness from long ago. 5600 was added by
> 5508a616 (Feb 2006), and then t5700 in cf9dc653 (May 2006). For the
> later ones, everybody probably just found or the other and built on top
> (some of us even found both at various times; looks like I added t5708
> in 2011 and t5603 last year).
>
> I checked whether there were any stragglers in topics in flight with:
>
>   git log --oneline --name-status --diff-filter=A origin..origin/pu t
>
> but I think we are good.
>
> -Peff
>
> [1] I actually don't think the test ordering matters all that much. I
>     guess if you run the tests directly from the Makefile, it will stop
>     at the most basic test that fails.
>
>     Personally, I run them in longest-to-shortest via "prove", which
>     helps parallelism, and gives you the full list of failed tests.
>     Which is often a good piece of knowledge by itself (is it just one
>     test, or did I horribly break some fundamental part of git?). And
>     then I pick one of the failures to study based on what seems simple
>     to debug, and/or the area I've been making changes in.
>
>     But I dunno. Maybe other people really do care about the order. It
>     doesn't hurt to roughly follow the "simplest comes first" ordering.

Talking about ordering, I have two use cases

1) Before sending out patches: "git rebase -i -x make -x 'make test' <anchor>"
  to catch myself for doing stupid things.

2) When developing new code, I alternate between running an indivdual test
  "cd t && GIT_TRACE=1 ./t7400... -d -i -x -v " and running prove for all tests
  to have a good check if there are other niches I missed.

So I do not really have strong preference for the right order, I even
thought about
omitting the paragraph from the commit message and wanted to put it into
the notes below, but then I figured I want to record it as I was
frustrated about
the commit messages from 2006 as they don't answer simple questions like
"Why did you use a different second digit?", so I figured if anyone digs up my
commit eventually I want to record as much of my current reasoning even
if it is minor to help a future developer?
