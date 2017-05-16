Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7A9201A4
	for <e@80x24.org>; Tue, 16 May 2017 10:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbdEPKDS (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 06:03:18 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36505 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdEPKDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 06:03:15 -0400
Received: by mail-io0-f173.google.com with SMTP id o12so90257197iod.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PYA64+Q7HOcSY7QlrPG/5+WtikVD47JVjNmdUVbLclk=;
        b=Z6Qv9v5db9hycXThe34pKlX/YTKDIVKhiWHHAUeglVEZohYNk8fqJnu+0Yy9lbcSKk
         KzRo+p3OhBTvdiZw5TAK8DimUc0+ZnHTHIVYjQkkv/iLT0IrGfqRebORHHhBOD1wBfpb
         bdMDGFfEa6J44LZr9TAbsj1y3x0sLgzYpiOADdoJdqplJKVjfa8nKEui28oXXTDunU5x
         4Iw2sypqK6kHqSENGN2OssVOqRATi3IDIcG1qWiSzMV/b+fHNbyuKnD8xF5PIm6nlz6+
         GfYNWtBjtQvv91vNvHs7zMprBehAhS7VXyPEZ+G4rA8+BGiqwg04W3YJbmVMTsp+Rnzl
         CMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PYA64+Q7HOcSY7QlrPG/5+WtikVD47JVjNmdUVbLclk=;
        b=rIZ4w2OcuVjYGA1Q5lRa4xW2lr6+PwHoUNhiN07w35wn5hDKHmgkQDHWwNMrNGpxsx
         xiRdqPSk14bIfxGnAqVkTk7C8PdrtDWHMlHShEmO5fqU6FIc8uIxMGeFvDsQhtyK6uQB
         NKxtXsPzmu1aX1LyQVs3ZLT98tKtgTqK+GpSU+whjqopyiH7eZZVezIsYccBdNU2nksb
         3Q+oH/QN29/LQwN0YhfuMavijycyAt0GWj5wHzREJrzyYp0Z7Ja7X2wpuiwIooyQgrk3
         HhaPa3vQrmOFa4m6jAx40DckKJNgSQCAlYiOMgzr6Mof5c1SZhbnVtYetTVgjxNpcsYM
         wXqg==
X-Gm-Message-State: AODbwcCR/Db85w+0IyDhGhqBhuC0rDirjmHtvFTP/UmNelXxfJUxSwxV
        tNmj9lChfsXLxBlVkK6PsHLRDGDSAw==
X-Received: by 10.107.201.131 with SMTP id z125mr9219485iof.160.1494928994440;
 Tue, 16 May 2017 03:03:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 16 May 2017 03:02:53 -0700 (PDT)
In-Reply-To: <xmqqh90l188a.fsf@gitster.mtv.corp.google.com>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
 <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705121216290.146734@virtualbox>
 <xmqq7f1h63h9.fsf@gitster.mtv.corp.google.com> <CACBZZX5EXxsB3TWiiB0TH-ZpOsadcAPAe4chrQBe7py9VAMY+Q@mail.gmail.com>
 <xmqqh90l188a.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 May 2017 12:02:53 +0200
Message-ID: <CACBZZX5oVKGZLKgS4aF0=XXtHO67ynS+zxSopDN9ErJGzV9n-A@mail.gmail.com>
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 11:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This and many other discussions on-list basically come down to:
>>
>> 1. Someone wants to change X.
>> 2. This would have user impact Y.
>> 3. We have no way to quantify Y.
>> 4. X doesn't happen out of fear of unquantifiable Y.
>
> You forgot the step 0. You need to answer two questions: "Is
> changing X necessary?" and "Does that necessity outweigh the
> inconvenience caused to existing users by the deprecation flow?"
>
> You need to answer yes to both before you even consider going into
> the later steps.  Once that happens,...

Leaving this change aside, because I'm not interested in this change,
but the process in general. That seems to be a recipe for leaving
certain types of changes in deprecation limbo.

I.e. we say "don't use this", but can't follow through because users
may be inconvenienced, and we can't get any data on how users may be
inconvenienced because of the chicken & egg problem of not being able
to push those deprecations in any way to users.

One way to bridge that gap would be to e.g. have something similar to
"use <VERSION>" in Perl, where users can opt-in to new features & hard
deprecations.

Plenty of us package up git for other users, and various downstream
distributors (particularly more "bleeding edge" distros, like Arch,
Gentoo, Debian unstable) might be convinced to turn such a switch.

Wouldn't that go a long way to bridging the gap we have between
"surely nobody needs this anymore, let's remove it" and "we don't know
if someone really needs this, so let's keep it forever"?

>> It seems to me that a way out of this that would make everyone happy
>> is to go through some deprecation cycle through several releases with
>> X where:
>>
>> 1. We detect that you're using X, and warn that it's a candidate for dep=
recation
>> 2. In another release, we turn off the feature by default, threatening
>> that it's going to go away forever unless someone pipes up (this is
>> what we did with rsync:// accidentally)
>> 3. In another release, If you turned on the feature after #2 we emit a
>> noisy warning every time it's used, saying "it'll really be removed in
>> $release+1"
>
> ... the deprecation practice is very well established around here.

It seems pretty haphazard to me, is it even documented somewhere?

I'm talking about an establish process backed up by code, where for
example I can add an experimental feature in v2.14.0, it'll be subject
to change & warn unless you configure core.use_experimental=3Dtrue or
whatever until v2.16.0, then it'll be considered stable, and changing
the semantics of any stable feature will require opt-in configuration
that'll only become default after N more release cycles where N is
some well-defined number.

Git's deprecation cycles, such as they are, seem to be better
described as: it'll be noted in the release notes or docs, then left
for some indeterminate amount of time until we have the argument on a
case-by-case basis of if/when/how to deal with that specific case.

This causes issues for devs wanting to deprecate things, but more
importantly doesn't at close the loop on deprecations by bringing
users into the loop. What am I to conclude as a user from various
mentions of deprecations in our docs? Some of which have been there
for 5-10  years.
