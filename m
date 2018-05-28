Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2321F51C
	for <e@80x24.org>; Mon, 28 May 2018 11:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeE1L7G (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 07:59:06 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:52806 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938469AbeE1L6q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 07:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3QrgnaEosq9IZ/4+jVPwhmubu5Nml3M1hQqSqDHAddQ=; b=uEGdxpcK/qj/DWHZJNBjitIlOW
        sN4tpwy45Oy9mkAt61GxUbnCCykfYmaE2i1wwNsx6pu5wEJOYzE6Sj1TPo4SnMkEVVwep1dj7Dz6j
        vZ/7Frz22DtI7MDkK7vytGE140Uca95EMeigcSGzdyXPF4GlBWr7f6DiNBMMZgOTCzLkBPBrOyNUO
        yfsJTm8/MDFIKzjogpPH6jSEs7sLDG8DRmeV0bEChdF6VjfLSYPN7EluyUPFQCTnzoBYotqyU92q2
        NctxpUsplFMHNYm3qCsTLFQ7+MsbKgkhAvplyswpRhpBXFj01FFUYaf4B/ha7ttk5waxORktwVYqj
        MQ16q6bA==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:42372 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fNGnT-001qa0-6p
        for git@vger.kernel.org; Mon, 28 May 2018 07:58:44 -0400
Date:   Mon, 28 May 2018 07:56:52 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: protocol for updating .po gettext files?
Message-ID: <alpine.LFD.2.21.1805280754160.8049@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


   i was going to submit a minor patch to fix grammar here:

builtin/init-db.c: warning(_("templates not found %s"), template_dir);

as it should display "templates not found in %s" to be consistent with
other messages, but i know from nothing about .po files, so does one
also have to update those, or how does that work?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
