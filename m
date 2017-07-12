Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B8420357
	for <e@80x24.org>; Wed, 12 Jul 2017 21:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754329AbdGLV3i (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:29:38 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:29173 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754228AbdGLV3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:29:36 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id VPCQdRWdx23YCVPCQdojQc; Wed, 12 Jul 2017 22:29:34 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=Cob9STwD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=uT3usiLa3QTkdZrSUroA:9 a=6U2dePAeCLcMc06K:21 a=7jjeSjo8S4f7f79F:21
 a=QEXdDO2ut3YA:10
Message-ID: <2A653C761F9D4326800F8223FE316913@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git-for-windows@googlegroups.com>
Cc:     <git@vger.kernel.org>
References: <alpine.DEB.2.21.1.1707092143560.84669@virtualbox>
Subject: Re: [git-for-windows] Call to developers with access to Windows XP
Date:   Wed, 12 Jul 2017 22:29:32 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170712-10, 12/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfP6IB57FHsoBxIS9lDl3u7e2IFAxQy2xlu1E2OaT9tMz8a/w5q5Otd/5ERFqG1lzi/37604Htlmpe8xE/AvHXnyWhnZlOqhHEIm9/pRhrjuu7W7Zcfm6
 G01qwsXl09xCuTkRFATMWh6SC+qy+wU7YhUN1YzXA2DDyy8T2oMSwKkWqKUvFeBjO39cGK5XtEtwf+iOrDHCb72EKLIXOO37FdE21QbmSL1x8ZiYh2TrEtah
 m58oGy/Pqgtfj7yY6EeudQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi all,
>
> it has been a while since Windows XP support has been dropped from Git for
> Windows (v2.10.0 was the last version to support it), mainly due to the
> code changes inherited from Cygwin's code base, which discontinued
> supporting Windows XP after version 2.5.2 (because it became way too
> cumbersome).
>
> Now, as some of you recall, I was not all too happy about having to drop
> the Windows XP support,

Thank you for having the concern. It is appreciated, at least by me.

> but I saw no alternative seeing as it would have
> taken me a good chunk of time (which I have to spend instead on keeping
> Git for Windows working on Windows versions that are *not* past their
> end-of-life) to reinstate XP support, and it would have taken even more
> time to keep it that way, backporting changes all the time from
> quickly-advancing Open Source projects moving away from XP support at a
> fast pace.
>
> All the same, I tried to make sure that developers out there who are eager
> to have Windows XP support know that I am fully willing to assist them in
> getting it back. Assisting, not as in "just whine enough and eventually I
> will cave in and solve your problem for you", but as in "you are eager,
> but do not know where to start? I can tell you all about it, and if you
> get stuck, I'll help you get unstuck".
>
> It has been over 9 months now since the first non-XP version of Git for
> Windows has been released, and all I heard was that some developers found
> workarounds that work for themselves only, without even trying to share
> anything helpful for other developers in a similar plight.
>
> This is not enough.
>
> We are now finally at a road fork where I need to know, soon, whether
> there is anybody out there who is willing to step up to trying to get
> Windows XP support back into Git for Windows.

I suapect that the XP 'community' split into two parts (and not of equal 
size).

The first is those who for many and various local reasons are still on/using 
an XP machine, and would like to keep up with the Git community and the 
coding of Git. This requires only a minimal level of competence in the deep 
OS stuff of Windows compatability. I'm pretty much in this camp.

The second sort are those who for other reasons are involved and 
knowledgeable in the deep OS XP compatibility stuff, haven't progressed to 
the newer and even more improved (as they say) versions of Win 7,8,10 and 
still want to have the latest Git compiling on XP (as opposed to simply 
accepting the last XP compative GfW version). It looks like that group is 
thin on the ground, leaving too many issues to fall though the cracks.

>
> Side note: At this point, I am a bit sick and tired of hearing so many
> opinions that *I* should work on that. So that won't fly. Just don't. If
> you feel the need to whine how unfair I am even while you are unwilling to
> lift so much as a finger to reinstate Windows XP support, just write it on
> a piece of paper and flush it down somewhere. Don't write that email,
> because all it would ensure is that I personally would rip out all
> remaining XP support from Git's own source code, just to rid myself of
> this kind of "helpful" advice. It's not worth your time, and certainly not
> mine, either.
>
> Back to the subject.
>
> The reason for this call is a Pull Request I would like to merge:
> https://github.com/git-for-windows/git/pull/1214. It simplifies Git for
> Windows' pthreads emulation rather dramatically, but due to my
> (misguided?) request, it tries to keep Windows XP support as a
> compile-time option.
>
> The thing is, this code will bit-rot if there is nobody willing to spend
> even a little bit of time on Windows XP support in Git for Windows.
> Meaning: it will add to my maintenance burden, which is not okay.
>
> So my current preference would be for me to go back to the contributor of
> PR #1214 with a profound apology for making that suggestion and wasting
> their time unnecessarily. And then just drop the XP support of our pthread
> emulation.
>
> However, I am not quite certain that I have really exhausted all my
> options for reaching active developers who are interested enough in
> Git for Windows' reinstating Windows XP support that they are willing to
> put in the effort to make it so.
>
> Did I reach you, active developers? This is my final attempt to do so...

While it is still regrettable, I think your initial decision, as noted at 
the beginning, is/will be the right decision. I'm happy to accept that, and 
do thank you for all the effort on maintining GfW, and its XP support for as 
long as you did. Many thanks.

At some point I will have to update my tech, once the family budget holder 
releases the funds ;-)
--
Philip


>
> Ciao,
> Johannes
>
> 

