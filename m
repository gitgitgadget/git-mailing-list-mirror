Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9E21F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 14:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeKYBqP (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 20:46:15 -0500
Received: from fallback22.m.smailru.net ([94.100.176.132]:52630 "EHLO
        fallback22.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeKYBqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 20:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=tJF1ph32hoGU2pmUPHz9EDYRtmIH5r6h5jv8uZiUPoY=;
        b=C3PdD2q0pN3uFkSLdY8FGHoTsO9yavTB4cNaZUjo4TvU1zV/sC42JrqGdaMHwBHpxhq6E3YKvHfr3RCAGA1dxewUPPtJylXnTkmOy3bvMpGr9+i4OYmRMV85//gd8VlfHyqgcvyIvhrhlBb+oncNx4fvdVq4KE8SejSd8IojowE=;
Received: from [10.161.64.54] (port=47050 helo=smtp46.i.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1gQZNI-00042y-Nu
        for git@vger.kernel.org; Sat, 24 Nov 2018 17:57:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=tJF1ph32hoGU2pmUPHz9EDYRtmIH5r6h5jv8uZiUPoY=;
        b=C3PdD2q0pN3uFkSLdY8FGHoTsO9yavTB4cNaZUjo4TvU1zV/sC42JrqGdaMHwBHpxhq6E3YKvHfr3RCAGA1dxewUPPtJylXnTkmOy3bvMpGr9+i4OYmRMV85//gd8VlfHyqgcvyIvhrhlBb+oncNx4fvdVq4KE8SejSd8IojowE=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gQZN8-0007XE-Rx; Sat, 24 Nov 2018 17:57:27 +0300
Date:   Sat, 24 Nov 2018 17:57:24 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     David Mandelberg <david@mandelberg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git overwriting local ignored files?
Message-ID: <20181124145723.ow2h7x374xwwts6m@tigra>
References: <a852c0e9-f278-8e2a-406c-bb6099b2440c@mandelberg.org>
 <xmqqftvr2jfo.fsf@gitster-ct.c.googlers.com>
 <7ac49733-2e62-7d29-36aa-99df4124b54c@mandelberg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac49733-2e62-7d29-36aa-99df4124b54c@mandelberg.org>
User-Agent: NeoMutt/20170306 (1.8.0)
X-77F55803: BBE463BEF7A60BD05A78504BD2AC2941D12ABC1A1C44167900DEE8D7736F36A704483D9ABF89B61B9A3B11CD079DBEB4
X-7FA49CB5: 0D63561A33F958A531F466E3969FFB1D5A1483FB7FDBBE14D512CB89E34C05148941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B8C7ADC89C2F0B2A5A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A5DF9383870C0FED3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE767C209D01CC1E34BCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE76F92BA8B5313264ED6D6856687C9194075ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57C2F2A386D11C4599BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA45940A2970B38AC80FDEA69CAAF6C35854A03695D670F3891FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDC41013E859B0B00E423F663BA4925CF7F97907AE7DFCC813E176C3ED52907920B
X-7FA49CB5: 0D63561A33F958A5DCCF48758561FA853EBC9CC6021822ADF1222E096041C3ED8941B15DA834481FA18204E546F3947C062BEEFFB5F8EA3EF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: A5480F10D64C9005C3FADA55C8765CC3C88DC7E9B03B62BE23F663BA4925CF7FCA1B0AE468EAC1C9FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 24, 2018 at 09:37:06AM -0500, David Mandelberg wrote:

> > > It seems that git is overwriting my local files on merge if they're in
> > > .gitignore.
[...]
> > The .gitignore file is to list "ignored and expendable" class of
> > files; there is no "ignored but precious class" in Git.
> Ok. Would a patch be welcome? I have three ideas for how to implement it,
> and I'm not sure which is better.
[...]

You might want to first investigate this recent thread [1] which AFAIK
was dedicated to exactly this problem.

1. https://public-inbox.org/git/4C6A1C5B.4030304@workspacewhiz.com/

