Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B221F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbcHOUYK (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:24:10 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33474 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbcHOUYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:24:09 -0400
Received: by mail-yw0-f193.google.com with SMTP id z8so2719096ywa.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 13:24:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=8JAY6LpMdAsaEuRHMlm7+naJy8rpu9LoVnOrcsGwjpU=;
        b=nOP0wvxex5Zg58aJ86QVHEVc0/v74nIqTWjwUSUQqD85WxwIWh7eKPhUGXgipdNpI8
         htj/NZxyWcA9xx+FUMiDNksaJ9q0Ptu8+zXmiFOg7eKVk21rq521EEYyTTYTnP+fmB0T
         9VB5WSbVV/Sa5feHd7dsryrouaTKG0SScTukow/NeNF7ifeeXaD6A7u+O+Fg2GV6vF96
         Gb7ON8ObNgF2yvsI+DfnenCk0cfCywC+xu0iXBGmBLOQm26ewtE5Yr3heSpmpDfu61nU
         j+k7V8otW3Pn6iWydYgP8DFtrHKqlCg4PfUOEu1dCfEcSSUdcUK2UeEClIdbdxjbUC08
         FXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8JAY6LpMdAsaEuRHMlm7+naJy8rpu9LoVnOrcsGwjpU=;
        b=YhFyGxIHYvg0to0kc88yUMq3zXKIzJVq4w2R3GQJcVcQb6m4q2xk99GiJ/ATu/1NYL
         SIDXoWsv/B43uK/UOZvjHP46EYd7gnyve6izoyWYm1wtNn+CAtf4+xSZWC1Y8mWoO+CQ
         S9eNaBIfA/JK3A5krotH/doyJqiHMrC3bX5qrsMHBPFa0+ACjXi08TmPAsRswnC3+HXb
         xSdwo6JhYZOdgn+jU0OBIbOb9aLws7kdhipPpLxU5tsySesrcJk8XBW3oGv/X7hZOU+Y
         0nvf5Ivpv4VLmVNCU13EpOekaltpXBftFGngXzHjTAmaToQhr/iyFKCb0fFWLdwtgJ0P
         Mnzw==
X-Gm-Message-State: AEkoousMqtPGrd0qrtIKLhMxZOfM4TW7u1Fv3m06og4iYH/+ALvke94iASFtNnLI6y6kRhTT/EQvSnbNQuBGYw==
X-Received: by 10.129.152.88 with SMTP id p85mr21628303ywg.261.1471292648659;
 Mon, 15 Aug 2016 13:24:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Mon, 15 Aug 2016 13:24:08 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Tue, 16 Aug 2016 01:54:08 +0530
Message-ID: <CAFZEwPPQArBXqQ_tyo_-ximDpZfD6YkCiie8zh2UA2bHcNyxDQ@mail.gmail.com>
Subject: Re: [GSOC Update] Week 15
To:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 15

=============== SUMMARY ==================
My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.


============== INTRODUCTION  ==============
The purpose of this project is to convert the git-bisect utility which partly
exists in the form of shell scripts to C code so as to make it more portable.
I plan to do this by converting each function to C and then calling it from
git-bisect.sh so as to use the existing test suite to test the function which
is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>


================ Updates ===================
Things which were done in this week:

 * I have converted bisect_start() and the bug has been eliminated too.

 * I have converted bisect_next() but still has some bugs. A notable
   problem is that the bisect.c code uses exit() statements and `trap` in
   the shell code for cleanup with `bisect_clean_state()`. So as
   suggested by Lars, I intend to use `bisect_clean_state()` along with
   die() as cleanup (or goto preferably).

================= NEXT STEPS =================
Things which would be done in the coming week:

 * Resend all patches rebased wtih v2.10-rc0.

 * bisect_next()

 * Following that I will convert bisect_auto_start()

 * Then bisect_replay().

=========== My Patches (GSoC project only) ===========

 * My current work is sent out to the mailing list here[2] which contains
   the whole conversion. Please don't merge the previous patches to next
   yet. Junio has requested me to rebase it on v2.10-rc0 so will resend
   it. Plus there are some change in the patch 04/13 which change the
   location of the function `bisect_clean_state()` from
   builtin/bisect--helper.c to bisect.c .

[1]: https://github.com/pranitbauva1997/git
[2]: https://public-inbox.org/git/010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com/

Regards,
Pranit Bauva
