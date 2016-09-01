Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339B71F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 15:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755074AbcIAP3V (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 11:29:21 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:35953 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbcIAP3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 11:29:20 -0400
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id A3452C5A78
        for <git@vger.kernel.org>; Thu,  1 Sep 2016 17:29:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter30-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter30-d.gandi.net (mfilter30-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id 8-5UbD_cRuyB for <git@vger.kernel.org>;
        Thu,  1 Sep 2016 17:29:17 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7E095C5A5D
        for <git@vger.kernel.org>; Thu,  1 Sep 2016 17:29:16 +0200 (CEST)
Date:   Thu, 1 Sep 2016 08:29:14 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
Subject: format-patch base-commit: moving to above the patch?
Message-ID: <20160901152912.uhxapgd3isdjc4mn@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, format-patch puts base-commit and prerequisite-patch-id
information below the patch, and below the email signature.  Most mail
clients automatically trim everything below the signature marker as
unimportant when quoting a mail for a reply, which would make it
difficult for someone to reply, quote the base-commit, and say something
like "I don't have this commit, where did it come from?" or "Can you
please rebase this on ...".

Might it make sense to move this information adjacent to the diffstat,
instead?  Or, at least, above the email signature?
