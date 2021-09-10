Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD84FC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B152B611C9
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhIJPYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhIJPYe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:24:34 -0400
Received: from tilde.club (ipv6two.tilde.club [IPv6:2607:5300:61:c67::196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28FFC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:23:22 -0700 (PDT)
Received: from tilde.club (unknown [185.220.101.229])
        by tilde.club (Postfix) with ESMTPSA id 60A6D2203771E;
        Fri, 10 Sep 2021 15:22:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 60A6D2203771E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1631287400; bh=wfk4n8ovq3IRKMoCFwRcEcyKorLtyGlSooTDDOpXKzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0KfEiz6UG3Z+c5yX0R/VDKPgtMMLcU9SXKA380RxHSPK7x2WODWyprJVPQT54BwH
         bD6WxyikQpNPSUFJOVTpyB1S+iwQPr62LiF5Zgy/2nt67bYqCbyGQmvtqrHfTRIDi5
         krXgxSldYU9+J/tc2+SPiFoKwXylbZ/TMYMeqSSQ=
Date:   Fri, 10 Sep 2021 15:22:47 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Fangyi Zhou <me@fangyi.io>
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        CB Bailey <cbailey32@bloomberg.net>,
        Christopher =?iso-8859-1?Q?D=EDaz?= Riveros 
        <christopher.diaz.riv@gmail.com>,
        Christopher =?iso-8859-1?Q?D=EDaz?= Riveros 
        <chrisadr@gentoo.org>, Ed Maste <emaste@freebsd.org>,
        =?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
        Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kazuhiro Kato <kato-k@ksysllc.co.jp>,
        Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Slavica Djukic <slavicadj.ip2018@gmail.com>
Subject: Re: [PATCH] .mailmap: Update mailmap
Message-ID: <YTt4RymWg+TOEmUf@tilde.club>
References: <20210910130236.40101-1-me@fangyi.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910130236.40101-1-me@fangyi.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-09-10 14:02:36+0100, Fangyi Zhou wrote:
> Similar to a35b13fce0 (Update .mailmap, 2018-11-09).
> 
> This patch makes the output of `git shortlog -nse v2.10.0..master`
> duplicate-free by taking/guessing the current and preferred
> addresses for authors that appear with more than one address.

The line for Jessica Clarke should probably just be

Jessica Clarke <jrtc27@jrtc27.com>

That works the same and doesn't put a reference to an old name.
