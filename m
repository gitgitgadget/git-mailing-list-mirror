Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B6E20248
	for <e@80x24.org>; Fri,  8 Mar 2019 00:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCHAR7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 19:17:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40322 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCHAR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 19:17:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so10846073wmh.5
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 16:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FNFpGWWUJShQP4sDDCiMBAEJkUv7YSp41KLjtqoUkfk=;
        b=A9zeDkt0XtqwHUyiklna+j3Au9JzMrbDDsOXY0pEavroRQGqFcDfH9AswO/ielOG0m
         YhGbm2EJ9ZEWuRd9xRi+kbyXLbNAHFxlBH84V11nXJ/vaJmWLecyohb72qVt7mjC/b/+
         +CYl5GaJfWucEazM3Ol+C5emj6SnA3yRnKEtt8p+MtiYctvquHT+kpubJKJeZCWTH+21
         o59ppMESKiNmSD7ibjyNLH4het2cN3jS4oaDbh+HYJbjMJqCTuyFkeOobLWeF/IT9Vrt
         VY6sb4RRhd9HMPiO1AMFAc3SNCX1RI7DOwEn4FMlWxb8N/zyPUTjm/aEsXPa0f8jLRcY
         PYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FNFpGWWUJShQP4sDDCiMBAEJkUv7YSp41KLjtqoUkfk=;
        b=i5AQiLLaIPAPUz/aoyQvxReoMju7/I42r/WdwvURKY13c98QWI+qkOC/S2xs2ZtGc+
         m62ZgAIkQxoSDyVHDvHhXbHKF0trhIdar0KPOaoOAnUYkYJgAHCskBdb4nKSjl3kIZXR
         4Y6wPb29TEhIgKeRDchzeAs8FQCqfOboorZG5bJsAVh9gLhU+veelj+lB08q59Ge0A/K
         69r3a2sGBN7E4xPSt+jW7foFgaWOsE98gskDS2lELA3gbVCtC6LPi0UFzG/i/f02Y5Ub
         9UukaeWDWB6/T0QIF96wYIPrlkJYZeI3vczPI2oyVSlfq9D/Lp3aYTnq4ui9DTQZSYNs
         g4AA==
X-Gm-Message-State: APjAAAXh8Qf2Mx4rJ9kXzwhFKoYnmZMB5oB6uANW/9XGhg32n74ErgJF
        uaQrzZU4ZMQ2Amb71sJoC/g=
X-Google-Smtp-Source: APXvYqxTFedJU8K4mxOL+lgw2HwGpg0OmbZZyCLwtC3b1mIaVITNW7+BVo2aOWtDicF6zG8QWa016w==
X-Received: by 2002:a1c:44:: with SMTP id 65mr6811225wma.127.1552004277011;
        Thu, 07 Mar 2019 16:17:57 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 12sm13229865wme.25.2019.03.07.16.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 16:17:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 2/2] Docs: move core.excludesFile from git-add to gitignore
References: <cover.1551938421.git.liu.denton@gmail.com>
        <cover.1551947030.git.liu.denton@gmail.com>
        <f1bc7d5eb1ad15427f6d14c19c90595d09acabe5.1551947030.git.liu.denton@gmail.com>
Date:   Fri, 08 Mar 2019 09:17:55 +0900
In-Reply-To: <f1bc7d5eb1ad15427f6d14c19c90595d09acabe5.1551947030.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 7 Mar 2019 00:25:30 -0800")
Message-ID: <xmqqk1hakymk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> There was a section on configuration mentioning core.excludesFile in
> git-add.txt. However, the core.excludesFile config variable is not
> exclusive to git-add. Move this description to gitignore.txt to be more
> generic.
> ---

I'll forge your sign-off and queue it like so.  Thanks.

-- >8 --
From: Denton Liu <liu.denton@gmail.com>
Date: Thu, 7 Mar 2019 00:25:30 -0800
Subject: [PATCH] docs: move core.excludesFile from git-add to gitignore

A section in "git add" documentation mentions core.excludesFile and
explains how it works, but this is not specific to the command.

Move this description to gitignore.txt to be more generic.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt   | 9 ---------
 Documentation/gitignore.txt | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)
