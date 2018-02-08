Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B879D1F576
	for <e@80x24.org>; Thu,  8 Feb 2018 11:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBHLuZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 06:50:25 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:55666 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBHLuY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 06:50:24 -0500
Received: by mail-it0-f44.google.com with SMTP id b66so6156223itd.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 03:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eFGkjTta50WtRCVw3+viZJllsFlP6C+Yioi4RqMyGDs=;
        b=nhDeXVnng1UpF2mOxyD8/Ye9rB3f3qCVHxbJhA9AWNqh4P9xhLqOPd8jkziAoABSRc
         /meeflNCFSj6Lt7bPAK8sS00YLSwGjdSQOYqlBrMbYwOs9Wln9Vx3kb7NkcatAJyAMdI
         B09l8c8GY5bMmyGbHhdsBi87xmaSt6pEDgDM8Lpp5l/VK47gDjcLAi39Ub739lN7Bix3
         3mMAminQ0FBLQlOCtMkCXre/ErwDo7hflfY3NoF0cjDSCAGx/+M4jtiuKGU3bsyYTlya
         zxldCXsc9ot5PB6uaQof0RVQkL38Zds2hCLClWTNUSMYKc4IGfHUyYggIGUs4+oir54Q
         FmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eFGkjTta50WtRCVw3+viZJllsFlP6C+Yioi4RqMyGDs=;
        b=MCDl2tMPdOynvRkO1kwgl0TVMhiWT/2nCHaVlMAc7m0Lk1Wpg+a2BapnA5CKGikSZ9
         uvasqBjs1BsMl9BX/YqO0kSL8K2x/WZD+dVpqTzXwgb4EQZu5pwonUGHlgUI53Te7asi
         GXLIi2F4rQh5wWrqtjuT+pFSl3MOfNVazpLL8ttYeeTBd4cM79l3PM55NbQ2eM82s3Zv
         mrtrTNsM1fj/A1FLRT3MWJWgU/7rMYXyTzvlZxAr7GrgVP5fuaMVXx22YUENM+OdSTir
         gUS5HTWvJIvcbKPXVXUDqUFrOFmkgndxANw4eraZXMiNEloKgNE6zo8jESxL8Cdhm/ND
         ffoA==
X-Gm-Message-State: APf1xPCPOdojX2T/rxDrQpg1t6jp1vik0d3jE0d7l4jdRhwDDvS8oZ6L
        v1yWZKRaK/eMc3wiaLWXNF0WyqKndEt1LzjJT4PZtA==
X-Google-Smtp-Source: AH8x224W2dsNPukxfkcmxxvZrnCH6xoRmmmc74gYpPwrSrxEu9Jfze35P/UkOxZ3T75VGzPoFFmP879TMXNB9V1pGhg=
X-Received: by 10.36.224.141 with SMTP id c135mr1021893ith.144.1518090623769;
 Thu, 08 Feb 2018 03:50:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.203 with HTTP; Thu, 8 Feb 2018 03:50:08 -0800 (PST)
In-Reply-To: <20180208112508.GA3506@sigill.intra.peff.net>
References: <CAF=vhqdJ2fByjSVt37b34wQUFo5_tb7rHbCddsaCzdvKywSBdg@mail.gmail.com>
 <20180208112508.GA3506@sigill.intra.peff.net>
From:   "Nick O'Leary" <nick.oleary@gmail.com>
Date:   Thu, 8 Feb 2018 11:50:08 +0000
Message-ID: <CAF=vhqdq47sb6wH7PEUif5ZjGJzKaO7fW-hbHVz3c=vp2AMBMg@mail.gmail.com>
Subject: Re: Unexpected git diff output during merge conflict
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, the whitespace that was added to enable the >>> markers to be
added... that makes sense.

Which means the output is correct and some assumptions my code makes
about the format of the Combined Diff are wrong.

Thanks!
Nick



On 8 February 2018 at 11:25, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 08, 2018 at 10:51:57AM +0000, Nick O'Leary wrote:
>
>> $ git diff README.md
>> diff --cc README.md
>> index 61d78b2,620d806..0000000
>> --- a/README.md
>> +++ b/README.md
>> @@@ -1,7 -1,1 +1,11 @@@
>>  -This is my default readme
>> ++<<<<<<< HEAD
>>  +merged-history-test
>>  +===================
>>  +
>>  +### About
>>  +
>>  +This is your project's README.md file. It helps users understand what your
>> - project does, how to use it and anything else they may need to know.
>> ++project does, how to use it and anything else they may need to know.
>> ++=======
>> ++This is my default readme
>> ++>>>>>>> dev
>>
>> This does not look right to me. The 'This is my default readme' line
>> has ++ at the start - suggesting its new to both parent copies of the
>> file, which isn't the case - it came from the dev branch so should be
>> prefixed with '+ '.
>> I'm also not clear why the line beginning 'project does' has both a -
>> and ++ prefix.
>
> Are you sure there aren't whitespace differences in those two lines?
>
> For instance, if I do:
>
>   # base commit
>   git init
>   git commit --allow-empty -m base
>
>   # one side; note missing newline!
>   printf 'this is my default readme' >file
>   git add file
>   git commit -m default
>
>   # other side
>   git checkout -b other HEAD^
>   {
>         echo this is a longer
>         echo and more involved
>         echo README
>   } >file
>   git add file
>   git commit -m longer
>
>   # and now merge and get a conflict
>   git merge master
>
> Then I get similar output to you.  The content with merge-conflicts
> can't represent the original lack-of-newline for that file, because of
> course there's another ">>>" line after it.
>
> If I swap out the printf for echo, adding the newline, then it produces
> the output you'd expect.
>
> -Peff
