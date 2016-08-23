Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7313D1F859
	for <e@80x24.org>; Tue, 23 Aug 2016 00:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbcHWAEt (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 20:04:49 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:32923 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932457AbcHWAEs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 20:04:48 -0400
Received: by mail-ua0-f177.google.com with SMTP id 74so218221086uau.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 17:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=IUqy5yUr1LSRJzpgLBEEyawXRa9XCq7MtlUMGK25GSs=;
        b=xAPnAMbXU5VsUU09Ob2MoTelpbgBdMC0zKilv085DD7GpdcLs5admNpkWM212F0AjA
         CSq4Qc5HXytHJWBBAWCwoQ/DMsCkDkKEYtJ6D9jrp3zJZ+kSPoA3y/ZYghhtqe8B69oZ
         jkng+hLTU/QT+KdLvnrwB9B+W9bQT0/0TYEnknQ5zo80mRYNpM/Tb5rd8FPkrJ6YfvYR
         kVFccFyIzeS1/6K20oGrHS7tVRIXPVIQk4wQd1dD7Wcx1j4aDAhqLx4v3yV+DFJLo959
         5zbl7OJQmRRWI9/gCZtV4Gp/Qmz4myXgUao1npAsNCZVhg+q93hoO2ASBUjLBbVYzc+e
         3wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=IUqy5yUr1LSRJzpgLBEEyawXRa9XCq7MtlUMGK25GSs=;
        b=UPrx/gdqYhslZqH8VreCx4OmwbQVgpmphb9xTwTtR5pC1tiPwLq1UTwaHp6nNHdsWQ
         bmDTijTuFPNWE6lWzEpUOkw0np2ZKV11EnkXZyeThTAbZi7yiSo54fBwf5CGLt8ica+H
         NZYR6r1MbManbtBtYr28YS/ErvE5rQ0N833t4q/GHTB1ILPRsOT+BC+W+5kEjaKMvMXv
         Bp/aUYMPfYgAZqoLtboj/gmVFat9yx25LB08fco5I+vh64U5kyjSJtwWCZYu0U7QH2qk
         2FOGXY1aBxshuBr6PoUky2YrRX8wOqQFKrPRmFsyYR2lZ6QFGAEJNzAVvrtKRgT38tEf
         ZU5w==
X-Gm-Message-State: AEkoousZm/H7ny7grZkBtKi7zxD8AbiuP7a2NmMFWFBYYUvgs4RZ0GnFwbr/NLEKbQCGIrmDvSIDo1Tm79jeig==
X-Received: by 10.31.176.134 with SMTP id z128mr13072639vke.86.1471910687685;
 Mon, 22 Aug 2016 17:04:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.85.4 with HTTP; Mon, 22 Aug 2016 17:04:47 -0700 (PDT)
In-Reply-To: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
From:   Lucian Smith <lucianoelsmitho@gmail.com>
Date:   Mon, 22 Aug 2016 17:04:47 -0700
Message-ID: <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
Subject: Re: git-svn bridge and line endings
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm attempting to use the git-svn bridge, and am having problems with
line endings on Windows.

The setup is that we have a git repository on github, and I've checked
out a branch on my Windows machine using Tortoise svn.  I make
changes, commit them, and the branch is updated.  In general, this
works fine.

If this was just SVN, I could set the 'eol-style' for files to
'native' to let it know to expect Windows/linux/mac line endings for
particular files.  This seems to be handled in git by using the
'.gitattributes' file instead.  Unfortunately, the git/svn bridge
doesn't seem to be translate the information in the .gitattributes
file to appropriate eol-style settings in SVN.  Checking out a file
using SVN on Windows leaves me with a file without CRLF's, and if I
check in a CRLF file, that's the way it goes into the repository.
Differences in CRLF alone show up as 'real' differences that can be
checked in, and, if this happens, this causes problems with other
people's repositories.

Am I doing something wrong; is there another way to handle this; or
can I file this as a bug report/feature request?

Thank you!

-Lucian Smith
