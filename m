Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C03207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 17:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756156AbdD0R6P (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 13:58:15 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34250 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbdD0R6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 13:58:14 -0400
Received: by mail-pf0-f177.google.com with SMTP id c198so33855716pfc.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N1zgjTskok1ZTbb+RWdcju/Bc83NJkWBKKVN/w7tsLA=;
        b=ucOT1mXhjhTB5F7QyusSsksF+jqSh8mHW7CupQDVjIOP2S3VE9wg3P4uWkCtxh3ERv
         c4S+xBUQAiUHw6orPFxgrrqjFhgm+gIitBUvgPwY+DP/mKYidcwV0dIMvVrgGEASddKK
         Qt5rvpdD+PYNKwtDIHCde7spwDRrT1+zwJ02AaTGfGta2jCTpIqGtLCOPf8gSl+N3azl
         fEAvODP8ULf/93UCoXG0aU5tuFyW2+cMijJdbRDnoz7pfNlWZzChk2sTb6l0B78rK3oz
         HMiaTvSl31fir7yV2ScZz2VEM+gUbdEKAflE8kR8ZpMKv017RO8ACUJ76eAwsZdo9Q/f
         rD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N1zgjTskok1ZTbb+RWdcju/Bc83NJkWBKKVN/w7tsLA=;
        b=iHIZLgOGxRGNaUILzXTgug0YGNtjPpKXIbZRhC348nb10G6RJbJ0cF5L5hdbWS9+m6
         oFU/EQAf6M4pSHGnaUYLzSZV25t6RgSp6rr8GSO0a3KIYM2Oa0QaMNUTWJ35UKHG3n1l
         vhEeEXHk7Z6D8NwtgbTw2dCfnHVjS2fi1qRk/Qb3qqaJb57VKOt9868+maN7nSGd5D74
         URCiV3/iQTszIx4jHMrwXcKVgJesnujaqX5GomWHXNBN8xDn97AYxaSvoluOAL3ZmcyD
         wAcjN2UEnMB0DfQuFloh0ykgLFkB63qrhUqM1w7GcvuGsbQF4TpLJ/eHaVpi6xxndIBX
         B3Nw==
X-Gm-Message-State: AN3rC/7+gbo0mWJfaAzmrMayWXTDPSB2PTN60abfvZZDDWNZa1PlAidy
        HINff3TUftKXFS3Iq5OYcwwHEOSrTQx8
X-Received: by 10.98.90.6 with SMTP id o6mr7436587pfb.101.1493315893305; Thu,
 27 Apr 2017 10:58:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 27 Apr 2017 10:58:12 -0700 (PDT)
In-Reply-To: <20170426231236.27219-4-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com> <20170426231236.27219-4-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Apr 2017 10:58:12 -0700
Message-ID: <CAGZ79ka1_eJEa56TU5v++1FKsGY=nvZ4rWBK1begKvqecH17mQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] tests: rename a test having to do with shallow submodules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Rename the t5614-clone-submodules.sh test to
> t5614-clone-submodules-shallow.sh. It's not a general test of
> submodules, but of shallow cloning in relation to submodules. Move it
> to create another similar t56*-clone-submodules-*.sh test.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/{t5614-clone-submodules.sh =3D> t5614-clone-submodules-shallow.sh} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename t/{t5614-clone-submodules.sh =3D> t5614-clone-submodules-shallow.=
sh} (100%)
>
> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules-shall=
ow.sh
> similarity index 100%
> rename from t/t5614-clone-submodules.sh
> rename to t/t5614-clone-submodules-shallow.sh

Thanks for formatting the patches with rename detection. :)
The rename looks good.

Thanks,
Stefan
