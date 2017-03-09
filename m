Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C7C202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 13:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932358AbdCIN0E (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 08:26:04 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33726 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932359AbdCINZx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 08:25:53 -0500
Received: by mail-lf0-f44.google.com with SMTP id a6so28172859lfa.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 05:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Np3EFChFC7HF3qNztpu2SJ1p3/B6BGM5UfypIaqpiJE=;
        b=RUOBqN50NxGUi/jrr7XboAH9bDp2QczOT6ZJAqHdiOb74nojEwxhW44/RApQ1HCKE5
         7fsv62XhXQs7AJOo5ilj+vDSmZTcgqNzn9CAxZoo0SJ25aghHu8+ovBDx492+W0Ey6Pc
         U0cNdJFRvtCgziyYwCVmUd/z0sR0fJzWAZNX9drCXHomSm+DvIy0kM/32G7oq9blDAxT
         pYPz1jfxsBMt7ALCFD5XEpU7DVm2fXlWp2FmeJkWgqaydB47Yq8t3wxpkjlDHtE4RGU0
         zrorgCNM8PifleybXTiASSrxZu3Gr0eOHGiMtAJzJgbPik7itU3EqNTuuauucIdh3jJH
         M5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Np3EFChFC7HF3qNztpu2SJ1p3/B6BGM5UfypIaqpiJE=;
        b=lr8dBIMzjgHbyL6OMyOtCp7FJj4Thd+kPPsTDu8TRmWS3hVTKjmH3waX7xIqP++lii
         ltYpy19+jahf7JCdxxkvM9VqsbbW8DuoqeZh8/h1XGpeZYjmtIvX3orJX4bu1j1gxrEi
         7rWvK63MS31tfV6RNhAVjux5mGPty2sDnQopN1Iu8wLBPq6+w8Fe63YZhCrYiI3Xbv9w
         njrYWzY7MbUxCQsQ+05Pkv+e1UxRl93TuN6VJ0P8Eqas2meslNrMFkzEs/K1pV/pr7Iz
         zIKaWgAgF6co1msQSxQA30ZXortvWP342UoxMYo0sn4dR1jgAyHVkHzHvYtLf8Ht/Io2
         24fA==
X-Gm-Message-State: AMke39kpQBPcQtwqzWA54LEWgJka5sZmpIlCJ7Yrhs+ZQgn+AFbDyi8aW90000qvWAzXQ843VemtMKXVdL02RQ==
X-Received: by 10.25.216.28 with SMTP id p28mr3368215lfg.164.1489065951400;
 Thu, 09 Mar 2017 05:25:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 9 Mar 2017 05:25:50 -0800 (PST)
In-Reply-To: <CAAdPw+d1GR3xZcoQ6jtd8EXhQKM2GRSmeb07iSExDiugXoX0Pg@mail.gmail.com>
References: <CAAdPw+d1GR3xZcoQ6jtd8EXhQKM2GRSmeb07iSExDiugXoX0Pg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Mar 2017 14:25:50 +0100
Message-ID: <CAP8UFD1rMLbH4jkZKg0sdS6z-PWafAXzsXaitwEB=x2k2Oy4qQ@mail.gmail.com>
Subject: Re: [GSOC] Regarding microprojects for gsoc 2017
To:     Avinash Tiwary <tiwarysriavi@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 2:14 PM, Avinash Tiwary <tiwarysriavi@gmail.com> wrote:
> [GSOC]
> Sir, i am interested in git projects and i want to complete one of the git
> microprojects. But i am unable to figure out which git repo they are talking
> about. Since , there is no link provided. Please help

On the microproject page there is:

"Download the source code: clone the repository using the Git via Git
instructions and read the README file."

where "Git via Git" is a link to https://git-scm.com/downloads where there is:

================

Git via Git

If you already have Git installed, you can get the latest development
version via Git itself:

git clone https://github.com/git/git

You can also always browse the current contents of the git repository
using the web interface.

================

and where "web interface" is a link to https://github.com/git/git
