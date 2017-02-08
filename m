Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01641FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdBHUmd (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:42:33 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34897 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdBHUmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:42:32 -0500
Received: by mail-oi0-f54.google.com with SMTP id j15so89225698oih.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 12:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F04lnLm9gYeqpQ7T0uaPVSO0DsPunjwJAdZnqn72cxA=;
        b=L2qIJr35Ns8rlOhHBWd/AaUGzw0byb6z15SaECmp7VrBgxXCAJndt2jOGpbft2STtn
         QUTdg3dsV0DgKb0+Yp+W0DTQemVjqA6CWz7sR9tqDrZcwXnLuWfSvpTmfrTpCDdD7WAL
         n14pQYyJjQ1XQHlg6cxLwVe2ZbQWy/1tj5rHaZINgNzq7c9PGpFKNhIaaZB0seRfjzyp
         qOthGJWeEi85Hl5bfgSzwX9HxlDVWViQ8lMUKF3rlc801HhFYquntmNC7IRw29bx38AI
         3Sz2/JRhxKsLVO5fMqhZU0pNH9HMJR9Db5SdyhHdmzu6kMPQa5Hi+YFwOFT3Ibyxwkxb
         JTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F04lnLm9gYeqpQ7T0uaPVSO0DsPunjwJAdZnqn72cxA=;
        b=fWPVuu4rN48blPFcSjAoheLlInSS2dS97OIB3IBTqYwsxaFNaQdycDASPjWTOhZpoh
         /F/mWNlS3NJ3/LEhaFpD9ETn9GsksPxlHprBMPMg6TSG2GvtSRNOCflL4lecmcF4gDJ2
         PHbfwEGPKx5d+4mlLQLGgNkVeav2C+INn0B5oxQxSaZn+9JhYs2mQ8gk9zmZBpo6Jcc/
         8jVXiNDFV8y8exqywS72R5BG8h8VCKE0dEQQcoic2NErcE1cJeosoUKjFe0XkuMkei+u
         +vTX2BVJt92OWXuQ0iLvEz8UOeMdXVMyBORv2CuCrS8LWg3lTmeaNeEru0uzZ2k8My2g
         nVOQ==
X-Gm-Message-State: AMke39lxuZpjGwu3kjd/lQvPSoZxZGTbs81XWFe/TqNtcr/6xmm5/n0emKunxukd6E/+64+lsou4Mb/aCSw4DQ==
X-Received: by 10.202.117.210 with SMTP id q201mr10695010oic.126.1486586547089;
 Wed, 08 Feb 2017 12:42:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.13.38 with HTTP; Wed, 8 Feb 2017 12:42:26 -0800 (PST)
In-Reply-To: <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de> <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
 <1aa20b4e-782f-a650-eab8-51218b838337@web.de> <CAJZjrdXjnDMi8gMY6f_UDbMZrZJ=AoPM+g01hqPCO2pB9csoOw@mail.gmail.com>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Wed, 8 Feb 2017 15:42:26 -0500
Message-ID: <CAKepmagwMeky4jPZ-YFgPsZSsyOZZQ-kJSWV8QGg4cUNu-ZS8Q@mail.gmail.com>
Subject: Re: Trying to use xfuncname without success.
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Samuel,

So, the question is, what is causing this problem on my system?

Anyone have an idea to help diagnose this problem?

On Wed, Feb 8, 2017 at 3:24 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> On Windows 7, it works for me in both CMD and Git Bash:
>
> $ git --version
> git version 2.11.0.windows.3
>
> $ git diff HEAD^ --word-diff
> diff --git a/test.natvis b/test.natvis
> index 93396ad..1233b8c 100644
> --- a/test.natvis
> +++ b/test.natvis
> @@ -18,6 +18,7 @@ test
>
>
>       <!-- Non-blank line -->
>       {+<Item Name=3D"added var">added_var</Item>+}
>
>
>       <Item Name=3D"var2">var2</Item>
>
> On Wed, Feb 8, 2017 at 12:37 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Am 08.02.2017 um 18:11 schrieb Jack Adrian Zappa:
>>> Thanks Rene, but you seem to have missed the point.  NOTHING is
>>> working.  No matter what I put there, it doesn't seem to get matched.
>>
>> I'm not so sure about that.  With your example I get this diff without
>> setting diff.natvis.xfuncname:
>>
>> diff --git a/a.natvis b/a.natvis
>> index 7f9bdf5..bc3c090 100644
>> --- a/a.natvis
>> +++ b/a.natvis
>> @@ -19,7 +19,7 @@ xmlns=3D"http://schemas.microsoft.com/vstudio/debugger=
/natvis/2010">
>>
>>
>>        <!-- Non-blank line -->
>> -      <Item Name=3D"added var">added_var</Item>
>> +      <Item Name=3D"added var">added_vars</Item>
>>
>>
>>        <Item Name=3D"var2">var2</Item>
>>
>> Note the XML namespace in the hunk header.  It's put there by the
>> default rule because "xmlns" starts at the beginning of the line.  Your
>> diff has nothing there, which means the default rule is not used, i.e.
>> your user-defined rule is in effect.
>>
>> Come to think of it, this line break in the middle of the AutoVisualizer
>> tab might have been added by your email client unintentionally, so that
>> we use different test files, which then of course results in different
>> diffs.  Is that the case?
>>
>> Anyway, if I run the following two commands:
>>
>> $ git config diff.natvis.xfuncname "^[\t ]*<Type[\t ]+Name=3D\"([^\"]+)\=
".*$"
>> $ echo '*.natvis diff=3Dnatvis' >.gitattributes
>>
>> ... then I get this, both on Linux (git version 2.11.1) and on Windows
>> (git version 2.11.1.windows.1):
>>
>> diff --git a/a.natvis b/a.natvis
>> index 7f9bdf5..bc3c090 100644
>> --- a/a.natvis
>> +++ b/a.natvis
>> @@ -19,7 +19,7 @@ test
>>
>>
>>        <!-- Non-blank line -->
>> -      <Item Name=3D"added var">added_var</Item>
>> +      <Item Name=3D"added var">added_vars</Item>
>>
>>
>>        <Item Name=3D"var2">var2</Item>
>>
>>> Just to be sure, I tested your regex and again it didn't work.
>>
>> At this point I'm out of ideas, sorry. :(  The only way I was able to
>> break it was due to mistyping the extension as "netvis" several times
>> for some reason.
>>
>> Ren=C3=A9
