Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400F81FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdBHUja (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:39:30 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34906 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbdBHUj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:39:29 -0500
Received: by mail-oi0-f54.google.com with SMTP id j15so89177311oih.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 12:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KEX9A5S02eTLANywjAz8Q1TfuoV7jOL6FAEGxGyoKMM=;
        b=Zj63WSPTZBRtplgtTJeC4MhRSPiqfo/J2UmsfNpi7yVikCuYJyJGiN6yvVPqPHTEoI
         t4Fo18whBtMVwp0l0o9z9Y5GZPgCM1eP4NKiVSNHBoZfGFIYrfD6oEhJBrP/2lL38S21
         dMQ5lHENe1uaUy1KXHJDIjQMLAnqPG0nPEgW4I8Eo+7Ek9M6Iu5x38x7sFudXRtQqN+2
         uTHxGpY9sf8VpeskprFEEMf5zRTtO6unumw3U7ppRyRE0Gs/sqtllusp07KuBTerYfXT
         l/G0RkSg6a9Yzd8gjTQdY5MieIft20COb3vWydSFWibO5i7lt1oyxC9yNo564oVMbM6E
         6JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KEX9A5S02eTLANywjAz8Q1TfuoV7jOL6FAEGxGyoKMM=;
        b=Qh1VJ2LqprQkypeG4SSpc/UlyG2mA2pfVjlH0EXaEwbOldvXGf0thKcDMevS7HsVcP
         0sjArL+QWlkgWlfJ4ZkbFOnPQsrQSEq6+fVqZAY9OGTiuCl9KB+lukHLoKj9TKAFO+9e
         /wJ5fGnJ6Ycf/iaMHzEm9lU4xNzQUBn/1Irc/yFMyO5FXPCev0Sox7O6GDwDKWjOMo/f
         lFi/j5qPM9dllPPKdwrOH9R0sUY1Vmjfre8kNjA5pTMOnGq0U+930VpHXDX3G9/+OT0S
         VZ09ZeRgFw4ZnescxEUipT7n40EhorQ8Ph4A1CtBmb2W9jpqsQN48TcIkgph6dqnX1y5
         DCmw==
X-Gm-Message-State: AMke39kffnBEe1UIQ0tLcHFkNIdk65As+bwtiAy6SzxXbvBz+QGVVPhE/2YYy4wZ+tU55G5mJJ3GkiwtVKryZw==
X-Received: by 10.202.71.65 with SMTP id u62mr10977892oia.165.1486586354875;
 Wed, 08 Feb 2017 12:39:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.13.38 with HTTP; Wed, 8 Feb 2017 12:39:14 -0800 (PST)
In-Reply-To: <1aa20b4e-782f-a650-eab8-51218b838337@web.de>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de> <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Wed, 8 Feb 2017 15:39:14 -0500
Message-ID: <CAKepmagpq-40JVOSHb=a51CjQtM=iCzd1D3KAH3q0gV9NuJMfA@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm not so sure about that.  With your example I get this diff without
setting diff.natvis.xfuncname:

So, to make sure we are on the same page, I removed the
diff.natvis.xfuncname from the .gitconfig and .git/config.  My output
was:

C:\Users\adrianh\Documents\tmp>git diff
diff --git a/test.natvis b/test.natvis
index 93fd5b4..351301f 100644
--- a/test.natvis
+++ b/test.natvis
@@ -18,6 +18,7 @@


          <!-- test text -->
+         <Item Name=3D"added var">added_var</Item>


       <Item Name=3D"var2">var2</Item>

So I didn't get the default output that your specified.

I've been modifying the .gitconfig file directly, but I tried your command:

git config diff.natvis.xfuncname "^[\t ]*<Type[\t ]+Name=3D\"([^\"]+)\".*$"

and still had the same results.  I.e. NOTHING. :(

On Wed, Feb 8, 2017 at 1:37 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
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
