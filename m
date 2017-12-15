Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71ADE1F428
	for <e@80x24.org>; Fri, 15 Dec 2017 20:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756090AbdLOUsL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 15:48:11 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:46235 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756296AbdLOUsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 15:48:08 -0500
Received: by mail-pg0-f47.google.com with SMTP id b11so6538913pgu.13
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 12:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DvoeTj2ZYFJsf40lUHwZrDIL674PwOYvKbZCRrnyqiU=;
        b=AYO6pe/n/55Gj0UIx3zuXslWDt2xFMGJmZNo437RVpJWmyY9xFV5VuhfQwpGmF5hSB
         mPewEJy/vw87DANgX5IODbqrD9ubdnjYDXYlpC9SvaIE8qu/Qaeigz5cze6Kfgs5ZLj1
         /zIZ08KqSn8Ggayw4USsJeAvJHfVpPdfXvJTVfUhH9nMj+couYfIEKmAhR+Vz0gslWwv
         nrEs8wVGwlEdcaZmAAq+NkuGa5Qw7UHIaphMDYB7jPa1gxQ/kK6P+towq9YTlUhSzBUJ
         hGy3Ljd3uG4KZ8u4yyRrTvZQxFOAu6c34mZfJYMz+P3AvFywanuwy2k0hGkqaaodxmD3
         lT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DvoeTj2ZYFJsf40lUHwZrDIL674PwOYvKbZCRrnyqiU=;
        b=gzMtB6IsR1DBSWdg85t417OVkUAaoU5McOhWA99hqEPAar+0/KDCFN2qq8qJk6ikMO
         oH1Evo924s9nEv0A9GHuxNdOmuPV4xT0AvaaPjptI8vfOMjKt+lECYqgFoHDNSmAGsVj
         oeHA/WIkhbhhAQxPD+GiujoIcaMs1w5AYvKcWPqtiPiPIqFTVplMHCItJ6B4qk5mFzG8
         FMOtKM2JpMXN24lH0wj8S9UCD+oCkgbDQIPe1FJT1bGwXzRRtDJxFFC1iv/QrxfBCX+n
         sEfXzmBGHSDYTpfyhdFiuIs/rQaeUCUyzjMFP1sWYKCtrSqE5WhKmPzQoT3Wuub+Ohgc
         HKgA==
X-Gm-Message-State: AKGB3mKpxNxIwRqs40r6Zvb6YttRMDPIj4R1SSOMLJxtJmWvRp9hu1PS
        dLV3x1174w44spN+VMDq9T/c1QWTHzblAF4s70Y=
X-Google-Smtp-Source: ACJfBou1wU4bbNVBzkZ4G1BBvF/r3naGOkyivcMaq9PX8ukH5zMQfjhUinWAQTuV4OApZBquBcIGQDYLFJLV6tei7HE=
X-Received: by 10.98.19.92 with SMTP id b89mr14764119pfj.124.1513370887623;
 Fri, 15 Dec 2017 12:48:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.189.1 with HTTP; Fri, 15 Dec 2017 12:48:07 -0800 (PST)
In-Reply-To: <CAGyf7-F8cCprvK-e2S0kO0Wo+6n4m_gigpSQjCjSj-dhozMsMw@mail.gmail.com>
References: <CAMZug24WGWS3TaNPOVWPufGZ+67EbLggr4W3pxJtis9X375mag@mail.gmail.com>
 <CAGyf7-F8cCprvK-e2S0kO0Wo+6n4m_gigpSQjCjSj-dhozMsMw@mail.gmail.com>
From:   Satyakiran Duggina <satya0521@gmail.com>
Date:   Fri, 15 Dec 2017 12:48:07 -0800
Message-ID: <CAMZug26A0e=AunMOjZNC_xH2E5uqHe46mt6=jawWe7ozF=Jn0Q@mail.gmail.com>
Subject: Re: Git Hooks
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Bryan.

To give the code pullers a chance to review, can we not have a
`trusted-hooks: default` and `trusted-SHA: <some sha>` field in .git/.
I'm assuming githooks/ are source tracked here.

When developer tries to execute `git commit`, git can ask developer to
change `trusted-hooks` field to true or false. Let's say developer
sets it to true, git can record the SHA. If any latest pull has the
hooks changed, git can revert the `trusted-hook` to default.

This way there is not much hassle for developers to manually copy
hooks all the time. And at the same time, they are not running scripts
that they haven't reviewed.

Will this work?



On Fri, Dec 15, 2017 at 11:23 AM, Bryan Turner <bturner@atlassian.com> wrote:
> On Fri, Dec 15, 2017 at 11:12 AM, Satyakiran Duggina
> <satya0521@gmail.com> wrote:
>> I see that `git init` creates a .git directory and hooks are to be
>> placed in that directory and these hooks are not tracked by version
>> control. To achieve tracked hooks, either each developer has to copy
>> the hooks or use tools like overcommit, pre-commit, husky etc.
>>
>> I'm wondering why hooks are not made external like .gitignore. I guess
>> it would be better to have two git configuration directories in a
>> repo, one hosting all the metadata managed by git and the other with
>> user configured data (hooks, ignore/exclude, repo config etc).
>
> Hooks are not external because they're not trusted. It essentially
> amounts to allowing someone to download an arbitrary script or program
> onto your computer which you then execute. It's extremely unsafe, and
> is intentionally not possible. To get hooks in your instance, you have
> to _manually_ install them. This gives you a chance to _review_ them
> before they start executing on your system. Any other approach and the
> hooks become an attack vector.
>
>>
>> Kindly let me know why the current design choice is made and if the
>> proposed change would introduce unseen issues.
>>
>>
>> Thanks,
>> Satya
>
> Hope this helps!
> Bryan Turner



-- 
Regards & Thanks
Satya Kiran Duggina
