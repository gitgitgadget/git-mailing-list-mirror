Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCD11F404
	for <e@80x24.org>; Sun,  4 Mar 2018 05:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeCDFgt (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 00:36:49 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36305 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeCDFgs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 00:36:48 -0500
Received: by mail-qk0-f195.google.com with SMTP id d206so16965438qkb.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 21:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZzcDSY3YrWeDUzZh2j7UbZG6e94Yq5Qee6WScswc9Og=;
        b=lpfcnlggW5RpQp88gbmVpjUWukrw86F0riFyJzJIE4MWO4xsnVj3pATSU+Qef8GnYm
         e8f9R7JF0IKwjDP3jVH5uMOEU3sa0cHeypQOBf2/6OaAYD3vzVVWZgwS3YAXS0Aisb4J
         ZAXWo4yP5JZw60hOnsAE5/1rwLAuBQfZTHiT7Vi3Qb4VqnwUQG8EeHSm2VjWFi/naI6Y
         pgRnlyK0dgbZa+7XT1mvO/25e+gGEP9/Y4jT8Emz1D0s1eSMF0DZgPn5cliVNjbCveKT
         5ND8IF9XFFrMOlHVBM5ChlycybpFDa9HCCNcNdssLd5TmrY/HdRjD9vJ1sTEgxJKzU//
         IdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZzcDSY3YrWeDUzZh2j7UbZG6e94Yq5Qee6WScswc9Og=;
        b=fJfVllTpCQRcPeYpUbhqgllNwDTiPSX04MBCYXPQ3q9IWOKygBJzPzzTJSxg+Sky9D
         og4n8P/vvg17nXq9u6wKxVniu0eOpZkeyKqnXcW/+J3Le6AAJfeD9WBKf1LcfSjGFs4L
         LVzj6C5FYfINMHDkwcb2AAcmb1hOVuDcpXFBFTUU4lmOwr2hSOtweLicJ8oVbS5UKzeF
         /dzWnabRzNjFB5qgtjgtJ70fLBZqnAl6R1ozlHIvcvFhrknqZjikz/aiCJFArJnOI7lM
         vJjAt4eg5IYr7Aq3jDL8bycLDf8kHXsnlY301wrJZy6DMpCyfplnVofpdmqnGjQx4a54
         PfUQ==
X-Gm-Message-State: AElRT7GI9ltMJtg8rrqY18n4+ARRcYApTFDa9SNcr2EatKyvgTRm/P2i
        Kjqpk6ER/l8RcwiL9Yrz09xbVG9djpW3PvCsnxg=
X-Google-Smtp-Source: AG47ELuszC2UFQqvA5iLd54z95oDf+01FA8/MXudtp0xIZWMnYtmPBe9UCVOtir+C6oxO+Te+oWpe7i/yATMtD7NIQY=
X-Received: by 10.55.203.67 with SMTP id d64mr15537088qkj.210.1520141807628;
 Sat, 03 Mar 2018 21:36:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 21:36:47 -0800 (PST)
In-Reply-To: <20180212094940.23834-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180212094940.23834-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Mar 2018 00:36:47 -0500
X-Google-Sender-Auth: 93cnbn7nVUq9Op_fwiKI5arrHXU
Message-ID: <CAPig+cT88ZsD4=U0NUPM2=sv43gxFEf7ivxu1zMHr0gsMGdTmg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] nd/worktree-move reboot
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 4:49 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> v2 basically fixes lots of comments from Eric (many thanks!): memory
> leak, typos, document updates, tests, corner case fixes.
> Interdiff:

Thanks, I finally got around to doing a full re-read of the entire
series. v2 appears to address all issues raised in my review[1] of v1.

I did find a few minor issues in tests newly added and revised in v2.
However, since v2 already migrated to 'next', rather than pointing out
the issues as review comments, I instead sent a patch[2] (built atop
nd/worktree-move-reboot) to address them.

[1]: https://public-inbox.org/git/20180124095357.19645-1-pclouds@gmail.com/
[2]: https://public-inbox.org/git/20180304052647.26614-1-sunshine@sunshinec=
o.com/
