Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81DCD20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeLKRQC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 12:16:02 -0500
Received: from smtp55.i.mail.ru ([217.69.128.35]:54050 "EHLO smtp55.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbeLKRQB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 12:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=yllAPOsB72EFMz6LZet9nqgI8edquSTnkunR9klqiFg=;
        b=dGokjykzb4UiI/JQmEQ4zWkNpEu4bUnNfcpEGGkxcJDQLjcGncT6sjk/Ul/C8ubxi3mN6GjTp/UixB51LFLmb0oE4cQnzPxFgjhHTraAHT284eope6EkhcDlm95nMOEkvwZ8eCSNTyAxDfqubVXGeLAvFP8R0zOqmT/QwcZmeXg=;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gWldW-0000OW-A5; Tue, 11 Dec 2018 20:15:58 +0300
Date:   Tue, 11 Dec 2018 20:15:54 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Jon Forrest <nobozo@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Announcing Pro Git Second Edition Reedited
Message-ID: <20181211171553.4mnd66ngqvcxb6me@tigra>
References: <pujni2$ulb$1@blaine.gmane.org>
 <20181211105007.GD7233@sigill.intra.peff.net>
 <a1941151-9453-5830-7175-7c8e27425274@gmail.com>
 <CACBZZX6g7TaxNHN=3ApV4wV91ZuVV8eoemMurS=WMt4mG8Q67g@mail.gmail.com>
 <55838db9-4f08-b77e-bc95-5c7dce4024d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55838db9-4f08-b77e-bc95-5c7dce4024d2@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp55.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-77F55803: 6115F4D8777AF1675A78504BD2AC29413C8910AE2AA147489C673B8E617B31DDC94C8D7BC741240678C11C417928FB29
X-7FA49CB5: 0D63561A33F958A5D21C5FCF97C7752B7E7B6C21FFD97010BE1E183F2450786E8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A5DF9383870C0FED3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE767C209D01CC1E34BCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7DDD912DD0A2BDB897E8BC5C5C331EA7375ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57D4B828FA1BC0F1ACBD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA46DB829AED29F5452ECF2CAC61DB66281CA523AD9247EC42BFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 09:00:31AM -0800, Jon Forrest wrote:

> > As someone who's read neither your edit or the original edition, but I
> > did read your version of the intro, it would be very helpful to me /
> > others if there was some diff between the two so we could make up our
> > own mind about which one to read, and to get an idea of what sorts of
> > wording changes etc. these are.
> 
> That would indeed be nice. The best I can do is to suggest that if
> you're satisfied with the regular Pro Git then my version won't
> help you. On the other hand, if you find regular Pro Git puzzling,
> especially in the early chapters, I suggest giving my version a try.
> 
> Since I'm giving away my version, you have nothing to loose except
> perhaps a little time. If I'm right, and my version is clearer, then
> you could benefit from it.
> 
> (You're a git expert so I doubt you need my version).

I think an uspoken issue here is that while you're indeed free to "fork"
this book and maintain your fork, having two books with almost identical
contents may not be the best option as it simply may be outright
confusing for those at whom your fork is actually targeted.

That's just my opinion, or — better — feeling I gathered from the
discussion, but to me these friendly nudges to maybe consider
reevaluating your work for inclusion into the original's book proper
look exactly as hints at that having such a fork may not be the best
of all options.

Another problem with the fork is its visibility.
The go-to Git website links to the original work, and I assure you
novice users do not casually read this list — let alone search through
its archives for the mentions of an alternative book's version.

