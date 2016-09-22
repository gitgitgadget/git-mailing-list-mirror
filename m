Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878B01F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 21:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034679AbcIVVCF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 17:02:05 -0400
Received: from [195.159.176.226] ([195.159.176.226]:43922 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1034676AbcIVVCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 17:02:03 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bnB7s-0005j7-Sh
        for git@vger.kernel.org; Thu, 22 Sep 2016 23:01:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
Date:   Thu, 22 Sep 2016 21:01:24 +0000 (UTC)
Message-ID: <ns1gr4$pjs$1@blaine.gmane.org>
References: <1mtveu4.19lvgi1c0hmhaM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

I've also done some archaeology and found that the original version of
the merge preserving code was written by Johannes Schindelin
<Johannes.Schindelin@gmx.de>, see e.g.
f09c9b8c5ff9d8a15499b09ccd6c3e7b3c76af77

There were also some big discussion threads in 2007-2008 regarding a
better mechanism to "mark" or "tag" the heads of rebased branches, but I
haven't seen consensus and development in that direction after that.

PS There are also some pieces of "what should work" in these tests:

t/t3409-rebase-preserve-merges.sh*
t/t3410-rebase-preserve-dropped-merges.sh*
t/t3411-rebase-preserve-around-merges.sh*
t/t3414-rebase-preserve-onto.sh*


-- 
Mit freundlichen Grüßen,
Anatoly Borodin

