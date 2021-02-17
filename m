Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34524C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B9264E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhBQU5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:57:55 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:35263 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231766AbhBQU5y (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Feb 2021 15:57:54 -0500
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2021 15:57:53 EST
Received: from myt5-30ca2e5366d2.qloud-c.yandex.net (myt5-30ca2e5366d2.qloud-c.yandex.net [IPv6:2a02:6b8:c12:fa5:0:640:30ca:2e53])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id AE343600F2;
        Wed, 17 Feb 2021 23:48:45 +0300 (MSK)
Received: from mail.yandex.ru (mail.yandex.ru [81.200.17.53])
        by myt5-30ca2e5366d2.qloud-c.yandex.net (mxback/Yandex) with HTTP id hmjQ550IgKo1-mjISrIO1;
        Wed, 17 Feb 2021 23:48:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1613594925;
        bh=Spd91CVbCglq6YdN9ZXkBgGjQbvnOJ+2ssMT3HzvzgI=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=YqueniqrU+XEf1ZKKEh+THxNxvEikNiMe1jojg3/FDNlaAU46FBXN0ojSRfRGkNnG
         MIg6uHll8qLHg5yy/6zdVNOUID0izTm+buCLEJMOXNHhzqD7Nc3c3zMqCm0kML9KX5
         ib3M+uUstOxbG8wW9Hsb+zELwTHSPJ4F1Zp6no3E=
Authentication-Results: myt5-30ca2e5366d2.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-b646bde4b8f3.qloud-c.yandex.net with HTTP;
        Wed, 17 Feb 2021 23:48:44 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Knapperig knaapie <isaacvanson@kpnmail.nl>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <66eb4eba-ed94-b467-336b-dbe6f398d8af@kpnmail.nl>
References: <66eb4eba-ed94-b467-336b-dbe6f398d8af@kpnmail.nl>
Subject: Re: the git add command
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 17 Feb 2021 23:48:44 +0300
Message-Id: <277141613594706@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



16.02.2021, 19:08, "Knapperig knaapie" <isaacvanson@kpnmail.nl>:
> Hello there,
>
> I recently made a change to a project, and for adding a file I changed
> to the staging area I used the command 'git add ookleuk/admin.py'. At
> this point I was logged into the parent directory of 'ookleuk' on the
> command line. However, when I used the push command, I got the response
> 'everything up to date'. For now it isn't a problem, because when I used
> the command 'git add .' everything worked fine and the files in the
> repository got updated, but honestly, I want to be sure I'll be able to
> only upload specific files in the future.

In this case you should better use git gui to add files. It allows not only to add
individual files quickly, but also add specific part of changes in a file, e.g. omit
leftover debug lines or changes related to another topic. Corresponding
command line tools like git add -p or git add -i are quite tedious to use.

>
> A screenshot of the problem occurring on the command line is attached.
> Holler if you need more info.
>
> Greetings, Isaac


-- 
Regards,
Konstantin
