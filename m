Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AE81FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdBHUZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:25:24 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35994 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdBHUZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:25:24 -0500
Received: by mail-ua0-f194.google.com with SMTP id f2so13793352uaf.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 12:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=36LkBtvAVxM7ahFH8NwtuPimFcsRSgX3NdcSv9EfkAA=;
        b=KqvLW60xULAGgWBByqoZGFxfPUIzRdHIvgO5gsuaaeRL9QSp5EnWlEVGiQwwm8K2mH
         YWTH2mB0Tdy9w6qunTmbni5Z7osabjNq3uBgOZwihkyWK9DMP3VngcQjdjANDC+NFT1q
         vw7e9vyszcAXXegxbd7v7a47o5AP2BY50XlPiJGwFiOL71269RCOjcszhRsXQw/Shehv
         a1y2mIIhflFoffrFbLYgDBke/1bD44ul2mPGehkgeSOdYtVJVfCEmRi6d4IWrOW4tzsW
         UauIxygVPoPUjAkPszCFZBZ1IV/UAlpN3k5ER5pNYjLFGwyEp+YYCG62AM86JyEn10m/
         epIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=36LkBtvAVxM7ahFH8NwtuPimFcsRSgX3NdcSv9EfkAA=;
        b=OngoB6sJpgMrRzWan58coFc2yFlklkoMTIF+Vkn3AIuXX+v+DcL0LQHhoph9TrYJKf
         jkFEmc9CGIftDBNjaHvbHTvo6150WV0SEKENYRpLoo3LDqy3Gfc42wX+oKqGrBxUNIRg
         T49HA6yf4o3hBGLKLFHfklCuo58icJalRITGpdi70F1J2Ub0oH+CqMpkvY0Z/P7HtjMX
         JAbBWtXZzxZK4GKzI5COtjEwlsveLMAzzG+eywaf2REPCQ/Pu24Dsc7H+jTUdCIjyLDy
         QGre56IZMtw3VBCjqutHDowsK6Rvars+knnqcdKZdQVDYsnw0zSSflTMCh5OQfaKzjFF
         2jtw==
X-Gm-Message-State: AIkVDXJW/JtXISLz4ZXLAyuLGINxRN2xmlarywAHkNcA3Ut4vOkAD20I5qa3TV2QXxQWhIkb8Tv6z6zV7Jge3A==
X-Received: by 10.176.2.99 with SMTP id 90mr11816364uas.63.1486585513071; Wed,
 08 Feb 2017 12:25:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Wed, 8 Feb 2017 12:24:32 -0800 (PST)
In-Reply-To: <1aa20b4e-782f-a650-eab8-51218b838337@web.de>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de> <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 8 Feb 2017 14:24:32 -0600
Message-ID: <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Jack Adrian Zappa <adrianh.bsc@gmail.com>,
        git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows 7, it works for me in both CMD and Git Bash:

$ git --version
git version 2.11.0.windows.3

$ git diff HEAD^ --word-diff
diff --git a/test.natvis b/test.natvis
index 93396ad..1233b8c 100644
--- a/test.natvis
+++ b/test.natvis
@@ -18,6 +18,7 @@ test


      <!-- Non-blank line -->
      {+<Item Name=3D"added var">added_var</Item>+}


      <Item Name=3D"var2">var2</Item>

On Wed, Feb 8, 2017 at 12:37 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 08.02.2017 um 18:11 schrieb Jack Adrian Zappa:
>> Thanks Rene, but you seem to have missed the point.  NOTHING is
>> working.  No matter what I put there, it doesn't seem to get matched.
>
> I'm not so sure about that.  With your example I get this diff without
> setting diff.natvis.xfuncname:
>
> diff --git a/a.natvis b/a.natvis
> index 7f9bdf5..bc3c090 100644
> --- a/a.natvis
> +++ b/a.natvis
> @@ -19,7 +19,7 @@ xmlns=3D"http://schemas.microsoft.com/vstudio/debugger/=
natvis/2010">
>
>
>        <!-- Non-blank line -->
> -      <Item Name=3D"added var">added_var</Item>
> +      <Item Name=3D"added var">added_vars</Item>
>
>
>        <Item Name=3D"var2">var2</Item>
>
> Note the XML namespace in the hunk header.  It's put there by the
> default rule because "xmlns" starts at the beginning of the line.  Your
> diff has nothing there, which means the default rule is not used, i.e.
> your user-defined rule is in effect.
>
> Come to think of it, this line break in the middle of the AutoVisualizer
> tab might have been added by your email client unintentionally, so that
> we use different test files, which then of course results in different
> diffs.  Is that the case?
>
> Anyway, if I run the following two commands:
>
> $ git config diff.natvis.xfuncname "^[\t ]*<Type[\t ]+Name=3D\"([^\"]+)\"=
.*$"
> $ echo '*.natvis diff=3Dnatvis' >.gitattributes
>
> ... then I get this, both on Linux (git version 2.11.1) and on Windows
> (git version 2.11.1.windows.1):
>
> diff --git a/a.natvis b/a.natvis
> index 7f9bdf5..bc3c090 100644
> --- a/a.natvis
> +++ b/a.natvis
> @@ -19,7 +19,7 @@ test
>
>
>        <!-- Non-blank line -->
> -      <Item Name=3D"added var">added_var</Item>
> +      <Item Name=3D"added var">added_vars</Item>
>
>
>        <Item Name=3D"var2">var2</Item>
>
>> Just to be sure, I tested your regex and again it didn't work.
>
> At this point I'm out of ideas, sorry. :(  The only way I was able to
> break it was due to mistyping the extension as "netvis" several times
> for some reason.
>
> Ren=C3=A9
