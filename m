Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C3EC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 22:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF3C21D6C
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 22:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgJMWUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 18:20:31 -0400
Received: from vulcan.kevinlocke.name ([107.191.43.88]:53232 "EHLO
        vulcan.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJMWUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 18:20:31 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 18:20:31 EDT
Received: from kevinlocke.name (host-69-145-60-23.bln-mt.client.bresnan.net [69.145.60.23])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id D37111D03AB1;
        Tue, 13 Oct 2020 22:12:52 +0000 (UTC)
Received: by kevinlocke.name (Postfix, from userid 1000)
        id E9F5D13036D6; Tue, 13 Oct 2020 16:12:50 -0600 (MDT)
Date:   Tue, 13 Oct 2020 16:12:50 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     git@vger.kernel.org
Cc:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [Request] gitweb: tag feeds
Message-ID: <20201013221250.GA20483@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I've found the support for Atom and RSS commit feeds in gitweb to be
very useful.  I'd like to extend the support to include tag feeds as a
simple means of announcing/tracking releases.  Might such a feature be
acceptable in some form?

Giuseppe Bilotta raised this idea and provided an implementation in
2012[1] and 2017[2] which did not receive any responses on-list that I
could find.  Would these be a suitable starting point?

Thanks for considering,
Kevin

[1]: https://lore.kernel.org/git/1348603845-9084-1-git-send-email-giuseppe.bilotta@gmail.com/
[2]: https://lore.kernel.org/git/20170419064916.18663-1-giuseppe.bilotta@gmail.com/
