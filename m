Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2855E1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 13:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031525AbeBONcJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 08:32:09 -0500
Received: from fallback9.m.smailru.net ([94.100.178.49]:54743 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1031104AbeBONcI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 08:32:08 -0500
X-Greylist: delayed 4092 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Feb 2018 08:32:07 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=OxHjgEWSw2/GC/wai7MQFhnIV4qYN/XcK9hvmc5/Em4=;
        b=0FhrAWmUG73HFfbTND9eI4Et8r+pPYMdGRh/2QmSLxiJK1weQaSgHh2MQ0SAlaQ9pWkKQar6i1Ybt4d5dDY0RQLIyQFEFiWbFdGhzOZ44pU5Zv+rxz1xlO/gtwr451RTdazy0S/VNeru83IAlNkVkpUR8scIlDhxlbLBLO9ASa4=;
Received: from [10.161.64.52] (port=51900 helo=smtp44.i.mail.ru)
        by fallback9.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1emIZs-0002W4-GP
        for git@vger.kernel.org; Thu, 15 Feb 2018 15:23:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=OxHjgEWSw2/GC/wai7MQFhnIV4qYN/XcK9hvmc5/Em4=;
        b=0FhrAWmUG73HFfbTND9eI4Et8r+pPYMdGRh/2QmSLxiJK1weQaSgHh2MQ0SAlaQ9pWkKQar6i1Ybt4d5dDY0RQLIyQFEFiWbFdGhzOZ44pU5Zv+rxz1xlO/gtwr451RTdazy0S/VNeru83IAlNkVkpUR8scIlDhxlbLBLO9ASa4=;
Received: by smtp44.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1emIZp-00082H-W2; Thu, 15 Feb 2018 15:23:50 +0300
Date:   Thu, 15 Feb 2018 15:23:44 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Jan Nguyen <jan@virtii.com>
Cc:     git@vger.kernel.org
Subject: Re: Uninstall Git
Message-ID: <20180215122344.d4ntxdtfnurxvmet@tigra>
References: <77629120-680A-47AA-BBD0-AAC67E670095@virtii.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77629120-680A-47AA-BBD0-AAC67E670095@virtii.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A544793E8192E5C908ED54F01628C8F7755EC505859402C15D725E5C173C3A84C370F6C3CD31CD5570DE2DA77B2BF57A6BB344165809136645C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4DD5A2BFE7891F1AB8CBBF7B646D480CB6F46F3E7DDF2A4D4FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A504200666D7E2BB3105DB20E00375623E97EC0D2FCC39F5ED462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005265567A7F4CD7519DF5C9BFC584A3CB3C38E0410166134D1E978AD604E751615FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 01:01:14PM +0100, Jan Nguyen wrote:

> I would like to ask how can I uninstall Git?

Please follow the answers given to this question at
https://apple.stackexchange.com/search?q=%5Bgit%5D+uninstall

