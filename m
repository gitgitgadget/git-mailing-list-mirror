Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6348F20899
	for <e@80x24.org>; Mon,  7 Aug 2017 08:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbdHGIVU (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 04:21:20 -0400
Received: from fallback11.m.smailru.net ([94.100.179.26]:54676 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751442AbdHGIVT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 04:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=qrN6HgOuulOrcRL2UE8sG6uhE/YDqcxQrFDflFRyKqk=;
        b=cpOJxMCLWTUkYacSRxZ6ESn82UKIpcREfyDlmAGVqQF5U4ZOO5jt+XUD3lP7rTBkss+e83Am5nNZu1X4n54k4gS67zjiDRvcS+4hnNXOxo03DVg7XLQV4WPC01Z3t8Vmqyu2KI8W7lbcjGIY1H8YvScRqfNaIlcegoAmuQLNAJc=;
Received: from [10.161.64.43] (port=58198 helo=smtp35.i.mail.ru)
        by fallback11.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1dedHm-0005FY-Lj
        for git@vger.kernel.org; Mon, 07 Aug 2017 11:21:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=qrN6HgOuulOrcRL2UE8sG6uhE/YDqcxQrFDflFRyKqk=;
        b=cpOJxMCLWTUkYacSRxZ6ESn82UKIpcREfyDlmAGVqQF5U4ZOO5jt+XUD3lP7rTBkss+e83Am5nNZu1X4n54k4gS67zjiDRvcS+4hnNXOxo03DVg7XLQV4WPC01Z3t8Vmqyu2KI8W7lbcjGIY1H8YvScRqfNaIlcegoAmuQLNAJc=;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1dedHk-0000iN-4h; Mon, 07 Aug 2017 11:21:12 +0300
Date:   Mon, 7 Aug 2017 11:21:05 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.0
Message-ID: <20170807082105.fwbv7d7hotsqeddx@tigra>
References: <20170805230001.3232-1-johannes.schindelin@gmx.de>
 <978038E7-74E8-4F9F-A3B9-0BAD82C80FFE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978038E7-74E8-4F9F-A3B9-0BAD82C80FFE@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-7FA49CB5: 0D63561A33F958A52C904464C66A5B7E2FF93FAEF9E69F60625722D541A4D6C1725E5C173C3A84C363D77626233CE5AB732AC0210F880A15B17145F0B7815491C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F9A3D58A9A349F5073B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA412AE7A4705EE9EA8EFFBF4142A25EA4AC87DFF528253291DFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A530E76A4F713727B93E8471B670D13F1BFA0CC13645DFA404462275124DF8B9C975FAC89DD1A0FDCBE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C90059EC859477DBBED74CFAFA9B35919B18CAEAD2E69F8F4D1217942E65D3B0E2994FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 06, 2017 at 01:16:46PM +0200, Lars Schneider wrote:

[...]
> >  * It is now possible to switch between Secure Channel and OpenSSL for
> >    Git's HTTPS transport by setting the http.sslBackend config
> >    variable to "openssl" or "schannel"; This is now also the method
> >    used by the installer (rather than copying libcurl-4.dll files
> >    around).
> 
> Does anyone have a pros/cons list for this option? AFAIK OpenSSL is still
> the default in the GfW installer and I wonder why. My gut feeling would be to 
> go with the SSL implementation shipped with the OS. However, I don't have enough 
> knowledge of either implementation to make an assessment.

One fact which immediately comes to mind is that both frameworks use
different sets of certificates (schannel uses the system's one, and
OpenSSL uses what gets shipped with it).  Another fact is that they
might have different sets or protocols implemented and/or enabled by
default.  Hence switching schannel on for people who used OpenSSL might
break things for them.

