Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612301F404
	for <e@80x24.org>; Mon, 13 Aug 2018 14:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeHMRQM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 13:16:12 -0400
Received: from mailrelay4.webfaction.com ([185.20.51.6]:40990 "EHLO
        mailrelay4.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeHMRQM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 13:16:12 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Aug 2018 13:16:11 EDT
Received: from mailrelay3.webfaction.com (mailrelay3.webfaction.com [207.38.93.110])
        by mailrelay4.webfaction.com (Postfix) with ESMTPS id 65E0112047E
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:26:20 +0000 (UTC)
Received: from mailrelay1.webfaction.com (mailrelay1.webfaction.com [207.38.86.46])
        by mailrelay3.webfaction.com (Postfix) with ESMTPS id 0EA5C28032C
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:26:19 +0000 (UTC)
Received: from smtp.webfaction.com (mail6.webfaction.com [31.170.123.134])
        by mailrelay1.webfaction.com (Postfix) with ESMTPS id 267291A0139
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:26:18 +0000 (UTC)
Received: from localhost (unknown [145.118.66.104])
        by smtp.webfaction.com (Postfix) with ESMTPSA id 2C4AC61467CA8
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:26:13 +0000 (UTC)
From:   Christoph Groth <christoph@grothesque.org>
To:     git@vger.kernel.org
Subject: Suggestion: "git describe" pretty format
Date:   Mon, 13 Aug 2018 16:26:16 +0200
Message-ID: <87a7pq9wc7.fsf@grothesque.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Many projects use 'git archive' to generate tarballs, especially because
this functionality is exposed through gitlab/github and the like.  It's
also popular to base the version string on the output of 'git describe'
and its variants, for example 'git describe --first-parent --dirty'.

Now while it's possible to substitute various information into the
tarball using the export-subst machinery, there seems to be no way to
substitute the output of 'git describe' and its variants.  Specifically,
when the commit being archived is untagged, there seems no way to
mention an ancestral tag in the way of 'git describe'.

It seems to me that adding a pretty format for git describe would be
very useful.  Is there any technical reason that speaks against this?

Cheers,
Christoph
