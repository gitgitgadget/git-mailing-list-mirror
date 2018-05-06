Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2DC200B9
	for <e@80x24.org>; Sun,  6 May 2018 14:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeEFOns (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 10:43:48 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34919 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeEFOnr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 10:43:47 -0400
Received: by mail-pg0-f41.google.com with SMTP id j11-v6so18475245pgf.2
        for <git@vger.kernel.org>; Sun, 06 May 2018 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=785oiH1jNM59nhnZX3Ov1/9NNNOuVazi4/1JvhLvQ64=;
        b=BrYdUA80WOQ8ZJWvUgzjk226UoFnkpf49mihr14vkqzv5aKnUK+PX38mVvpBqqxCPG
         lWG6iaiUz7Gua1l5Fbgb0TBGwqLBT7AbYuMxtZEy5yZph8dX8XiPGsAkuFuPhJrdQol/
         swTIawpZBZ238twG5grqSY/OJBWy7CU42fOMgjoY6Qh09SE03qCgOQd19MbYLLtLkOZN
         3loJjVNJXsDP8sXnLqiq6vRVqXILLEsAv+a1NFcq/vqNLduNwysy7/anh3NIWU3/iFAd
         jAGT3l1V3Svobk78jOrjc4CGz3pc52QMOnfCFQYano9RzaiqP/taa2AqGK3CQTKg/pIU
         me+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=785oiH1jNM59nhnZX3Ov1/9NNNOuVazi4/1JvhLvQ64=;
        b=hurfkT0wWg/umyxP5f6GOoCKBY4dkENBUlvzXbGmmIzu3hOXrk+ZC/5I6jAjpO2lH7
         7LiMxFDLE3icvCf5UgM4OflQqm7URHH7UmKkGY5JHwdOPIhz6QOouWOtsfSul3n1TPdO
         FwQPOYcShvGUi1yRb6K1xwKkrMzbq1U7Cg3pRT8AjtfEIgvkaaz9hQyNWscTPIstWWpW
         bwf3PlI6Uyned9qTN3txyMgShxITAVy0ofbifa48oulmJL58QU8IvGP+JDNAvoQjyepk
         /rgn18tQqfj0k2u1NcXlrIkokz8JoN5v30DkOgm26XsNTlqoN3h8Vsm3sRPB4dCmNLao
         sqOw==
X-Gm-Message-State: ALQs6tAPdmVjBb6I4WcFgnIsiU6QkL/+B0Pdf9Egg2sH7kjjvW2TpwpD
        koHQzSuvuoz1jPN0ca1cM4KOYS6TozoynSqPu1M=
X-Google-Smtp-Source: AB8JxZqq6thds0l3jwHrjvht6zzU2qt0XUs28eqpt6tZEZxF4r37n9ZrF7IFuRss72Sf7jAVVrsS0rnUyEDe1yAl/r0=
X-Received: by 2002:a63:7b53:: with SMTP id k19-v6mr27831750pgn.146.1525617826852;
 Sun, 06 May 2018 07:43:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sun, 6 May 2018 07:43:46 -0700 (PDT)
In-Reply-To: <326d07b48654ab2a64d09eb17d995a26d06bcdb1.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1525488108.git.me@ttaylorr.com>
 <326d07b48654ab2a64d09eb17d995a26d06bcdb1.1525488108.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 6 May 2018 16:43:46 +0200
Message-ID: <CAN0heSoiOd-oXj_0kJbc2qQCQAortCuXERpxF4Cro8pi4x1eBQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] contrib/git-jump/git-jump: jump to match column in
 addition to line
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 May 2018 at 04:43, Taylor Blau <me@ttaylorr.com> wrote:
> Take advantage of 'git-grep(1)''s new option, '--column' in order to
> teach Peff's 'git-jump' script how to jump to the correct column for any
> given match.
>
> 'git-grep(1)''s output is in the correct format for Vim's jump list, so
> no additional cleanup is necessary.

> diff --git a/contrib/git-jump/README b/contrib/git-jump/README
> index 4484bda410..7630e16854 100644

>  # use the silver searcher for git jump grep
> -git config jump.grepCmd "ag --column"
> +git config jump.grepCmd "ag"

I think this change originates from =C3=86var's comment that it "also makes
sense to update the example added in 007d06aa57 [...] which seems to
have added jump.grepCmd as a workaround for not having this" [1].

Somehow though, this approach seems a bit backwards to me. I do believe
that your series reduces the reasons for using `jump.grepCmd`, but
regressing this example usage of `jump.grepCmd` seems a bit hostile. If
someone wants to use `ag`, wouldn't we want to hint that they will
probably want to use `--column`?

Is there some other `ag --column --foo` that we can give, where `--foo`
is not yet in `git grep`? ;-)

Martin

[1] https://public-inbox.org/git/874lk2e4he.fsf@evledraar.gmail.com/
