Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C891F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 21:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdBDVRO (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 16:17:14 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:36225 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBDVRN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 16:17:13 -0500
Received: by mail-io0-f174.google.com with SMTP id j13so41851879iod.3
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o+Te/oVx+g1eXgqs6fgW7goxAi+I8ClMV/8PfPtTOic=;
        b=T/t90sLCiT3onSzsg2lJED2O0GHCAEwth9Tuf/HbGP5o6VtZImlvVlKBRuAqzdU5W9
         0VB2l1Di6n73vuvAGHocQMJQAxgLYNSwk7BidkelPif52iES4IibDdydpfmGVOio41pX
         /htQoh3e57PEHpds4TRPPxrf6nGhZZY60jOiwp73BmiYYhDBHg24FrpC8xoE198HEs6v
         fJwobq1xODMuGg7wxvBCVE3afifenRkerSHw9N4SG3V++wToHT4Y5rWzbI+XcfCqAq9b
         ic8XVVMvQVfjia2Y5xqhfmL218oG4BQijRcFuTcKrmtoMS63DmP+N6hEnPHWAqjsdKLC
         sDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o+Te/oVx+g1eXgqs6fgW7goxAi+I8ClMV/8PfPtTOic=;
        b=Cb3hLDQff3EK4Cl+C2m0L2apTx1t1b5ztcizcdB8OKDfRlbH0gL7Wg1oZUgzWGH9OR
         H4/WuVoWYhOF8cI3sW8WDg3OXxk9bXb7irqG407gH4L+B4G4pHYYUHKAhGVtXOSQwiRJ
         qsb6iNHEozW8ZV1cmk29RO0JM0s/KwZiJN35NO2v3+QgJF2rCVlpjAcLJL7R4yMIIR7l
         GTV1lCrKj35twKRXCPqPintJHt8Yec3tWqqiFVi+2HbRcWJt0/Z/LB0WzB5ReeZA3tog
         JxCitTVoBTrfeuqg0lcNFAjWpjA2WAsaJLRI8c+RicJQm1G/IQJGjADil95jmvbSCEBB
         evhA==
X-Gm-Message-State: AMke39mSPI44oGJVMEkYepsnMgApa2ExW0vJcAdfeDfyh/D7fVokqYSihyRGV/pGjXLHHTyFP9idehR/thYDdA==
X-Received: by 10.107.182.214 with SMTP id g205mr2727143iof.120.1486243033119;
 Sat, 04 Feb 2017 13:17:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Sat, 4 Feb 2017 13:17:12 -0800 (PST)
In-Reply-To: <CAGSZTjLmYCyKZ1BBRv+JVYq4oX7EQcNzyxAnS_3NBUPjr3g8zQ@mail.gmail.com>
References: <CAGSZTjLmYCyKZ1BBRv+JVYq4oX7EQcNzyxAnS_3NBUPjr3g8zQ@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 5 Feb 2017 02:47:12 +0530
Message-ID: <CAFZEwPOFDT7=1qhg4ygJpVUnfQo3XUjDoNtZ4LJvG5V9+RDNwA@mail.gmail.com>
Subject: Re: feature request: add -q to "git branch"
To:     Kevin Layer <layer@known.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Kevin,

On Fri, Feb 3, 2017 at 11:59 PM, Kevin Layer <layer@known.net> wrote:
> It should be possible to quietly create a branch.
>
> Thanks.
>
> Kevin
