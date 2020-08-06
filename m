Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEA5C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DBA20855
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgHFRcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:32:04 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:58230 "EHLO
        smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgHFRbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:15 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb1-g21.free.fr (Postfix) with ESMTP id A2791E06D3D
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 16:54:12 +0200 (CEST)
Received: from panel-Aspire-1425P (unknown [IPv6:2a01:e0a:562:1540:a670:ff22:ed7e:bd05])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 36E3613F8D6
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 16:48:40 +0200 (CEST)
Message-ID: <1596725319.6764.7.camel@free.fr>
Subject: git bug
From:   PANEL Christian <ch.panel@free.fr>
To:     git@vger.kernel.org
Date:   Thu, 06 Aug 2020 16:48:39 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

someting is not logical in the behaviour of git :

suppose I have a project and a file in it I don't want to include initially in.
so I put this file name in .gitignore
now all is OK when I write "git status" : the file is ignored.

but later I want this one be a part of my project.
I delete in .gitignore the line that named this file.
but now a "git status" command ignore always this file.

what is wrong ?
did I missed something ?

thanks for any answer 
