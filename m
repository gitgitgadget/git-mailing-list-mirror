Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374FB1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 17:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeLSRMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 12:12:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50213 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbeLSRMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 12:12:14 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so10784597iti.0
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 09:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KNvp9xpAeQQNeRik2F0unrrmgktYkE6h5TuR4a4dn30=;
        b=GlddgChog3Vo7eHNguYr45QnegmmuK9UpQTWdA242/GdYMR+M5kYcJmVfv47kEvTBp
         QKpC4allgVnhXhQVOvzNfyv1Dfl03ZVvVLkqqLhWs0Dzd/Jv6h6LwtwNWCuukDtjRveL
         Ylhk/e8SvuWE3QARKXx1djozXsEEgsI5yqtovomA8HD+6N5V5RuOSViwlTruBd5fRbsC
         d0KgtE7rRMguBa+olAixk7H0yWSCvJodO4vGBKUe/C3e2oCOCzgk0j4F+HAHegDoiN8E
         mloNQ++A7JB3JQE3rM0LSMD1cYPOXNECY2a/WuOJWJmrZU38AoXmItumD83WbCt0RQ+j
         WlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KNvp9xpAeQQNeRik2F0unrrmgktYkE6h5TuR4a4dn30=;
        b=pl3Fxehu3MmUBJHKPEpvmXqWOL03br0ChTC/HkWOnYi1Ktx4mPR5bHqVgMkxLJg6o/
         AhOlDdxLQCpS793RHybNyiggykhJrqe3kOhwWgAXUSjTFXOHclhNRYp+h7njFP6l3aYc
         dAboCj64wJCBdoVjx6xa00Oew/ghP5LfL8YR0Z4Fr5+UVmw1ZI0SVegwEFasPs+qk2+C
         OkjHKDEuO4MMi5QNRWTjARrcItYsAYLkbYO3wF6tltOXA5zn94+paqUWWBCGMKfaH4Yl
         OYa3Pkf5Hbv7BqnKCg74TpaWCeQo0THTJyhZeBtp97Wa+nhyAYxMaG11DJj85WPnmksM
         MeFw==
X-Gm-Message-State: AA+aEWbZLGtrCc+1DriPKks+bzBhZedgQgz2zbSHdZuSbb0b8KnbGXrS
        l/5IGYB9XkZuX08L4BmBBH4Fw4oyv3zz4ABJRHw=
X-Google-Smtp-Source: AFSGD/WH4L3CObvqTxpTr8gaanYs2ERheMTNkSmDhO3QQ+RbEgUrniYXYFn7QEpQquvRcGkxdqtVm8g5Gyq5gZRu6Gg=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr7262484itk.70.1545239533268;
 Wed, 19 Dec 2018 09:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20181217165957.GA60293@google.com> <877eg5fwd5.fsf@evledraar.gmail.com>
In-Reply-To: <877eg5fwd5.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Dec 2018 18:11:47 +0100
Message-ID: <CACsJy8DdgjjQLEn=O7ePBo7ndLuv22RGQA3nM1Lyizz=59Pj9Q@mail.gmail.com>
Subject: Re: Referring to commits in commit messages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 6:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Dec 17 2018, Jonathan Nieder wrote:
>
> > v2.11.0-rc3~3^2~1 (stripspace: respect repository config, 2016-11-21)
>
> Minor nit not just on this patch, but your patches in general: I think
> you're the only one using this type of template instead of the `%h
> ("%s", %ad)` format documented in SubmittingPatches.
>
> I've had at least a couple of cases where I've git log --grep=3D<abbr sha=
>
> and missed a commit of yours when you referred to another commit.
>
> E.g. when composing
> https://public-inbox.org/git/878t0lfwrj.fsf@evledraar.gmail.com/ I
> remembered PERLLIB_EXTRA went back & forth between
> working/breaking/working with your/my/your patch, so:
>
>     git log --grep=3D0386dd37b1
>
> Just found the chain up to my breaking change, but not your 7a7bfc7adc,
> which refers to that commit as v1.9-rc0~88^2.
>
> Maybe this is really a feature request. I.e. maybe we should have some
> mode where --grep=3D<commitish> will be combined with some mode where we
> try to find various forms of <commitish> in commit messages, then
> normalize & match them....

To follow email model, this sounds like a good trailer for related
commits, like In-Reply-To for email. We could even have special
trailer "Fixes" to indicate what commit is the problem that this
commit fixes.
--=20
Duy
