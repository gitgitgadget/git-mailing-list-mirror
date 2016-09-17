Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3381FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 17:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbcIQRr4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 13:47:56 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36333 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbcIQRry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 13:47:54 -0400
Received: by mail-wm0-f41.google.com with SMTP id w84so11820978wmg.1
        for <git@vger.kernel.org>; Sat, 17 Sep 2016 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+3KD0gwVrt1chfaBvS+GMGT4kjO715qXmJethpGDUp0=;
        b=t9kk4SF39R7CvvKM9eAkvlEbVJ/UpD+BS1oJnK9lvB19Dk5PXPVvxyqoLBmknJ+8S+
         1TuYBMv0EldPL1leKKa2XvHOrQ71O+v9Ec8zpLxXWY63bAaLlUze2yhunFkaDxHg17OC
         9/8E6BymaFh7tUklnFNTIz0Op78kvd6C4gcirwRuu9O5jntOcoGG2hmHSivcconbAtNg
         XC1q8yDp0hknMb2TfoPlLWTcAJwSWf39AzClDOxm3ZwQpQQL2RfxtDMJyEYT3jy5rHM0
         ny/KTwyN/EB2Wtk4rqbse1IV+3EiXRmu9dZLrICks/RMsyVyL5sVefFgXLMkzgWyIsZN
         0p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+3KD0gwVrt1chfaBvS+GMGT4kjO715qXmJethpGDUp0=;
        b=JllV0mwxo/y5NLUYwUqy25Yyk5VwQlyes5sOvt04sbAEot/PbjONsEjAjKaCVAo0oR
         Dtld3T/KCjwpwz/3RLFPofhIGwJFq/2sPV/rWXqA+lmJ6g+0jbUawns3UBkfmhA6vndG
         Fp4Ncb4swK5wo4uB9tueeVqj4gExM2c8HhPOdpjk8rRG3wFzDdeTRTZg9UYrEfmFe0J9
         Zqgq2C2JMVSoFhwV4+47QOG0VUsH6gji3VIkbPcVIe0JK2jOuFf4gaHM5Oi5Z4kVccE0
         hL6cyun6X1dd8Slri8VhElTnAN+bw2HYSUw88bciQubPohxtn1JO0tOO8ByQqLkUPeIT
         jJbA==
X-Gm-Message-State: AE9vXwMdDsKQdSrauIdPz1dkqx+wD9SXd1hwgSAKSBw9e+KoGKMuBNtrKamKiUyBzExcTlLDPM6/t64BfSYaKQ==
X-Received: by 10.28.132.71 with SMTP id g68mr2479756wmd.20.1474134473151;
 Sat, 17 Sep 2016 10:47:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.71.92 with HTTP; Sat, 17 Sep 2016 10:47:52 -0700 (PDT)
From:   Andrew Johnson <ajohnson388@gmail.com>
Date:   Sat, 17 Sep 2016 13:47:52 -0400
Message-ID: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com>
Subject: Why are there multiple ways to get the manual in Git?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was curious as to why the developers of Git decided to have three
methods to get the manual for a verb. I am a developer who strives to
understand Git to its fullest extent, and will share any information
given on this question.

While reading Pro Git 2nd Ed. I came across these three methods:

$ git help <verb>
$ git <verb> --help
$ man git-<verb>

I tested all three to confirm they were equivalent.

What was the motivation behind the complication, if any? I presume
most developers would not provide multiple commands that do the same
thing for absolutely no reason, so I led myself to ask this question.

Respectfully,
Andrew Johnson
