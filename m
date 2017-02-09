Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49AE81FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 10:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbdBIKEV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 05:04:21 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:34197 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbdBIKDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 05:03:35 -0500
Received: by mail-ot0-f171.google.com with SMTP id f9so9392069otd.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0osGErkHbaO9wAMYbQpbRFJAU8imAZT1JmfqUMTnv9M=;
        b=TstFfYtmuGqJ1AZ3g85V9S1rDGx3yep2JmCf7ThZjF6mA542lRNiTE7TFmBilkTpH2
         W148ESFGXheVQl/0Z0czG5RypWCfyw9NrHrUdo4tgh0izZ9oCBxEzYiyocdpFvC9mb+8
         bdfiL0kWsScqrrp8caJqjUaJHLQV1qiBnLKUGiZQaf/Each3ZNWzrch9HD4Z46+K4GER
         8MmXPIUlKWSLYCja0l1wSbCjwaoAzkVxYGCCTclOZYxm7WQaauYbW494lh9TXWTUQZ0l
         5I07iz6vfPsTEcj6a9YLC2fqD8Jedt2o5O7AbHDqGH6Bsdj/8A0FepLzCRO8qKGqxq6Q
         OTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0osGErkHbaO9wAMYbQpbRFJAU8imAZT1JmfqUMTnv9M=;
        b=lXZ959+I3L0MW7w8GppQGv4hEnpJsaJLOjv3CSmllVwPTXtDUCL6JoQEybefTwa/17
         YCJ9a70WKRPw7uAELMDe5mHT3B8M1wq6AWpNohpeb/mHSg9dyiJwY6yJzK8KjNmVgGSB
         WXLaIQW1UbHjpdKikZpq6o7U8m9Xsf7g/Q4YQ9BE6ZaNmISQDIYCyy2QtJODXWUD229C
         SFgADbE6z89GfZH5lAx1J9XBJYCoYt3hm9+hZBVoxVw8jRlJqj4PI8NoEYi77NaWZ39a
         JsDCtjgGHoVMShiuhMVBpNZnBupc1tgjcvrg2kPRNkJ4+FE6kf6PxSZPW1Dx6AxpI80t
         j5xA==
X-Gm-Message-State: AMke39mzNTPxyJ+5Qt/vlKi1Mvn4tsTnZqnIYEmArCjExQO0W5bjNhczMc/DKwHyz4HKUUO6gh7hUxrfCXqsng==
X-Received: by 10.157.39.35 with SMTP id r32mr1061362ota.199.1486634610761;
 Thu, 09 Feb 2017 02:03:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 9 Feb 2017 02:03:00 -0800 (PST)
In-Reply-To: <CAANrE7rmUZcJkw+thMczv3D=7sqcUHBsorzvEZgYg=6AEfrU=w@mail.gmail.com>
References: <CAANrE7rmUZcJkw+thMczv3D=7sqcUHBsorzvEZgYg=6AEfrU=w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 9 Feb 2017 17:03:00 +0700
Message-ID: <CACsJy8DoXCNzryQusEcXtOgeU2ZH1FMGEK32z5b=PGkfvJ0BTg@mail.gmail.com>
Subject: Re: Automatically Add .gitignore Files
To:     Thangalin <thangalin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 2:05 AM, Thangalin <thangalin@gmail.com> wrote:
> I frequently forget to add .gitignore files when creating new .gitignore files.
>
> I'd like to request a command-line option to always add .gitignore
> files (or, more generally, always add files that match a given file
> specification).
>
> Replicate
>
> 0. git init ...
> 1. echo "*.bak" >> .gitignore
> 2. touch file.txt
> 3. git add file.txt
> 4. git commit -a -m "..."
> 5. git push origin master
>
> Expected Results
>
> The .gitignore file is also added to the repository. (This is probably
> the 80% use case.)

This is a general problem to new files, not .gitignore alone. Can we
accomplish something with some hook? At the least I think we should be
able to detect that .gitignore is not detected and abort, prompting
the user to add it. It's easier to customize too, and we don't have to
cook ".gitignore" in the code.

I'm not sure if we tell the hook "this is with -m option" though..
-- 
Duy
