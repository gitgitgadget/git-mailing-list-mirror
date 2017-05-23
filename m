Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A201E20281
	for <e@80x24.org>; Tue, 23 May 2017 15:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965252AbdEWPNR (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 11:13:17 -0400
Received: from imap.thunk.org ([74.207.234.97]:55706 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764398AbdEWPNP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 11:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=OdzExgJLkaTa6Nm9/8auMhhwLo0uuG2f1Ce9Pv8A8CU=;
        b=H8uh8FlWGWNXVY7af6Hd5zsfTOXW1S01lVRuQpnfIXNY72N60QH+E87XRENUrZpb1UGjcRmzeRgveSKMza0HxZ719BTUYq+z6hdp8QaXxstXgQfuvc8TjbC0T0MVfwD+aYhGwcC5kutUIpB1coxktE9lyMfjchi8D/T5lc4v/HI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.84_2)
        (envelope-from <tytso@thunk.org>)
        id 1dDBUk-0003DF-T1; Tue, 23 May 2017 15:13:10 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3CA31C002F7; Tue, 23 May 2017 11:13:10 -0400 (EDT)
Date:   Tue, 23 May 2017 11:13:10 -0400
From:   Theodore Ts'o <tytso@mit.edu>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, webmaster@kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Another git repo at kernel.org?
Message-ID: <20170523151310.mhdhck5djmdlxrt4@thunk.org>
References: <CAGZ79kYirjV0eQgB_ng-64HSPN_7njUMjnoNBkmWnx-rinsemQ@mail.gmail.com>
 <CACBZZX7HYU1USdcX_=CDFiMDtdaySSjd0zv-Bb1Z9-nHxk8UvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACBZZX7HYU1USdcX_=CDFiMDtdaySSjd0zv-Bb1Z9-nHxk8UvQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So Junio owns the pub/scm/git/git.git tree on kernel.org, and he may
already have access to create new repo's under the pub/scm/git
hierarchy.  In which case we might not need to bug the kernel.org
administrators at all.

Also, I'll note that it is possible to set up some repo's such that a
group of people have access to push to them.  You'll see for example
on git.kernel.org that certain repositories have as their owner "XFS
FS Group", or "ARM64 Group" or "Intel Wireless Group".

Cheers,

					- Ted

