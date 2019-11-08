Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D981F454
	for <e@80x24.org>; Fri,  8 Nov 2019 16:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfKHQcU (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 11:32:20 -0500
Received: from fallback17.m.smailru.net ([94.100.176.130]:58144 "EHLO
        fallback17.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHQcU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 11:32:20 -0500
X-Greylist: delayed 2498 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 11:32:19 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8j/rcnR6/3YZfpKyLZa/G1wSa4Th7coyJh1mVh9bUsQ=;
        b=HW581eS8iJajZaXIk8uXu1WkwEncx2GRqVMag6tGLWBh4lM8wTgBGIoZ8hX6bJ4rHNvnRChEmudwxe1oEEA4tIzxCXChkEDYi5YP2MswiG0ou5HKm6zHFZ2ZnA3uts64hksCkgNxsDgN/+1rwV9FtZlf11F2W3UX+Fj3tscPD8E=;
Received: from [10.161.64.58] (port=52246 helo=smtp50.i.mail.ru)
        by fallback17.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1iT6X1-0002Ho-T6
        for git@vger.kernel.org; Fri, 08 Nov 2019 18:50:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8j/rcnR6/3YZfpKyLZa/G1wSa4Th7coyJh1mVh9bUsQ=;
        b=HW581eS8iJajZaXIk8uXu1WkwEncx2GRqVMag6tGLWBh4lM8wTgBGIoZ8hX6bJ4rHNvnRChEmudwxe1oEEA4tIzxCXChkEDYi5YP2MswiG0ou5HKm6zHFZ2ZnA3uts64hksCkgNxsDgN/+1rwV9FtZlf11F2W3UX+Fj3tscPD8E=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1iT6Wz-0000sN-OK; Fri, 08 Nov 2019 18:50:38 +0300
Date:   Fri, 8 Nov 2019 18:50:37 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Ingo Wolf <ingo.wolf@gmx.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: No Checkout / Read Only config Flag
Message-ID: <20191108155037.rru2glzbdw4npnte@carbon>
References: <f3378b7b-c745-58db-55ed-c2c2a6818734@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3378b7b-c745-58db-55ed-c2c2a6818734@gmx.de>
User-Agent: NeoMutt/20180716
X-77F55803: 260C666A7D66B36A5A78504BD2AC2941E0C0C82CBBAFDA2BEDEEF17ECFBE9C02137231B69A2FB8A02B5432A15BB65C7B
X-7FA49CB5: 0D63561A33F958A55B88D41E9D35B7E23CA1C43BCBEF2B0D734FC775FE8397098941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B974A882099E279BDA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249B7D05AE7F929A77276E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8BFF43DADFC37A44AE3AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D725E5C173C3A84C321259270BBF67A20EA9B2710CC0E445AC96613F75B7D048DC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1384F70771B43449E81DCA70E8487A0F378689405F4F1B06A7413BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC67EA787935ED9F1B
X-Mras: OK
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDC0167AAF03A6D4B913FF0ED5B7D7FD81F8A6DC88605567868448FDF722B05D9BA
X-7FA49CB5: 0D63561A33F958A5674635A8BD02E10B4EB9675D06883D83EBCC5489ED2631A28941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B974A882099E279BDA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224949582130F7F636E276E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8B1828415F759045ED3AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D462275124DF8B9C9DF33B08B2BB81206574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: A5480F10D64C90054F94DD2E9EA85DB61876FE5CF86A328C3FF0ED5B7D7FD81FD4C8C1974AB4F6CBFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 10:34:32PM +0100, Ingo Wolf wrote:

> is there a readonly / no checkout flag in the git configs?
> 
> I use Git to trace / Backup some worktrees and would like to prevent
> changing them accidentally with git.

There's so-called "sparse checkout" feature in Git: it allows the user
to designate parts of the work tree hierarchy as uninteresting, and Git
won't touch them unless told otherwise.

Please refer to the section "SPARSE CHECKOUT" in the git-read-tree
manual page (run `git help read-tree`).

To cite the git-checkout manual page:

| --ignore-skip-worktree-bits
|   In sparse checkout mode, git checkout -- <paths> would update only
|   entries matched by <paths> and sparse patterns in
|   $GIT_DIR/info/sparse-checkout. This option ignores the sparse patterns
|   and adds back any files in <paths>.

