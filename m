Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E45C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF765206E9
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbQW8eKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbgDBNjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:39:05 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:33674 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388623AbgDBNjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:39:04 -0400
Received: by mail-lf1-f44.google.com with SMTP id x200so2781618lff.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FI2l8OHqjVxNcw6ZGzjakmk2Vw1KXvtS7M08r7S1q6I=;
        b=ZbQW8eKfAICSlEot1gDWuJOsQ7gOxibB3vV2gpG5xximVzkYsQycEWifgCTDpejhoY
         hLjyiqQeftT+M7auKOUNp5BS2MVObJlgUYa/0hE4lE8Do+FQRUN3lh1cSlyxVNTL5hvI
         Z5obu8WExYXDHoKMtJRlXcpb/ccU1mWVcwnN+h86SGv9mf8ZVGk9RzXVQy21Rr1hXsHx
         gD+XED3VwgWt+UB/akoSjYx+dTDKtZmOT7xjQ13xd+pvF0gN4BjaaWTPT4dYPqninojg
         ZYtqsNz/AiX4rG1OHDtxhqEw4S4RLe1f0yfAgHWWC3cscT3+8PCFUEM1U0nVLfEMVWdm
         GETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FI2l8OHqjVxNcw6ZGzjakmk2Vw1KXvtS7M08r7S1q6I=;
        b=mhVFXDFQ2EnAeZGFhPurav5bliN+1vbXJbtmntNQymsqMCosvZ3b/k4jE/V5aXtMfm
         A9aZUcFSmAbA8pZAmhztje5iNS/Qnr5KpxZPpFoDEQM28gDIKXR5lR9VepI79WTwsqcu
         VwqWfpK8aRSZKDwYTJZBaxfgwKyVnJBkd0y0ErIneYUzYU454OZzBwre2qTf0l66GOJ6
         9MCiOAz5NxanS35w/ddiTmtSwPPBkintCxtsD15H99PFWsENIFIjnaXpWVJ0cwjHZsor
         56sBS/V71MkPWr7dYxdMl/FnyfnGN64K59O66qqt0lja/zBBeGM9iTW7WKxYtaEwpHci
         D25A==
X-Gm-Message-State: AGi0PuYDNNCY9oSZrNte1IIhAT9PZk66myQIFusCPXA0AvFT9agJPkn+
        GoQeQRnw0ZgRxJ+vxsW9WXXjyKxjOIOW7AGIQezPY7J4/mo=
X-Google-Smtp-Source: APiQypIRM4apK9BG66YWDlPsO9r38UX2jYdm9CSNLRd8fxpnJfk/TIoyivOK3l1tqzH0CeY2jooUMaSSrj6vtoQ6Kks=
X-Received: by 2002:ac2:5146:: with SMTP id q6mr2242649lfd.81.1585834741782;
 Thu, 02 Apr 2020 06:39:01 -0700 (PDT)
MIME-Version: 1.0
From:   Sonu Mittal <sonumittal.mittal44@gmail.com>
Date:   Thu, 2 Apr 2020 19:08:49 +0530
Message-ID: <CAPk=7ZrTBkxHzN82223=3r+fcUU+kRW-LMbgOSDFw+Bb4yQn6g@mail.gmail.com>
Subject: Can not logout from github account on git bash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am beginner and new to GitHub and git bash, I experimented with git
bash to clone a repository onto my system. Was successful in cloning
.Now i don't want to clone any more repositories and want to logout of
my GitHub account.
After using internet help i had successfully removed the git
credentials from windows credentials manager but then too when my
again using git bash i am able to clone repositories without even
entering my credentials of GitHub account (I tried restarting and
doing again but wasn't successful in accomplishing to logout of my
GitHub account from git bash and other terminals).
Please help me so that i can logout from my GitHub account from the terminal .
