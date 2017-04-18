Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7621FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 14:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753687AbdDRO0p (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 10:26:45 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34186 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753712AbdDRO0o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 10:26:44 -0400
Received: by mail-ua0-f170.google.com with SMTP id h2so65138602uaa.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mAsMNCarg3mndwcls80g9JwwwDH/M986J5IK3B09/dw=;
        b=qS8+Egh0gEgYhXDxu84l13Y4fYneYBbgWq/AKV5VozZXUlbgExU8sGwCGlpEr+bOiI
         i0mm1rA79SeudIGCIrWL4jI2zqTpjgyUs2uHVIGl59ypYRMz+J8F/UoFsdTypnYP21dH
         wC1e5YkDZCmvI1y4dSjh2Mk1u9FGMSwD+Gs20cg0KCyMSWaGhw/JtgMYsTDngZPoNvM+
         dU8k0F25KB28eTb3Xq861zkq4hUnaSQC796ZbUMT1SSezjS0nW4nQPoonB2g5X6U+GeD
         gtKIJBL7hDdDtq+we0lw9AotCN9LgmrK+z+kwijyLpF+BV8nu2iGmGblffdp1AUsZisM
         mTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mAsMNCarg3mndwcls80g9JwwwDH/M986J5IK3B09/dw=;
        b=T8hTAD17IHfBIrbTSVZViS9loeQeB9ee850YcM4ncgpFpI4/HtjjWH3JZ53V81NEAd
         DDphSS2LJMfFKdGHdTJQv1tpPZdSvPMSkJIamgoSkF6sJBdMfMDCMa7cWa7FQn3E/NpX
         k8JzJ6x9fB0xzX3M82Cqarhmezcmlk3DhcVb/64D8AArPDtS+g79SWqjZFdvhL4bo5Xr
         LN+XzWovifUTd89L0f0YBo9sTqjjfEA8Gm5CBT/kFpQT8pCN2BOiVv0ZNFCVva8ll2Wh
         pAusQB5xHAfYJ13eo9S827wfzJvA5uk6jaGfQsd5lIdSubassXT/LH83weWdUCqPMuX1
         jTyg==
X-Gm-Message-State: AN3rC/481FbQ7hord9VRi3/JKWEInTJWrkgeAZOwg/H7B3HzgedFkegU
        Izy/O38/9ALa0quVK7mazEiuFyXpQvWk
X-Received: by 10.176.71.227 with SMTP id w35mr1147520uac.101.1492525603069;
 Tue, 18 Apr 2017 07:26:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.24.95 with HTTP; Tue, 18 Apr 2017 07:26:22 -0700 (PDT)
From:   Max Ivanov <ivanov.maxim@gmail.com>
Date:   Tue, 18 Apr 2017 15:26:22 +0100
Message-ID: <CALQ-8C+9dzM0cNCrK-DGiu8fc=UsS11OZbwhXWh_CDGOeGnECA@mail.gmail.com>
Subject: no MERGE_HEAD after octopus merge failure
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I am using git 2.12.0 and it leaves no MERGE_HEAD once octopus merge
failed with conflicts. Is it intentional? Files have conflicts markers
and once resolved `git commit` creates just a normal commit, which is
very inconvenient and confusing.

Thanks
