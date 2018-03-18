Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D291F404
	for <e@80x24.org>; Sun, 18 Mar 2018 02:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeCRCcW (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 22:32:22 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36986 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeCRCcW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 22:32:22 -0400
Received: by mail-qk0-f174.google.com with SMTP id w6so2060744qkb.4
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 19:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HeOtZq4TdmdlKodphOHf/1NLcL/AdXZZY3dfNQDZSTg=;
        b=ibqh7HwZoUU6vgsD/Jp0ZTh05O6r5KvNz2smBx4jrVeS1KyYQ2eFRTxH/mBCw8V2Co
         GAUiMWlS8gGtxYxmx/r4JOipADl+EUlvFoBFORbpJjQGasvFU0znIXkBIk7M105EBogb
         2vM9I+7EDzLsTcNCnSXXwjRQMG0otBDfU6Cyix0aqT8EUmyqUAFQ1RdTpxnm9XW2RJeO
         b4Yyrkxyypu2uHh/QAIKSpHxKtrYynqibSDmY7tKHDCsrjxnjaUXlBMFKKhHm/ZcNbgj
         5QeVJFM3wiAg02mj/KinuLq5xUIspUG/SwnTpC9h9xiaVD6DJrmt1IFe0ucSaeX3C/3x
         w4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HeOtZq4TdmdlKodphOHf/1NLcL/AdXZZY3dfNQDZSTg=;
        b=AhqH/e9dORK6/AxG4uDMECDD0voKRTx9dVGHit2uj7Blfs5vMKtk4gnrlY5ZNrN4DM
         UQWVuXV9tQuF9db7Z6PJDgh/TwzI3AToGSYb74fIjn6yLNmvAquh0XGfGE0wteapId5l
         flygWgLofwROXPiiZFFZqMkoZwvoX+yiQQ2yFADdL5IZsVSkUIGzxZPgzleHrvT9U0TT
         xzlBHYMscdGLetB+QODj9ftqUY9gbFBHkfgxS7ncLMYrAMRmx6Q4+ZacV7TtfdQdkLV+
         jzrGGp1cfXpXPpvq42tERi8sqsD5rCJphOuLn87M691+EPhwTHsk3zvqcSKU3OTkLOPL
         b4Wg==
X-Gm-Message-State: AElRT7EHQt83tj2k0oIS1jmLN6GHbNAMV2F1wylMmwVnzTLyt4zWybUz
        C1qv9ekNi23GaUd8kW2K0YUKo5GWcknw0EdiFtifXA==
X-Google-Smtp-Source: AG47ELsCSyf2Pa5QCtBfob0HNOosNR5PaOaX1XH8BGzLkRG/CB4j8aYIvEpURGNcG2WF77pVV+HbWuyYydF4iA0Mbjk=
X-Received: by 10.55.22.28 with SMTP id g28mr10961051qkh.152.1521340341276;
 Sat, 17 Mar 2018 19:32:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sat, 17 Mar 2018 19:32:20 -0700 (PDT)
In-Reply-To: <20180317075421.22032-35-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180317075421.22032-35-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Mar 2018 22:32:20 -0400
X-Google-Sender-Auth: F2azaGmdmLDayRMHxCSAUFo6-gk
Message-ID: <CAPig+cQXiVwrUroYqjeST3r4kwnLri=9xSrGAq+ksEeF44=HZA@mail.gmail.com>
Subject: Re: [PATCH 34/36] t/helper: merge test-urlmatch-.. into test-tool
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 3:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> t/helper: merge test-urlmatch-.. into test-tool

Spelled out fully:

    t/helper: merge test-urlmatch-normalization into test-tool

needs only 58 columns, so is well within the 70-72 column
recommendation for summary line.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
