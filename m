Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C333C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0537B64ED3
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZH4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:56:40 -0500
Received: from gate3.osm-gmbh.de ([194.77.68.107]:35082 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZH4j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 02:56:39 -0500
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id B659B3C07F;
        Fri, 26 Feb 2021 08:54:59 +0100 (CET)
Received: from pcmn.osm-gmbh.de (pcmn.osm-gmbh.de [193.101.76.39])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id 9C23F3DC01E;
        Fri, 26 Feb 2021 08:54:59 +0100 (CET)
Date:   Fri, 26 Feb 2021 08:54:59 +0100 (CET)
From:   Martin Nicolay <m.nicolay@osm-ag.de>
Sender: martin@pcmn.osm-gmbh.de
Reply-To: Martin Nicolay <m.nicolay@osm-ag.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: bug: setting GIT_DIR to $(git rev-parse --git-dir) changes
 behavior
Message-ID: <alpine.LSU.2.20.2102260846280.20742@cpza.bfz-tzou.qr>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
X-Virus-Scanned: by "The Virus" itself
X-Mailer: Pine 4.63
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 2021-02-25 19:29, Junio C Hamano wrote:
> The root of the working tree is at /tmp/t/, the repository at
> /tmp/t/.git/, and you are in the foo/ subdirectory.  When you ask
> "where is the top level of the working tree in this state, because
> you do not have GIT_DIR or GIT_WORK_TREE environment variables, you
> are asking Git to "discover" both the .git/ directory and the top of
> the working tree, by starting at the current directory,
> i.e. /tmp/t/foo, which is where you are.

*facepalm* The part about GIT_DIR setting the work-tree in addition to 
the repository I hadn't read. How embarrasing.

I apoligize for my bad reading skills and wasting you time.

Thanks
Martin
