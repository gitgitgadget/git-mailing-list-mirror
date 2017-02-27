Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6124E1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 16:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbdB0Qbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 11:31:50 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:41499 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdB0Qbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 11:31:49 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1ciNRe-0006Gf-TL; Mon, 27 Feb 2017 15:42:39 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22708.18670.790503.11385@chiark.greenend.org.uk>
Date:   Mon, 27 Feb 2017 15:42:38 +0000
To:     Markus Trippelsdorf <markus@trippelsdorf.de>
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
Newsgroups: chiark.mail.linux-rutgers.git
In-Reply-To: <20170227143747.GB297@x4>
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
        <20170227143747.GB297@x4>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Markus Trippelsdorf writes ("Re: Why BLAKE2?"):
> On 2017.02.27 at 13:00 +0000, Ian Jackson wrote:
> > For brevity I will write `SHA' for hashing with SHA-1, using current
> > unqualified object names, and `BLAKE' for hasing with BLAKE2b, using
> > H<hex> object names.
> 
> Why do you choose BLAKE2? SHA-2 is generally considered still fine and
> would be the obvious choice. And if you want to be adventurous then
> SHA-3 (Keccak) would be the next logical candidate.

I don't have a strong opinion.  Keccak would be fine too.
We should probably avoid SHA-2.

The main point of my posting was not to argue in favour of a
particular hash function :-).

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
