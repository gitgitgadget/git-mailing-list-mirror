Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74A31F858
	for <e@80x24.org>; Thu, 28 Jul 2016 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbcG1RPn (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 13:15:43 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36836 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161010AbcG1RPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 13:15:43 -0400
Received: by mail-io0-f179.google.com with SMTP id b62so105639038iod.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 10:15:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=72s0BEvlX82G/R3htPLosYHlAQOPIVl9HTmbC9Ma4Fo=;
        b=soHrQUDpCnp6QoXqNOU0VEe61Sk0YwtG5PGdPWoVm2jayFF7gxrEaNgq2fiMUadyvX
         pOMuZaTuAdUakt+xKUkHpnSwymdILhVP8dET8iqTayWeN8bjQZbhAfiWiQTa8axomsdk
         YumM+0u73NBmwDAwtqixfp6nZyHAsKdD8b2Wl3ODjA+kn8K8xqCbcTfsaHZLLJdr6tah
         4BagT0Wgs5I4ycmBou3ED0bnfMtMnWJN9tmr6ZGdorKs+606YCF0Ftah0luuFJ1FnqUu
         58pJV/tO7M0qnQxQviAIpW+xlw+9uXy9fLWjduVjF1YqI34ANRW4kkevmUIRhZox1NCw
         YFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=72s0BEvlX82G/R3htPLosYHlAQOPIVl9HTmbC9Ma4Fo=;
        b=fb9mf3+eciexN1Cu6AtBfg9si1efLxqo+rtQxy3T0wuVzmRQxJYYRvQQfsQTTcIXWL
         Ny+qgEePNlm3jRtWQxLnpzPlDVNMtt5+wz2OWBbdK+ic/CAPvsSpqTpjAdmpSSq/qzye
         68+na3Ju2qBYt6mFl5chKB/penCpdinNgcr5xsK9dfzblg2TP06mWhndaApBh1BjmrP1
         vWVggs8uhZQv9qFOd7G99O0reZLRpg2mob1jeUxQyPjlPPDujYc4vLOss87bPDS21ahm
         4eyiXaHw9oOrXNkU/2B2zoeH6ZreDYH/ILRmOwgDEa4P4qiNAYlwwRPHMfdbP3lSrJfU
         zn2w==
X-Gm-Message-State: AEkoouuXK+fg6wGlhdMYgrDiincr6OrfolBuIdTTRcCNu75XqmEly4fydAMAPy7RnAjbxwd10D/KyICa8cyONA==
X-Received: by 10.107.2.78 with SMTP id 75mr39127026ioc.128.1469726142077;
 Thu, 28 Jul 2016 10:15:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 28 Jul 2016 10:15:12 -0700 (PDT)
In-Reply-To: <481D1EE2-6A66-418F-AB28-95947BBF3680@gmail.com>
References: <481D1EE2-6A66-418F-AB28-95947BBF3680@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 28 Jul 2016 19:15:12 +0200
Message-ID: <CACsJy8Cr-=09dDMTNpqobPkcVjU54+b-fLX61+cz2jkS8o+Tiw@mail.gmail.com>
Subject: Re: Alternatives to mid.gmane.org?
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 11:11 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> gmane is down

I read this and thought "temporarily" but apparently it's not [1]. A
lot of our links in the mail archive are gmane's :(

[1] https://lars.ingebrigtsen.no/2016/07/28/the-end-of-gmane/
-- 
Duy
