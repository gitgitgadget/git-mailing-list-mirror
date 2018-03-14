Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54021FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 09:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbeCNJko (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 05:40:44 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:36403 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNJkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 05:40:43 -0400
Received: by mail-pl0-f47.google.com with SMTP id 61-v6so1419375plf.3
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ffMCYeiTfFwcFfbp2bocWejcrb89IpU25mf79xKmCPc=;
        b=jGjsbr57NbJbzgj+pRSLaDUmWA3ec+bQ607RlJuATw1yJsNb2yTinVHcBnpgJ4t9hp
         vdbLlWsy1BjMx+Yia6f3AHT33Icg9McddH0sosiyedNaAJ0B7A92CawhG9JRXtx4oRUA
         GGmZ7Si6TJWy57LfbcS0jpsSoC1dL3hi87LynaJGM/157D/UHV57/zQGPPx5HdQ7LYv+
         eBH9Pjmq3GvaAiTUAxhCRG3BTmNQZXs+ODlOmo8dZNg+DgaDMa+Ntc7HKjF+5lwml/Im
         9JTL8uYf00tOrrBBCXnlmEFNKzjAPgR/FBa9UMvpC54WXJKqolXbS9lWSF4+LcMSjfdy
         UTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ffMCYeiTfFwcFfbp2bocWejcrb89IpU25mf79xKmCPc=;
        b=XK6zDeUiZRmNVf/4CzASpma5ZU8gZzC4dYnhElv+LnjjiUasq8PgPY+N1GgYfX3soO
         nv+3Y1BK8AmACPUrp+pPYIgFi9Xg1Cgb0qlcevETS19OhTfYMCsUCizszc55bRzbflS/
         UONmeUC+g5E05FU4xalK8mCoBLO5W2Ig/Zs0tVMvfwoADzjSJP7UoWPIyRO09pDWMahZ
         XsdwGQ1sXP4W9x+o+z7ARe3clpEB+Q5ek4GI01lxNYkTrIkF583jAdFeqVQKRCZACQas
         LAFpIVWzUy13GnbYGfXtkmeS+BhoXOJxrQdZ/1mxtf2hWi1dlgrYDZDw+HD7REYyGWWr
         ZTEw==
X-Gm-Message-State: AElRT7ErFkMmYLTaHSfocur5hpZ6ooX4GsiQKvNrd69xBxu4xIfQZmAu
        ZSQppdWbVAAEqMha3xJUqOg=
X-Google-Smtp-Source: AG47ELuQVUQC5hp+qCrtBWSL36Gw2bEf5mQQ/y4Kdzq7LiXWYOakMXoCitW+B//lFsWpDfydg1kc/g==
X-Received: by 2002:a17:902:7007:: with SMTP id y7-v6mr2961848plk.275.1521020442769;
        Wed, 14 Mar 2018 02:40:42 -0700 (PDT)
Received: from obe4l5qp12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m24sm4536270pfj.16.2018.03.14.02.40.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Mar 2018 02:40:42 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [git-sizer] Implications of a large commit object
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAMy9T_GdYjUm9DqcgrC=NxyTbZk_ep5rvAAK2J=zwhiSMyvaLA@mail.gmail.com>
Date:   Wed, 14 Mar 2018 10:40:38 +0100
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB908580-36C2-466D-AF05-6BFF7F5E4705@gmail.com>
References: <953C263C-6ECA-46AC-849C-8D1A38378654@gmail.com> <CAMy9T_GdYjUm9DqcgrC=NxyTbZk_ep5rvAAK2J=zwhiSMyvaLA@mail.gmail.com>
To:     mhagger@alum.mit.edu
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Mar 2018, at 09:33, Michael Haggerty <mhagger@alum.mit.edu> =
wrote:
>=20
> On Wed, Mar 14, 2018 at 9:14 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> I am using Michael's fantastic Git repo analyzer tool "git-sizer" [*]
>> and it detected a very large commit of 7.33 MiB in my repo (see chart
>> below).
>>=20
>> This large commit is expected. I've imported that repo from another
>> version control system but excluded all binary files (e.g. images) =
and
>> some 3rd party components as their history is not important [**]. =
I've
>> reintroduced these files in the head commit again. This is where the
>> large commit came from.
>>=20
>> This repo is not used in production yet but I wonder if this kind of
>> approach can cause trouble down the line? Are there any relevant
>> implication of a single large commit like this in history?
>> [...]
>>=20
>> =
#######################################################################
>> ## git-sizer output
>>=20
>> [...]
>> | Name                         | Value     | Level of concern         =
      |
>> | ---------------------------- | --------- | =
------------------------------ |
>> [...]
>> | Biggest objects              |           |                          =
      |
>> | * Commits                    |           |                          =
      |
>> |   * Maximum size         [1] |  7.33 MiB | =
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
>> [...]
>=20
> The "commit size" that is being referred to here is the size of the
> actual commit object; i.e., the author name, parent commits, etc plus
> the log message. So a huge commit probably means that you have a huge
> log message. This has nothing to do with the number or sizes of the
> files added by the commit.
>=20
> Maybe your migration tool created a huge commit message, for example
> listing each of the files that was changed.


D'oh! Of course. I was so focused on that commit with the large number =
of
files that I missed that. Looking at the reference [1] reveals the
problem. Sorry for wasting your time!


> AFAIK this won't cause Git itself any problems, but it's likely to be
> inconvenient. For example, when you type `git log` and 7 million
> characters page by. Or when you use some GUI tool to view your history
> and it performs badly because it wasn't built to handle such enormous
> commit messages.


Thank you,
Lars
