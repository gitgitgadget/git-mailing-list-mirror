Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7BA920798
	for <e@80x24.org>; Sat, 14 Jan 2017 21:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdANV5x (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 16:57:53 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53372 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751993AbdANV5v (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jan 2017 16:57:51 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 05967280AC;
        Sat, 14 Jan 2017 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1484431069;
        bh=twiV5zWrC4GwXLvlayKGcCV4pD24TFYtNKjq2FcqCbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5jJgjQPrfGdTuWvN9l2X0dJyzCOY0s9K1GLAAgtCbt6BiiOdSsUyHmXDWZ1Ip7zi
         ZeADjSS9V+e52HYHfhNv6MJwXIRaqYYrHsRbj6+UOXV2EKWF9v8/9Hhd7D55TkgsSO
         qErp8OW2ANZ6OAXD61KwWn/8WMujIP9v6VoYi/TuqsIx2BR5MeKVEGaNOY/82LzRUQ
         1r7TbQRvMVXKMXD76IKA9cj07HrQFJyHTr00ip3WnwAKN0OK1Ym+dA8FgRvQe2J2di
         7Q5Fht9zyEiPU0wb8ecYFP9TAroLrx+SxuI6xV3lrlVkK1nUcsjkaCxSkqdJaY1adm
         g2lo6tT7VzDnngQ4eHS+g8jR0cO0PqeNjpWUmMOlsublVdw3CdA7vWHKYAcQE8r0jd
         l3bwT8wiu/dRO98CgktgXXjxSaBfXfGJPJzhC/gC9+XjXGKIqXJj/4+apypN8EwJVm
         2+5QNOpp/yVnSYpVp6mt9TbapT/UYVc6lDb11ALYEI8aTEB++Cf
Date:   Sat, 14 Jan 2017 21:57:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Message-ID: <20170114215743.5igbjup6qpsh3jfg@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
References: <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
 <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
 <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
 <20170113024842.GA20572@starla>
 <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
 <20170113185246.GA17441@starla>
 <20170114075408.hyidkb4rzxzmm2je@sigill.intra.peff.net>
 <20170114103134.GA586@untitled>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mcb4s5eo2fr5mzkz"
Content-Disposition: inline
In-Reply-To: <20170114103134.GA586@untitled>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


