Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111531FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 18:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935421AbeAKSAy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 13:00:54 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:44201 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932454AbeAKSAv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 13:00:51 -0500
Received: by mail-lf0-f43.google.com with SMTP id w23so3727251lfd.11
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 10:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=oTzWddfjRXsROUFW6xjQbWe2AdKZW5hBz7GLIMyGZ+A=;
        b=y8pxb1430oiXR9DiSXtBwMHPkPKjGg1c7OcIuO65zT+gTYuWLBg+jl3sWm76wUgIoX
         FV+SALuo07oBMrJVHXgUgKTPniZ1wXrTDF6wG1zdqSdJlSyQjUtx1gQ0CfueX9tjSHS2
         PRiR1eruFzHzsF0jrXSdPzSjxntpc2bgb99J2m9LsmwANIUiI1U5oF7HSSnHrq6NYGtD
         nBYAgi22IUneWT76TyW6bB92Xs7eB58iR8Emg1Fqv7vatEr4Jag5oQv8pcGu/87X+XK/
         XLSiBTyUfMkqlszDcvC156nh7VB4cykPzDSZF4JK4ZVHEB5hjDmxjXXRfcB/8JsJvDvs
         0lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oTzWddfjRXsROUFW6xjQbWe2AdKZW5hBz7GLIMyGZ+A=;
        b=gzWNb+h2PxMSXQoZxQxza9BAmrViKHaV1uzFo1rZPDiabQ3Kw0bAE0+N7Z8VWUKjLy
         2yToWl/6VUrhxLD/GXJe3g57H9F7hU9uUebl42hfzg0uKYBAo2ij4Z+2xAsIlxV7XSuT
         z5s7qsIJBbRfwdqde5DGdc6C6Hl7oTcPqXp5lmEZS8qgb7c/Bl0Dio/SfdIXfYuyQ1gd
         QG6NgaEl6YpPwznVZhdeH8Cj5YWXieKPK5Am6tLvnSD2yR+axfmUdpV1IMWmrJsW4rjg
         S6RyDT6Cri1+0hioqaabjsbeXPEGdvpphS6MUAOJqTrkm7uSNua0hmlU04Db8gBlZ7He
         ybyw==
X-Gm-Message-State: AKwxytfoSxLRY0QfmglJf8OB/euueF6qm7UKDj+YLa5tu2pEz9JOOH3+
        9uqg2bEsBjqYVxfiKUUtobUoeMh2QawB/uyznzcCxAdgUpM=
X-Google-Smtp-Source: ACJfBotnosxt1ainXFFtBrERhKw7+cT/rue/n0+hDoCP70ypNGV6eTJCktJyUOjFxaTvpFIcHB1kTCgwj1Ede04wquA=
X-Received: by 10.25.80.70 with SMTP id z6mr896478lfj.72.1515693649342; Thu,
 11 Jan 2018 10:00:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.150 with HTTP; Thu, 11 Jan 2018 10:00:48 -0800 (PST)
From:   Edward Thomson <ethomson@edwardthomson.com>
Date:   Thu, 11 Jan 2018 18:00:48 +0000
Message-ID: <CA+WKDT3uKyEfzGvnkRUG7SEKy4ypz+Aa223UaVE8vyktcmgSvw@mail.gmail.com>
Subject: [ANNOUNCE] Git London User Group: 16 January 2018
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git London User Group: 16 January, 2018
=======================================

I'm pleased to announce the formation of the Git London User Group, where
Git users and experts from throughout the UK can get together to share
tips, experience and assistance for using Git successfully.

The first meeting takes place Tuesday, 16 January, 2018 at 19:00.

Agenda
------
Extending Git through Scripting: Charles Bailey

Git is the most popular version control system in use today; it is highly
flexible and supports many different workflows.  One of its strengths is
its openness to scripting.  This talk looks at the basic principles that
support best practice for scripting Git and how to avoid some common
pitfalls.

Building Git Tools with libgit2: Edward Thomson

Edward introduces the libgit2 framework (http://libgit2.org), which is a
portable, implementation of Git as a library.  If you're looking for more
advanced programmatic access to working with Git repositories, libgit2 is
a good option, which is why it's used by many Git servers like GitHub and
VSTS and clients like gmaster and GitKraken.  Edward will introduce libgit2
and some of the language bindings like LibGit2Sharp (for .NET) and Rugged
(for Ruby).

Location
--------
General Assembly.  The Relay Building, 1st floor.
114 Whitechapel High Street London, E1 7PT.

We ask that you please RSVP at http://londongit.org/.

Sponsors
--------
A big thank you to the sponsors of the Git London User Group.  Bloomberg
has been kind enough to sponsor the meeting space for us to use.  Microsoft
has sponsored food for dinner.  And All Things Git (the Podcast about Git)
has sponsored meetup and registration fees.

Thanks also to Henry Kleynhans, the other organizer of the group.

Contact
-------
Follow us on Meetup by visiting http://londongit.org/, or on Twitter at
@londongit.

If you're in or around London, we hope that you'll join us next Tuesday!

Sincerely,
Edward Thomson (ethomson@edwardthomson.com)
