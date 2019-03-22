Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E0F20248
	for <e@80x24.org>; Fri, 22 Mar 2019 08:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfCVIuY (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 04:50:24 -0400
Received: from fallback15.mail.ru ([94.100.179.50]:49236 "EHLO
        fallback15.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfCVIuY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 04:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=M3QCiHrMMMlqZaWoMpJDFIEPlMwjP+imfMmPFmOaFc4=;
        b=F0rrN+mVkqqn0Z3YSeAcNzUhtrCfaAX+ShLNOGph5w3mKUrydyd+9cg7yF5aT2YvmrtRgNv32akGFC/ejhJwasTHxmldSmXKTlvOdpWoUxBwPowMgaxz/bo2czn7HY7Kz2yJLWKO0AGGm912KTUuUCWHbEsOYD4VIuy3NiHvaSU=;
Received: from [10.161.25.39] (port=52884 helo=smtp62.i.mail.ru)
        by fallback15.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1h7Fsb-0003mh-LG
        for git@vger.kernel.org; Fri, 22 Mar 2019 11:50:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=M3QCiHrMMMlqZaWoMpJDFIEPlMwjP+imfMmPFmOaFc4=;
        b=F0rrN+mVkqqn0Z3YSeAcNzUhtrCfaAX+ShLNOGph5w3mKUrydyd+9cg7yF5aT2YvmrtRgNv32akGFC/ejhJwasTHxmldSmXKTlvOdpWoUxBwPowMgaxz/bo2czn7HY7Kz2yJLWKO0AGGm912KTUuUCWHbEsOYD4VIuy3NiHvaSU=;
Received: by smtp62.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1h7FsZ-0002MU-O9; Fri, 22 Mar 2019 11:50:20 +0300
Date:   Fri, 22 Mar 2019 11:50:18 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Aaryan Kapur <aaryankapur1309@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Gsoc
Message-ID: <20190322085017.7nwf467hflru3xkt@tigra>
References: <CAA7E357-816D-4BEA-8806-4CB180FF0BD1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA7E357-816D-4BEA-8806-4CB180FF0BD1@gmail.com>
User-Agent: NeoMutt/20180716
X-77F55803: 257C4F86AB09C89C5A78504BD2AC2941988784FC6C4AE31F20DC7F1842A8DAC980B4341496B83E0B2A3D3639DF5E61EA0187F956BAE4C43B
X-7FA49CB5: 0D63561A33F958A597E58428FA4D42A7A1DF21D309BA3119BA8B8969A24895D48941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249668B94F0A65C3A0C3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE7542AF255F21831B5CD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7612FFF00A53DDDD5A6832837CA3F089175ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57C2F2A386D11C4599BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA458BF42E287CB807B80B4341496B83E0B064B8FEF34F63F30FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDCE72616FAF7B0FC7ACA7C47246E9035C5354E5497E0BCD1D5609FC6C4D9FE1DAA
X-7FA49CB5: 0D63561A33F958A530C0848F34B1F6711D36C3A3E8BF7BDBF2C8F5A7F241E5628941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: A5480F10D64C9005DCCD83CE6875A18E1F973059ED517BF7CA7C47246E9035C58D2F0B78A5E2C0F9FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 03:14:37AM +0530, Aaryan Kapur wrote:

> Hey, I would like to work with your organisation for the upcoming
> Google summer of code program , please guide me on how to go ahead

Please start from [1] which links to [2].

For future reference, this list is archived at [3], so the first thing
to do before asking a question is to search there and study what was
already posted on the topic.

Cheers.

 1. https://public-inbox.org/git/CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com/
 2. https://git.github.io/SoC-2019-Microprojects/
 3. https://public-inbox.org/git/

