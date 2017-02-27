Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0451F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 15:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbdB0PEe (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 10:04:34 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:33954 "EHLO
        mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdB0PEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 10:04:32 -0500
X-Greylist: delayed 1166 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Feb 2017 10:04:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=trippelsdorf.de; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=nh48G9j7NHBibi7r5xixLII2JnCJ
        YWAIeoil1x7904w=; b=S5M6m8ZtqBRQa0dAqBNqQGXffrWJn+7gK89KfwywAEth
        FJ3olqKcOlzShMhqsX0uBPFKoTL6xyWOw58mJwtY1k74Q2PdYQQyLn9H3Ne+CRc3
        VTxwtmz8sjxeJEO6/J1zSxkt6XkMnjmNoh7yToYAaSPdEcVhO+w6PfOFd0zkXx4=
Received: (qmail 21877 invoked from network); 27 Feb 2017 15:37:48 +0100
Received: from ip5b405f78.dynamic.kabel-deutschland.de (HELO x4) (ud10?360p3@91.64.95.120)
  by mail.ud10.udmedia.de with ESMTPSA (ECDHE-RSA-AES256-SHA encrypted, authenticated); 27 Feb 2017 15:37:48 +0100
Date:   Mon, 27 Feb 2017 15:37:47 +0100
From:   Markus Trippelsdorf <markus@trippelsdorf.de>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Cooper <git@lakedaemon.net>,
        ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Joey Hess <id@joeyh.name>
Subject: Re: Why BLAKE2?
Message-ID: <20170227143747.GB297@x4>
References: <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
 <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
 <20170226001607.GH11350@io.lakedaemon.net>
 <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
 <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
 <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
 <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
 <22708.8913.864049.452252@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22708.8913.864049.452252@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017.02.27 at 13:00 +0000, Ian Jackson wrote:
> 
> For brevity I will write `SHA' for hashing with SHA-1, using current
> unqualified object names, and `BLAKE' for hasing with BLAKE2b, using
> H<hex> object names.

Why do you choose BLAKE2? SHA-2 is generally considered still fine and
would be the obvious choice. And if you want to be adventurous then
SHA-3 (Keccak) would be the next logical candidate.

-- 
Markus
