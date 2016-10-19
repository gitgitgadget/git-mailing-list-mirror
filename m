Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C902098B
	for <e@80x24.org>; Wed, 19 Oct 2016 14:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934916AbcJSONV (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 10:13:21 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36445 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934868AbcJSONR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 10:13:17 -0400
Received: by mail-vk0-f46.google.com with SMTP id 2so28154007vkb.3
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X0RJ4jjBL1ntcJhiRagfS8CocT/o33cCoiC+3pyHsM4=;
        b=m3DwjjWeCzmYfHDHht1N18/WQQ4gU/xgqwV34TvoYD30iAAO9AbNdDNkSbDgzfLqsS
         UMCzP4BLTWhbPsw5A6Mu9CYqjQE2px0zXCl37fM4kMxr3lhytiPsYt8fwvJRO3j9DEZz
         wHzKRD7AERfNkYLu2WCdCVrH8+IQhSoAQGwnD8W9DHZi9OpQmYwOdca09ZdvdnxKCLFU
         cnhuD2A2/Jdztb4OCTSXg3eekIzWdWLTsl2rxnYasTnc0Y00BDDtltUK1SseBCZ5qLtg
         MsG5y9BJNnrzVXQtxp7Zj74uGSR+vKYcD8xTiLzmnMEvH48fbE5VN4uYQtXDRm17PLZz
         xM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X0RJ4jjBL1ntcJhiRagfS8CocT/o33cCoiC+3pyHsM4=;
        b=FVqGRA5fKQdPRoCB8Md4s+E5UaFRol/Cu0Y/tpGoYZHjdIhg9ZpXRNP9XctzPtwcJC
         tjD4KbaUdMo66r9TaBqFrmCgPKyCaraDzc3t0Bwaqhbozcg4ZDH8Bhg9wYumSvNNVv7u
         NQv7e6RMkudaRAwx5MBlERs8f+MVXhYG1xAVfNSbqKvS3DnJN9LmiQJLeRtatB20c9Yb
         YpGoZPJG6JR+iUfPqlo9w1bU/nHXTD+y68VS/kSrpQR8P98xQ9QM5M+Oe3xxhR73JnCb
         oxEzfCMgkgE2QfEgQu9pbyZxnyyhOY+TtIhWFk757FkkcOsqZaq6cjTvvdKtXiry+aom
         LiIQ==
X-Gm-Message-State: AA6/9RmRliuec6ZnUSChDpRznFIyAFFvVyh7aQBUvIgp+BDvxQiAMGZbp50qRtN2vbyP1Q==
X-Received: by 10.194.148.7 with SMTP id to7mr4531292wjb.31.1476885952215;
        Wed, 19 Oct 2016 07:05:52 -0700 (PDT)
Received: from p2003005f7d2520c048987b75e88579e2.dip0.t-ipconnect.de (p2003005F7D2520C048987B75E88579E2.dip0.t-ipconnect.de. [2003:5f:7d25:20c0:4898:7b75:e885:79e2])
        by smtp.gmail.com with ESMTPSA id j1sm59058382wjl.21.2016.10.19.07.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2016 07:05:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: git checkout crashes after server being updated to Debian X86_64
From:   Raffael Reichelt <raffael.reichelt@gmail.com>
In-Reply-To: <CACsJy8B50daiHWfu7zfVQnn_i_=HbUK3gBPmv1U=EUw7ZyuGPw@mail.gmail.com>
Date:   Wed, 19 Oct 2016 16:05:49 +0200
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <95F58766-9A46-49E2-8E8F-7972D936F5F2@gmail.com>
References: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
 <CACsJy8B50daiHWfu7zfVQnn_i_=HbUK3gBPmv1U=EUw7ZyuGPw@mail.gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.3226)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Am 19.10.2016 um 15:27 schrieb Duy Nguyen <pclouds@gmail.com>:
>=20
> On Tue, Oct 18, 2016 at 10:17 PM, Raffael Reichelt
> <raffael.reichelt@gmail.com> wrote:
>> Hello!
>>=20
>> I have a serious problem with git, After my provider had updated to a =
X86_64 architecture git crashes with various memory-related errors. This =
is happening remote when pushing to the repository from my local machine =
as well as trying it on a shell on the server itself.
>>=20
>> This are the error-messages:
>>=20
>> fatal: Out of memory, realloc failed
>> fatal: recursion detected in die handler
>> fatal: recursion detected in die handler
>=20
> You other mail said memory is capped at 600MB, which should be a lot
> for normal repositories. If you set the environment variable
> GIT_ALLOC_LIMIT to maybe 500MB or lower (convert it to kilobytes
> first) and git attempts to allocate more than that (just that one
> time, not total mem) then it's caught and we get a glimpse of how much
> memory git may need. Unfortunately we can't get a stack trace or
> anything like that unless you rebuild Git from source.

This was no change: crashed with the same errors =E2=80=A6

>=20
>> or
>> fatal: unable to create threaded lstat
>> fatal: recursion detected in die handler
>=20
> Hmm.. with "max user processes (-u) 42" we should be fine because we
> only create 20 threads max. What happens if you set core.preloadindex
> to false? Can it run until the end or hit some other fatal errors?
>=20

This did the trick :) I just repeatedly did a forced checkout and it =
went until the end without errors
THX a lot!

Raffael

