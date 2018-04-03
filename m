Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1CB1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 06:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDCG6S (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 02:58:18 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:42430 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeDCG6R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 02:58:17 -0400
Received: by mail-qt0-f182.google.com with SMTP id j3so18111496qtn.9
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Kp3GWtKo8zttUmQQv5mJK8nod5i+muzunY4Ddk1UBRs=;
        b=SJSyymHe/R2Mzi1P9OgS3MM/f/CivZxMH/vJqELRFv7m0obkFrGD6y9YzuaXkOmNfN
         itoO5A1n8Ssjp1/AdO+l7J0KxfnlcqrQnS5lGUzu7IcMG9i8FCGMKT75Fhqq/0x5qLl2
         T8gPhryhv//Hc4dK4BbdxeVtHKe6hzgja7StQdQA+z8vdKqw/MLGj4lR6mA0IjcbgJo/
         jNlbCRadL6WoJ4uaWfpeQnbk9bNMeRq3LuAzOHSV/lV8CjtjPNHqS7eklHWvkOpWHTRw
         FnxIXLajggskhJlIsK5SJg9zfpLGbyj9IbW9LlVucaSTdSdwDQk3nM4AjQEBOKxYpuq2
         lcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Kp3GWtKo8zttUmQQv5mJK8nod5i+muzunY4Ddk1UBRs=;
        b=hKqGdjizZ1HV85vOUp4htjp8vlqD8VNl9ArJeehL/ugRgn0vPCFQEay6vAqxhUlbI8
         Z8VLBQgW4g1etBRKy272oXWc9uECQKCuAchPMoRnhxhBWmaAZJEq9AmJ+MbCD4etXVD4
         hWIQpa5iqpbU3KvQ7QpM919rwF3oZ3zIEajsCgCESdxNG6dj/6nD8/DP5qdct1fHL/Sb
         lFSeRA/5tBIWQ31Jze7BjMGwlgyvn1tSspknCwVjvXMnA3jng+2J2WIA0G6ROuq9B129
         7ByhOt38Fx5g5Px2hvj8CxBLiF+3xnORsehjIPJ1sdAoOJ+SD6Oi/18n4gdj+DjzI7xz
         Y7Aw==
X-Gm-Message-State: ALQs6tDArOZ/ggT8RKJcnMwT919xCUUpfFtHioJfRHR5maW63i4kit+e
        EnRjts9Kd7m/CBsGUpnoGqfgQutTWkio2kJ+Qmcegg==
X-Google-Smtp-Source: AIpwx4++pnjcIWP6r8jVBtnRgEP8N3ToqGnVHe27ukI9rYIx1Qb6vXxC2dej049ZriwpXQtYe7Pu/BOaWuAupPOvmSQ=
X-Received: by 10.237.49.195 with SMTP id 61mr18436505qth.77.1522738696595;
 Mon, 02 Apr 2018 23:58:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 2 Apr 2018 23:58:15 -0700 (PDT)
In-Reply-To: <dfb01281-2ffb-a0ac-a44d-74ccd304a7ea@frm2.tum.de>
References: <dfb01281-2ffb-a0ac-a44d-74ccd304a7ea@frm2.tum.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Apr 2018 02:58:15 -0400
X-Google-Sender-Auth: YtlxmavZ3O_7GEBw1mne04xkRY4
Message-ID: <CAPig+cRTf+WHaSJsLhbPuG0fwd6zkTP_zhwLhB14GdC81xiHRQ@mail.gmail.com>
Subject: Re: Test t2028 failes
To:     =?UTF-8?B?SmVucyBLcsO8Z2Vy?= <Jens.Krueger@frm2.tum.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 2:33 AM, Jens Kr=C3=BCger <Jens.Krueger@frm2.tum.de>=
 wrote:
> *** t2028-worktree-move.sh ***
> not ok 12 - move worktree
> #
> #               toplevel=3D"$(pwd)" &&
> #               git worktree move source destination &&
> #               test_path_is_missing source &&
> #               git worktree list --porcelain >out &&
> #               grep "^worktree.*/destination" out &&
> #               ! grep "^worktree.*/source" out &&
> #               git -C destination log --format=3D%s >actual2 &&
> #               echo init >expected2 &&
> #               test_cmp expected2 actual2
> #

Thanks for the report. Can you paste the relevant output (which
should/might include an error message) from running the test with:

   ./t2028-worktree-move.sh -v -i

and show an "ls -l" of t/trash directory.t2028-worktree-move
directory, as well as paste the content of files "out" and "actual2"
in that directory?
