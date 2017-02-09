Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE4FC1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 17:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbdBIR0T (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 12:26:19 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34654 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdBIR0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 12:26:18 -0500
Received: by mail-yw0-f169.google.com with SMTP id w75so6337600ywg.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 09:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XVfET82JVPLjQLHQ4ifVmw5KsEVUOTEHLct6sg3Cflw=;
        b=ORTs0O1Zqb3Z/so7VschmLbg+mdbzUYvEVqpYH8sLQr0GInIOXtc9tyBamWjnodZv1
         S8W1BDi9QT4gGsIpdV03QPUnjqppi7HKaSYdBRGiPPY+rMsBCpVaP4nLLR1Ev32oHzB6
         FLUQiEIJb5FvWK/kwCiugCfToTg69F3T20ktO2r4oAbLEoWOO0XvukTZ8Eug9Amzg8fu
         dAlvI7GLzXf0ngAgNbGxv/yXx6/oZ463NE97v5HSvLajVULqmzKpJjNXUDxvaAAQLz4U
         lhJD/ptsXPBVfGDrP2qu6/R+5+m6T8rPEtAJgkPiufk5jrcSSy7KMEp387alGvYtjA1a
         VRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XVfET82JVPLjQLHQ4ifVmw5KsEVUOTEHLct6sg3Cflw=;
        b=IFmjR/lXlOMYhF5sGuW0awYzHiV21uKtuVfSo/NmBAEwQhuAUD+a/i6hcLLn3Cc4Aw
         BKTYQ0mA/E3W8kxdBEE+Pf+s17ivw6gn3OiO0LQuiSCguCwlusKS3pbmCsBPBm4uvSV7
         UYdTl+vQyVkx9SqbITVDizgJeba1v/GhJKyefL/Xi4pLUfnVZ7BYoSmyzkFFe7YYEoP9
         sPTq/T808CAZ3bIzALx/YoaZAnItZA2KUUMp1oiAZz53mFsQ2g8MXyTwZuTiya4J4Veb
         7VMs6wfPMB3IT9M/XCP5guUQf5oF+qKcBhm5TRLwr3rzVYt7L1Y88zCc7wRdVs+eD5PA
         zY5A==
X-Gm-Message-State: AMke39nlGBuDbk79WGMkPcQs8lRS2Aj7irsiLvGMNuayibUcCmyCWZf1x+hUmH4Bzq3xY6/XxMPZGPxG+oodWg==
X-Received: by 10.13.225.146 with SMTP id k140mr3133401ywe.323.1486661129872;
 Thu, 09 Feb 2017 09:25:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.83.88.78 with HTTP; Thu, 9 Feb 2017 09:25:29 -0800 (PST)
In-Reply-To: <CACsJy8DoXCNzryQusEcXtOgeU2ZH1FMGEK32z5b=PGkfvJ0BTg@mail.gmail.com>
References: <CAANrE7rmUZcJkw+thMczv3D=7sqcUHBsorzvEZgYg=6AEfrU=w@mail.gmail.com>
 <CACsJy8DoXCNzryQusEcXtOgeU2ZH1FMGEK32z5b=PGkfvJ0BTg@mail.gmail.com>
From:   Thangalin <thangalin@gmail.com>
Date:   Thu, 9 Feb 2017 09:25:29 -0800
Message-ID: <CAANrE7rXUCjBkgmGjiXMMJuTh+FXmw-bLKqonQ4BQP0_=p5m-Q@mail.gmail.com>
Subject: Re: Automatically Add .gitignore Files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

> This is a general problem to new files, not .gitignore alone. Can we

The difference, to me, is that a ".gitignore" file is not part of what
I'm developing. It's an artifact for git configuration. While a
.gitignore file is not always pushed to the repository, I imagine that
in most situations, it is.

Whereas when a "new" file is created, there are plenty of situations
where it shouldn't be added and thus a warning would be superfluous,
or an automatic add would be undesirable.

To solve the problem, generally, for new files while giving the user
the ability to specify exactly what "new" files should be
automatically added to the repository, something like the following
would work:

echo "**/.gitignore" >> .git/config/add-before-commit

> and perhaps you want to make it a habit to run it before committing.

Right, because software shouldn't automate repetitive tasks and humans
are never prone to forget? ;-)
