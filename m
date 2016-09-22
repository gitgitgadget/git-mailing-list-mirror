Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D931F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 21:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934098AbcIVVFQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 17:05:16 -0400
Received: from [195.159.176.226] ([195.159.176.226]:47874 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S933098AbcIVVFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 17:05:15 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bnBB3-0003V1-1k
        for git@vger.kernel.org; Thu, 22 Sep 2016 23:05:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
Date:   Thu, 22 Sep 2016 21:04:09 +0000 (UTC)
Message-ID: <ns1h09$pjs$2@blaine.gmane.org>
References: <1mtveu4.19lvgi1c0hmhaM%lists@haller-berlin.de> <ns1bln$2ej$1@blaine.gmane.org> <20160922194848.GB6641@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

Kevin Daudt <me@ikke.info> wrote:
> Changing the order, or dropping commits might then give unexpected
> results.

The question that Stefan has is rather "what is *supposed* to work /
give *expected* results?". Some stuff can be found in the tests
(t/t*rebase*preserve*), but maybe there is more?

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

