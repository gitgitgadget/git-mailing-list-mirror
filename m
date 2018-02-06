Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955341F576
	for <e@80x24.org>; Tue,  6 Feb 2018 09:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeBFJHG (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 04:07:06 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:42085 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbeBFJG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 04:06:56 -0500
Received: by mail-wr0-f169.google.com with SMTP id 41so1065272wrc.9
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 01:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bv+X9quRIS8lVWdpmXvjboq6vYnUUmcpD479vr5Agpg=;
        b=XmRpqZVC//5RO/euRd2yqSXNL306Vh0Nb6MoTNgw6UCw0VGUPJLnvDrwJFFmyyG3Cw
         Sksv5w5IJMq59mDqP5gCn7Hx9howo6XBttHZhIaT9lk+duRHjqGF+QmECCLLRChoiKFq
         0Id5Ods3gFQDaFSp1ulV6SWKWpG9t0H8Nfi8CuXuIIA9/uhBfapfFo9eyVLJLyij1cD2
         04y6p9WfSDXqGOj4zeBhtYSPoGqb/8aL0AeotKsEmVUwCYnKYAJehOr62kQx8TiFJZZY
         2LuN832CZn9ANbt6xM1t5eUtuaU2JVDu9iY1sb4tYLOaCCOcToMzBUaYO/aPKM8mk4iJ
         yK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bv+X9quRIS8lVWdpmXvjboq6vYnUUmcpD479vr5Agpg=;
        b=YFkxSI3rPHOWpacsEkRxH0iZA5fYTCU9PN9rTNK0Scpx0cUOkz5PdNx3KRTayz2frl
         80ZlR1fX1230WB6XYFQg3Wk/q+wzs4x6hQhneooGnuPEbmQt8MSXZw9sAPv8qB7/l+KC
         lE6tGM21nlWFiC3dcxoiOwSkqtRsaFFeM0hPz+naKUF84c0DKAQ1+oUoSTQIq99nPGQo
         sZgd03StpCtyM4va1t0UPuamPvitfFULdpI6adYv2+WfXxppDfF4JXDrj9Yak73w9YXL
         G0mxlhy00QaAdytAQKkdoneVKLsF3roeeokcmH8gyVY4ll8Qg762+X03VI7qRnNcu29V
         kghA==
X-Gm-Message-State: APf1xPC770t+gQdB46N9ru2oFukkoqdv3w5QNgxFAn5JOXIy5luLakzq
        KiZqV6pmGlHtgAq6mAUF2c6M6d15
X-Google-Smtp-Source: AH8x227NoFiipZuQIDOZ2UiBFecp2T2cBGMiOMJen3rGBcP0IQZPz5Gr8UDLsG2wT4la+WDidGNkWQ==
X-Received: by 10.223.128.227 with SMTP id 90mr1272437wrl.50.1517908015216;
        Tue, 06 Feb 2018 01:06:55 -0800 (PST)
Received: from [10.32.249.220] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id v5sm8741766wra.94.2018.02.06.01.06.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Feb 2018 01:06:54 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/2] minor GETTEXT_POISON fixes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180206084226.GA26237@sigill.intra.peff.net>
Date:   Tue, 6 Feb 2018 10:06:53 +0100
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA353B2B-A5D1-4E2C-A016-38066F611BDB@gmail.com>
References: <20180206084226.GA26237@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Feb 2018, at 09:42, Jeff King <peff@peff.net> wrote:
>=20
> I set NO_GETTEXT=3D1 in my config.mak, and happened to notice that =
running
> the tests with GETTEXT_POISON fails. I think this has been broken for
> years, but I don't generally play with GETTEXT_POISON. ;)

On Travis we run GETTEXT_POISON with gettext installed.
What do you think about an additional job with GETTEXT_POISON and =
NO_GETTEXT=3D1?

- Lars=
