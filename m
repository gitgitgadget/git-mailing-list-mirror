Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06791F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 14:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbeKVBTm (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 20:19:42 -0500
Received: from fallback11.mail.ru ([94.100.179.26]:34250 "EHLO
        fallback11.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeKVBTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 20:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PaqMv1tLCeCnFTSDWEtVRD+pXEN6+qYCw70R4AcbkEo=;
        b=u0pgMt7gBa4vkYNtlOP+ghC7bAaB3T2IXWPNq/4YkKyBsFLlt4PEYRchHNc1zE0+9CWwOUrOHYo5MgLTktRNPby8l9uKTpqD2n0Pb0iLzaFIszn+fppBB5xeGjEB1B51XawwY6Cc3xctUoc+Kb+PEG+xz5H3c8pHxK9Kk4bqqr8=;
Received: from [10.161.64.54] (port=36382 helo=smtp46.i.mail.ru)
        by fallback11.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1gPTkP-0006FY-7W
        for git@vger.kernel.org; Wed, 21 Nov 2018 17:44:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PaqMv1tLCeCnFTSDWEtVRD+pXEN6+qYCw70R4AcbkEo=;
        b=u0pgMt7gBa4vkYNtlOP+ghC7bAaB3T2IXWPNq/4YkKyBsFLlt4PEYRchHNc1zE0+9CWwOUrOHYo5MgLTktRNPby8l9uKTpqD2n0Pb0iLzaFIszn+fppBB5xeGjEB1B51XawwY6Cc3xctUoc+Kb+PEG+xz5H3c8pHxK9Kk4bqqr8=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gPTkN-0004g4-7T; Wed, 21 Nov 2018 17:44:55 +0300
Date:   Wed, 21 Nov 2018 17:44:53 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Jamie Jackson <jamiejaxon@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: "show-ignore" problem after svn-git clone
Message-ID: <20181121144453.gnqcn5ugvd2yo5jl@tigra>
References: <CA+onWPcgHMCffjfNO3wxMwVD2bOJzWmwtYtrj9QakDUEA=OXqQ@mail.gmail.com>
 <CA+onWPe9hmr36xvc9F58KwW5fyby-wn6F2hiJy9ce__sA1mSjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+onWPe9hmr36xvc9F58KwW5fyby-wn6F2hiJy9ce__sA1mSjw@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-77F55803: 6115F4D8777AF1675A78504BD2AC29413573A8BEB27EF9383B99E453C24DDD6870A6AC2F015DB629EDC299E5F7C9B029
X-7FA49CB5: 0D63561A33F958A51485147244D484CC435C19D705B5927B18164556216D159D8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249D827CA74CCEABFF33AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE767C209D01CC1E34BCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7A8FB005AC2363C8F7D31F1A02F537C5175ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57C2F2A386D11C4599BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4DB3333A16D44E7F349C1F0B35A894A7D17B891CEFFF4CBBCFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDC1F9F11B61326A7A66600BFA41A41411C8986FF1E855217205293FC9A8AF64014
X-7FA49CB5: 0D63561A33F958A5DA5F6003AFC4ADDBE533D4B36CFBA1A0F2FCD84292B2F1198941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: A5480F10D64C9005C3FADA55C8765CC3D19AAE699EDD583A6600BFA41A41411C46A0A24852759D85FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 08:37:03AM -0500, Jamie Jackson wrote:

> I'm brand new to svn-git and I'm having a problem right out of the
> gate. I suspect I need a different ID, but I have no clue how to get
> it.
> 
> Here's the failed attempt:
> https://gist.github.com/jamiejackson/57e90302802f4990b36dfe28c3c71d13

Please post the content supposedly available at that link in your mail
message, inline.  Otherwise it's impossibly to sensibly comment on it.

