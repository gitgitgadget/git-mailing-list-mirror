Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D41E20188
	for <e@80x24.org>; Sun, 14 May 2017 03:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbdENDwj (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:52:39 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35200 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdENDwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:52:38 -0400
Received: by mail-pf0-f180.google.com with SMTP id n23so42265259pfb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5skCNvxgPrIb8jKYqehnG/zimzEUS1TUS3PBf4WDMAc=;
        b=CGQDUcMgYJqgV6mm27KB+wozvSR6yrnKHVbIDANZR1BFOJThIcme+uagnYDiwjPfV7
         ySCe1tVpsgQ4XxatpuSXc7Je7IZZnhyyPDyaNWXKXGffUIQ3FtJB8vYLePdTR6wGxou6
         nyF8u+i4xjTry42NsjG93CrQtbs3P38uvtl6ykz6pRET1tuZ2CL63lAKT0qmo6R1EQXj
         luXAEctgAKWDcnYMPmg4zf4wLNTEV0WgOf+axX2dYdX34z3DPEvQQYvxgVo8YlWkfOnW
         LhtfOrqF8V2sa0SOYVhc5FJxi/FsgbRgeyrnNVPa5VbD2MWDodE2PF57QR9ijzKgI7eY
         KT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5skCNvxgPrIb8jKYqehnG/zimzEUS1TUS3PBf4WDMAc=;
        b=PpH03/3pwqNPgtSy27jDxRU9Gwq0ddpbswN4rrgZrAVZIXK4aw2tvmAdx75tjuSwlO
         3z1DBewuxg5F57/mFJVj4ZUz411bbhk2bUoQXgBs9JLGMtmFSJWce3iad1IHWYlirhs0
         pUpTCYs/upeYVXritt6QPY6ZDUDYoRjwrAoLe/BYdVI0S/zWFklph44KZ3INKcyRIP+P
         FIi4eHgBpPFrWuzrzBkMhy81fSTTZTV83oHVHU+HPaI8RqyEPx7CR2/nvkfNbFFb5cfn
         k+eUyvRCsOqGiiRJlGhQ3aaJLsxSsyTaoIXTKJ0iHmH4eCjqeXKuXIEYlxyIkgtGFPvk
         JaNg==
X-Gm-Message-State: AODbwcBn8+MtLvLP1WH8z3VTQHoCgxaF+QL+wh4iLzoRY4puRFXyxLpQ
        iB3I5DnbtReWiCgNu2qPUpRNPqgg92f6DLOAhg==
X-Received: by 10.99.188.9 with SMTP id q9mr11946606pge.178.1494733958081;
 Sat, 13 May 2017 20:52:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Sat, 13 May 2017 20:52:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 13 May 2017 20:52:37 -0700
Message-ID: <CAGZ79kYACtA_q6kJ=gGYe02H-a9g_GV=kKLn8jy2ZZKvjxGYNQ@mail.gmail.com>
Subject: checkout -b remotes/origin/<branch> should not work
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NEEDSWORK:

checkout -b remotes/origin/<branch> should not work, unless force is
given (maybe?)

(I just run into that, now I have a remote tracking branch that points
at my detached HEAD. Oh well.)
