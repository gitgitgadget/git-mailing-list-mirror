Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63DE31F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 00:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbcITAtK (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 20:49:10 -0400
Received: from [195.159.176.226] ([195.159.176.226]:47182 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbcITAtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 20:49:09 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bm9F7-0003Ai-I1
        for git@vger.kernel.org; Tue, 20 Sep 2016 02:49:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: .git directory tree as tar-file
Date:   Tue, 20 Sep 2016 00:48:45 +0000 (UTC)
Message-ID: <nrq11d$4l9$1@blaine.gmane.org>
References: <1474317076.23916.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

if multiple small loose files are the problem, this could be interesting
for you:

https://git-scm.com/docs/git-gc

This command is run automatically from time to time, and you can
configure it or run manually.

PS To see how bad the situation is, you can use

https://git-scm.com/docs/git-count-objects


-- 
Mit freundlichen Grüßen,
Anatoly Borodin

