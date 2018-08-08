Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD81208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 07:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeHHJxS (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 05:53:18 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37666 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeHHJxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 05:53:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id w76-v6so884453ywg.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 00:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HShh7CXAfFDQtH9amzqnaFDLnCjsVogqDOlUYO8SYNI=;
        b=cfDZWthLThHy2M+FbX5rZWGjY6woI0FGJRsFUh+JdmU8DOv50wvS5AX7NykAtTGEFo
         kJ7b1GCT/c5fH7FOwPBoU1luzQheRG09Epyi0vRnSyyBWtXjyFcvEl4t26tD1E+LQGsa
         RbqBxeA5TsaHfq1Z1umtaJkozw1TblJy8N9tH9V0OK0vqtpb6qcmkpRkhBpmnFwUuARh
         RpOraGRjCybluQ4apf5/1fcRMUE+ID/nBEhRG1bVu38R01GsHPV6axxyfLAF1C/YBNsR
         8ctCx1jxIHe8pt3rY1cnA54wltRRh+GLmuheaW/YxrcS6XKMssuuO4V6RpvOumq+vnDW
         p4GA==
X-Gm-Message-State: AOUpUlFp58Myb0nDx9Ef9Dd9UPnqNKopSXwgsuZrefBjaC+7wlu7eAue
        lujfiiuy2fc7HbCiMB0x5mtT90kEiku36TSUVIE=
X-Google-Smtp-Source: AA+uWPxvRD6wT8IshwFSn5hkE0xHUwoFFBn8iFKDyJMM8AllYPi18uzOyjE/I/5lnmNggAhiRquH8QrD+lk+I1Cm8bA=
X-Received: by 2002:a25:900e:: with SMTP id s14-v6mr173924ybl.497.1533713693330;
 Wed, 08 Aug 2018 00:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180804181539.29536-1-guriev-ns@ya.ru> <20180808063926.11911-1-guriev-ns@ya.ru>
In-Reply-To: <20180808063926.11911-1-guriev-ns@ya.ru>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Aug 2018 03:34:41 -0400
Message-ID: <CAPig+cTD7XYbaPBzj36Eudrud80r-cz1CPLDsLA9CHJC6Yc-Qw@mail.gmail.com>
Subject: Re: [PATCH] status: -i shorthand for --ignored command line option
To:     guriev-ns@ya.ru
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the submission. A few comments below...

On Wed, Aug 8, 2018 at 2:48 AM Nicholas Guriev <guriev-ns@ya.ru> wrote:
> This short option saves the number of keys to press for the
> typically git-status command.
> ---

Your sign-off is missing. See Documentation/SubmittingPatches.

It's clear that a short name would be helpful to you, but you may need
to work harder to convince others that it makes sense to squat an a
short option name like 'i'. One argument you might use in the commit
message in support of adding a short name to --ignored is that the
related option --untracked-files already has a short name (-u).

>  builtin/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch neglects to update the documentation for git-status in
Documentation/git-status.txt. It will need to do so if this change is
ever to be accepted.
