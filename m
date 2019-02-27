Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FA0A20248
	for <e@80x24.org>; Wed, 27 Feb 2019 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfB0PCa (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 10:02:30 -0500
Received: from fallback16.mail.ru ([94.100.177.128]:34268 "EHLO
        fallback16.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfB0PC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 10:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=3H95XAbEwKHMOn1/8a2mb7I19wV1mWOyv1firHveq5I=;
        b=DA5t4v+QyyECtFgXPlyun54r0h8o4uQfbLmFKaEP2uDJvvOpRtdHagvc3amdjieLzoP93MMqYamum09iSlPHfUmWYGH1aao6iVA6z4ulgATMlNCJh5nkH2SYUNijmY0TDg27pUQWz9bSD6be/K02qSH2qHHjuq8j392JM5hXJdU=;
Received: from [10.161.22.24] (port=42126 helo=smtp54.i.mail.ru)
        by fallback16.i with esmtp (envelope-from <kostix@bswap.ru>)
        id 1gz0j5-0004Y4-6j
        for git@vger.kernel.org; Wed, 27 Feb 2019 18:02:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=3H95XAbEwKHMOn1/8a2mb7I19wV1mWOyv1firHveq5I=;
        b=DA5t4v+QyyECtFgXPlyun54r0h8o4uQfbLmFKaEP2uDJvvOpRtdHagvc3amdjieLzoP93MMqYamum09iSlPHfUmWYGH1aao6iVA6z4ulgATMlNCJh5nkH2SYUNijmY0TDg27pUQWz9bSD6be/K02qSH2qHHjuq8j392JM5hXJdU=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gz0j3-0002Ic-48; Wed, 27 Feb 2019 18:02:25 +0300
Date:   Wed, 27 Feb 2019 18:02:23 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Adrian Wright <adrian@wright2.me.uk>
Cc:     git@vger.kernel.org
Subject: Re: git case sensitivity issue
Message-ID: <20190227150223.jfkxp4bvvdcmapnx@tigra>
References: <CA+LT4LV4WBJtgDOene7i9UQmmkB20L0Zrr=XDzs4j197+uC1jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+LT4LV4WBJtgDOene7i9UQmmkB20L0Zrr=XDzs4j197+uC1jw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-77F55803: 0014004E1F3277295A78504BD2AC29410C907E9E4A83F9FEFD601F1D047DB74A6A9DA87CAE0D12D58EC4EBDECB1953FC
X-7FA49CB5: 0D63561A33F958A5BBBF985347AE4F72538360832FD2D75F36A2807E4187C3608941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249668B94F0A65C3A0C3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE7542AF255F21831B5CD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7A839FE83A78F066FC03837ACF90F27B775ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57C2F2A386D11C4599BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA44341B7E549E56438A4C309EE7AFE5A7F59B8C681F8837A39FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-77F55803: 669901E4625912A97F9F52485CB584D7271FD7DF62800FDC4390F6D9A191B390A3C28126B2EBEC23135352F4C85BF2EF09B5EA7FC11112D7
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 12:38:04PM +0000, Adrian Wright wrote:

> I am a  git-for-windows user and have run into issues with casing on
> Windows OS.
> 
> I filed a GitHub issue directly on the git-for-windows repo:
> 
> The issue can be found on URL:
> https://github.com/git-for-windows/git/issues/2066
> 
> See the GitHub link above for more details on the bug.
> 
> According to the maintainer of git-for-windows this is a bug and the
> bug is with git not git-for-windows.
> 
> Are you aware of this bug and are there any plans to fix it?

Yes.

Please use the <https://public-inbox.org/git/> web interface to search
through the archives of this list.

For a start, try <https://public-inbox.org/git/?q=%22case+sensitive%22>

