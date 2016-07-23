Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12745203E1
	for <e@80x24.org>; Sat, 23 Jul 2016 11:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbcGWLKK (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 07:10:10 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35037 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbcGWLKH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2016 07:10:07 -0400
Received: by mail-io0-f175.google.com with SMTP id m101so125696275ioi.2
        for <git@vger.kernel.org>; Sat, 23 Jul 2016 04:10:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g5y8ZeV7h8GdWM650mvCN86y75t4TVZrXzQdb2esMf0=;
        b=Tbrzg4fkm5uLUIFRteTOz/JQLKubI66tx932FukrIBFPmKvCiUv+RUm8gHyDz2DBd9
         kismHMPfnK/Wd8CKEVms8IM76EGFsYG5F4+0BhlAYx0AOoU+XudVa2KakGte3mFRasFr
         0X80UgrCPC3KFEnqjkfWMEK9MiAIVInEpEbIrUeNtJRnexjn8FGNQDIWmQTG+qJsP8th
         VtHT/csAHrHkHw243jL+GeOth8nEuYG7mEdsrUGZZomr2+iouzVRuhg4RcWf2EDnmXQe
         0YKt4WDKyqGqCEYUi0gcT7pzq4ze98Sti8jrHsdwVCbdWheVNTDi8ILbXzsYT150X4XS
         oLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g5y8ZeV7h8GdWM650mvCN86y75t4TVZrXzQdb2esMf0=;
        b=jmWfJHDAJCdPmQW6Kzk8tiw/cOC64mr5dRa3e/q9BbrPgpnR9P95p6Tjvv54yMutEM
         +y7SLTXzKQ6q/jhV3qs87GK2UmoV8DlvM+c/HorA2YlLWCf/KS5sUpAT9/E8X2FoFgrV
         yFoZM3m3s8prF/qrkzjmCjwM4rRvNbvDvpwB8crMXx8uDtQ9lOFemCIpO8M4j1KNap5O
         +emfD2OFWN11YKSwT8HVXan62yC1tLa/KOMBWqnOgtwW0OyzY3oBfe31JzJGumBchrzl
         FyRiZ9rdP8aF5fhPfTRZp9nb9UZygQUVoiVAUgrABBtAx29bu7dSor3nvmqpanaxGrRi
         Xkiw==
X-Gm-Message-State: AEkooutMhJglhYzCk+p7Bo8z+QyVXpHrpT0WTh90bAr8raoc0sChcjYyZU62aZjPQhL1krGM9W0iqa5Wmca0PA==
X-Received: by 10.107.159.147 with SMTP id i141mr9718223ioe.29.1469272206831;
 Sat, 23 Jul 2016 04:10:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 23 Jul 2016 04:09:37 -0700 (PDT)
In-Reply-To: <20160625075433.4608-1-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 23 Jul 2016 13:09:37 +0200
Message-ID: <CACsJy8Dv=X6Fkqe8U+X_muv4XbsqddiaKo56a+3NZH95CUp2Tw@mail.gmail.com>
Subject: Re: [PATCH 00/10] git worktree (re)move
To:	Git Mailing List <git@vger.kernel.org>
Cc:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 25, 2016 at 9:54 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Now that nd/worktree-lock seems to be on its way to 'next', let's
> continue to review this one. The first 5 patches bring busybox's copy
> functionality to git. The last 5 add support functions and the two new
> commands.

Mostly a note to myself, but also for reviewers in case I forget. "git
worktree move" must fix up all core.worktree for all submodules (or
forbid moving a worktree with submodules until we can do that).
-- 
Duy
