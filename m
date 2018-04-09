Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6D31F404
	for <e@80x24.org>; Mon,  9 Apr 2018 05:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeDIFIP (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 01:08:15 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:44746 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeDIFIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 01:08:15 -0400
Received: by mail-qk0-f180.google.com with SMTP id n139so7956058qke.11
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9ELH5nRHRwxRgTFfKyX8fX/9eEqn1Ul1q4LYup/cp6Y=;
        b=ZMnYs5NzETcijjnbm1JG5kvG3p9CUoclpFsXt8hwC9DWmffgqp49tMSHv96d1IJUk8
         CDABCIXn6mE9l7hUVTJHMOBDrre7qIlU4xRYRtoqlnx4Fzx8XXE2SrpJFItVmQern84k
         nCVnIt/RxmVj3LTPiYbu6ad4SZ6rtjUPbNORFgoxT65YohQXVzk29w2fPjjZ7ndOX8jE
         eHxbMTQmYTEMWfvv9oqndp+D/phWs16Fkoc0XUdvSUNRSD/lM9Bbiv/af6hQvg/Q0hHm
         lF+ICSzIsNS8/aeWtsWSE7dSQ0zW7tFuHSKB9sHl/2g7RR9tkuwkbqu5g8H5bGOHeejm
         7Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9ELH5nRHRwxRgTFfKyX8fX/9eEqn1Ul1q4LYup/cp6Y=;
        b=iO64Xa2+XR4sLnsubYC6QieRdBmE2mzinov6nQ98zd+84JzMwAlRUwD8dAZtJamHWq
         +Mzvws43GHs/fw+xE3vgyVekoQEqhLYjdO7anQhBPnNHRMp4/ntFCuUiM/C0xWqsm3NY
         vnq21oJyRNT9kG1QNneGseC5WpjqMuyDOrT4BPDYXoYJ9VAVhlW7LXv0ezG1DI1nm9ba
         F2qiaxptvvt9YknLjP3T250B83QCUR++PktxnLBm+e+da69LBgwZt2du0gmarh6ikHvO
         YkZiVqnKyPQ6FWXJ6eQN6BK6oodjzHbklfrdwbz75nK0W5aIqFk3xaXQIUPDzJHity3q
         PowQ==
X-Gm-Message-State: ALQs6tBAOulElfltR4JPd5/AQJV5ZXWGluvIWwJNDpCJhbG6cgCICRD3
        bv87P4dR+C3FdGUzDb89YbkmYab6YVjfrWFTEb4=
X-Google-Smtp-Source: AIpwx49KocNuWLSP2mbyq3DZq4oTAnyOkdQlRGduUpGm3cBEokNqNlOfXppYiZscylLbhuIw3g0tunI+i7DXGhOLeg4=
X-Received: by 10.55.182.70 with SMTP id g67mr46436391qkf.314.1523250494519;
 Sun, 08 Apr 2018 22:08:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 22:08:14 -0700 (PDT)
In-Reply-To: <20180326165520.802-6-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180326165520.802-6-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 01:08:14 -0400
X-Google-Sender-Auth: poOB23YawRUKxG3X5lVdbKA5UA4
Message-ID: <CAPig+cR-WP5z1u-9KG-mNOF0mEUcguMET93O21nfzYixEFWaYw@mail.gmail.com>
Subject: Re: [PATCH/RFC 5/5] help: add "-a --verbose" to list all commands
 with synopsis
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 12:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/help.c b/help.c
> @@ -282,6 +282,67 @@ void list_porcelain_cmds(void)
> +static const char *get_category_name(unsigned int category)
> +{
> +       switch (category) {
> +       case CAT_ancillaryinterrogators: return _("Ancillary interrogator=
s");
> +       case CAT_ancillarymanipulators: return _("Ancillary manipulators"=
);
> +       case CAT_foreignscminterface: return _("Foreign SCM interface");
> +       case CAT_mainporcelain: return _("Main porcelain");
> +       case CAT_plumbinginterrogators: return _("Plumbing interrogators"=
);
> +       case CAT_plumbingmanipulators: return _("Plumbing interrogators")=
;

s/interrogators"/manipulators"/

> +       case CAT_purehelpers: return _("Pure helpers");
> +       case CAT_synchelpers: return _("Sync helpers");
> +       case CAT_synchingrepositories: return _("Synching repositories");
> +       default:
> +               die("BUG: unknown command category %u", category);
> +       }
