Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6AF1F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 10:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeCZKtK (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 06:49:10 -0400
Received: from fallback7.mail.ru ([94.100.181.128]:34128 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750973AbeCZKtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 06:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=r7PgKfvD8+y+2Cac994WLuetmEl5CbskxBxfgunlUAw=;
        b=hBVi9b/n/iTDS5g1Egh99F8h+//zoquAcfitd7uq7T1BIKbBLQr7dAtOkWheMoa+RjZ0IiHDrF87fiCIvDDUhKIKpvxrSE6tjwBk+6L9nZfsh+IkDs+fB3gSABL0HBijQXUH5oNoTrej1ZdLYW94c7rGajL2eR9c8FVHkuACzRE=;
Received: from [10.161.25.38] (port=36260 helo=smtp61.i.mail.ru)
        by fallback7.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
        id 1f0PgX-0002jT-Ju
        for git@vger.kernel.org; Mon, 26 Mar 2018 13:49:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=r7PgKfvD8+y+2Cac994WLuetmEl5CbskxBxfgunlUAw=;
        b=hBVi9b/n/iTDS5g1Egh99F8h+//zoquAcfitd7uq7T1BIKbBLQr7dAtOkWheMoa+RjZ0IiHDrF87fiCIvDDUhKIKpvxrSE6tjwBk+6L9nZfsh+IkDs+fB3gSABL0HBijQXUH5oNoTrej1ZdLYW94c7rGajL2eR9c8FVHkuACzRE=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1f0PgQ-0001OV-Qe; Mon, 26 Mar 2018 13:48:59 +0300
Date:   Mon, 26 Mar 2018 13:48:55 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     shirlin.joseph@bt.com
Cc:     git@vger.kernel.org
Subject: Re: FW: Merging in Git with Branches
Message-ID: <20180326104855.cfdmgeleemexumin@tigra>
References: <84fd5584332c450abe8b634921e7b568@rew09926dag15b.domain1.systemhost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84fd5584332c450abe8b634921e7b568@rew09926dag15b.domain1.systemhost.net>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A533FF3495ABFFD75F69E79910653896AE6FF3568D5EDE65B6725E5C173C3A84C36DD0439D4B94EFE571AF88F3E4E3FBA18CCB3ED2A1DE2304C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F8DB212830C5B42F72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA40DB2439E42E91676901A5D426E36568CFADA28E124720B3CFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 10:12:04AM +0000, shirlin.joseph@bt.com wrote:

[...]
> Currently there are two main branches that we are utilizing A(master)
> and B(branch of A). Branch is utilised for individual stories(as per
> delivery).
[...]

Cross-posted to [1] as well.

1. https://groups.google.com/d/topic/git-users/nN_faSpd4A4/discussion

