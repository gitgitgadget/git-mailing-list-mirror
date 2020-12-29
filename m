Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB282C433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 13:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0E207C9
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 13:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgL2NXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 08:23:00 -0500
Received: from mail.eskimo.com ([204.122.16.222]:40178 "EHLO mail.eskimo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgL2NW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 08:22:59 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2020 08:22:59 EST
Received: from eskimo.com (debian.eskimo.com [204.122.16.15])
        by mail.eskimo.com (Postfix) with SMTP id 334A7500588;
        Tue, 29 Dec 2020 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eskimo.com;
        s=default; t=1609247758;
        bh=tt6X3pG4HBM4QwZrwD/AwMt4ug9hJxLDzhOyaUtda28=;
        h=From:Date:To:Cc:Subject:From;
        b=NXVFyBCTVSwI6Zcp7/zLMQv0XQN+MFrtjuB5b3WCsXmED1DWTWtXZ0ppXIQ/CfOAi
         hD/o32z8tEDvKgbY1JSMm2Xr69jrcgzHeegRI34oz/ARzB6zpa9C2i2HZUCYEhjFb3
         oqu1saJZRcUP3Xp7yaPEtXwP34DC+pcWwHLOnW1v6TqcVEmvSNRFmQy4CpkNct+KnP
         z847zg4L+QRAQX7SOGBgaBwjle52oxUkjiLQgam+j6YKvAGXOjVAS63RoqeU0OAm9d
         myd4xq1S/ay7Mv28FLDOBS0+C2uWZ30RjKphH2Q5AfNB1qAA9i5LQfknwH2mU8Q6wX
         a2/P5uibxFvGw==
Received: (nullmailer pid 7525 invoked by uid 10926);
        Tue, 29 Dec 2020 13:15:58 -0000
From:   scs@eskimo.com (Steve Summit)
Date:   Tue, 29 Dec 2020 08:15:56 -0500
Message-ID: <2020Dec29.0815.scs.0001@quinine2.home>
To:     git@vger.kernel.org
Cc:     scs@eskimo.com
Subject: suggestion for git glossary: upstream, downstream
X-Virus-Scanned: clamav-milter 0.102.4 at mail.eskimo.com
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The terms "upstream" and "downstream" are heavily used in much
writing about git, with obvious meanings and implications for
those who use git regularly, but they're not defined at
https://git-scm.com/docs/gitglossary .  Perhaps they should be?
(Sorry, I'm not nearly experienced enough with git yet to write
good definitions myself, though.)
