Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F3D1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 16:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfFRQlW (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 12:41:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRQlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 12:41:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so228192wrm.8
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Y5iwxAuexHFc18cTQNvwC2JSeavswqyJWdbkHxKFyi8=;
        b=R3dUH6xCZXEVxABIO/V3H3qL2dEbS151Yn1/i8rX67ZK3KxIC/Us53U+FtLct8rL8l
         O4MNNDGZcLlsvXAdnhx/itxeLO/vcGax1s+0VkU7YQtHHNCmYYg1Mzs+zlSL7vq01dmJ
         2FL0F8tV1ZNu1eWlY0ke4BNarR1UsWbWsx1cL+ntanbdwyolc55w9L8FWpA4tFgot1zn
         I0FuVToZZM8YLcZrYrC693g7RXPnjNpe0yCW4l5XW4wEm2NW1tmciE5hOG8JLfydMuXU
         0wbmH+IUD4qxwbmXBIbLAMm+tPYxvQ4aMvTekqAuXv0YcA6+j478meGJHE8UMYCspInk
         7fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Y5iwxAuexHFc18cTQNvwC2JSeavswqyJWdbkHxKFyi8=;
        b=eMOSPv54iZXzezFhCpGbvmkoirXigBhMtYr0foRiX4cVaM3T0gr3YnJHdho8lSmnfC
         xN6KMMybwX4qqA/sWkyOCDgK0TPseWH5an0Yg/PqLyZATcJBKEiy29aYy9MepKxcd+wf
         fnVX3078y3nzPHp1fxweIzoeFcOc9bwDaunZyp+kguamJHr9dPjmVR+bR+0lPRbxH9lb
         9bj7AsLN3zlqxjTBg2KhOyKGYjcTQcSaB6/+QWcbkTHJ7gulcZ411IKg2YfQIYU3XkXl
         mSTBOIlnR5DTFHzoDXSFnqcw+B/b1TLwjnuBh8aW4ZWSrLHUJiDv0Zq4SU5KmqFHuVaI
         aXNQ==
X-Gm-Message-State: APjAAAVgFYyud39WP0vYH7hgCj1s0rHwUHB3oezuPmJwHc78Xdixkzcg
        gy/S2HpMxY5DHppxiN3HO6V9CNK08vVnqB1UnlWv9boIgYE=
X-Google-Smtp-Source: APXvYqzAbpp9cWvO/5Q20Uh1Xeg67O94S+7/VhqoVQYdO4okz70YCgfpqwBtJ2WjHCff2pcoLKrMdhagXdt1Na3x4s0=
X-Received: by 2002:a5d:5542:: with SMTP id g2mr6965356wrw.232.1560876079916;
 Tue, 18 Jun 2019 09:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEB=iOsfuZQ5Z8uXO+k6E3WczkLX64yWUpTm1NZBjdd47kg@mail.gmail.com>
In-Reply-To: <CA+dzEB=iOsfuZQ5Z8uXO+k6E3WczkLX64yWUpTm1NZBjdd47kg@mail.gmail.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 18 Jun 2019 09:41:08 -0700
Message-ID: <CA+dzEBniPBM9qyR9gq=8sKtc8ieUkq6HGfUuZSc5=UdovR5wkw@mail.gmail.com>
Subject: Re: windows: error cannot lock ref ... unable to create lock
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hit send too quickly, here's my version information:

$ git --version
git version 2.22.0.windows.1

On Tue, Jun 18, 2019 at 9:38 AM Anthony Sottile <asottile@umich.edu> wrote:
>
> I've set up a demo problematic repository on github:
> https://github.com/asottile-archive/git-windows-branch-test
>
> The minimal reproduction is:
>
> rm -rf x
> git init x
> cd x
> git remote add origin https://github.com/asottile-archive/git-windows-branch-te>
> git fetch origin --tags
>
> Here's the output:
>
> + git init x
> Initialized empty Git repository in C:/Users/IEUser/x/x/.git/
> + cd x
> + git remote add origin
> https://github.com/asottile-archive/git-windows-branch-test
> + git fetch origin --tags
> remote: Enumerating objects: 10, done.
> remote: Counting objects: 100% (10/10), done.
> remote: Compressing objects: 100% (4/4), done.
> remote: Total 10 (delta 0), reused 0 (delta 0), pack-reused 0
> Unpacking objects: 100% (10/10), done.
> From https://github.com/asottile-archive/git-windows-branch-test
>  * [new branch]      master     -> origin/master
> error: cannot lock ref 'refs/remotes/origin/pr/aux': Unable to create
> 'C:/Users/IEUser/x/x/.git/refs/remotes/origin/pr/aux.lock': No such
> file or directory
>  ! [new branch]      pr/aux     -> origin/pr/aux  (unable to update local ref)
>
>
> real-world issue: https://github.com/pre-commit/pre-commit/issues/1058
>
> Thanks
>
> Anthony
