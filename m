Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF821F462
	for <e@80x24.org>; Thu, 25 Jul 2019 11:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404376AbfGYL6l (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 07:58:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:58883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404362AbfGYL6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 07:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564055917;
        bh=sCG1SaeCYiPaA5VUvFzzx/40gOqCZVozyzKs9aMxpJY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BN27qrpnqwMqhOKQ0AWsdwathOwE/ATc3e1Q1eEzNtSfdJfIp5cuaEq9DZ60nMFPU
         5cJat0NDFWgZ5ETK+FNXRTtHZ+6MPU0C8K5zPuFTFUxxZDx1kRA1FEYbirju50iH9s
         R3jQP3Urxu1GMDGrLCITObZs0PEl+p7S8Kld54tI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNq4h-1hkGjm0RFD-007XMq; Thu, 25
 Jul 2019 13:58:37 +0200
Date:   Thu, 25 Jul 2019 13:58:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
cc:     git@vger.kernel.org
Subject: Re: Antw: Re: blank lines in pre-created merge message
In-Reply-To: <5D39812C020000A10003265F@gwsmtp.uni-regensburg.de>
Message-ID: <nycvar.QRO.7.76.6.1907251355500.21907@tvgsbejvaqbjf.bet>
References: <5D382AC1020000A100032608@gwsmtp.uni-regensburg.de> <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet> <5D39812C020000A10003265F@gwsmtp.uni-regensburg.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kNNSb/fYBBmKsBHdnuWbLjowWonA0t5yCPck6jEti/czej5yL0H
 ODjAkEUiZRtj48JS+2e0RwhtZPvOcyL9rQg9DMmME2ZVqsRdkDZ6HvxmWyWQr0BMq8n96iN
 xE6GRSz2JjfQOl/TEY8i+1SzT2FU1ZBwY2RNaYP+dEknPkdJ3QPCi1DTPioTozfeUQCKBTv
 WP1l715kGifLcVkCby41Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B8WDFpLxdPk=:RvBZsaXQxPOr76Mx3fEezA
 o1BXdgI/BV5v95DcnaoKG2hf0jZPgjCzVmIaFewz21lxPrZHh4rYp7811GvAidXpkDdweBS5N
 ykOfhXz8XRf66bggqs8CcJRhuFMTVS62M8IeudNzajXI07DZIjesWL6QHT/Y7HnzxiVXwwurv
 RmbORohD36/qOWEw2Tv3qV2iqqh2PmOJ7t5pcjTD1SfzTU6goWgqFVnaTXWau1hPg5mzHrpgG
 Y2jvzJdeGOOL534k4IYGfABdbYcHwkr+a7CgQxQW0H3dN2qVZWcZkB48B6jfOwPFtx6lN+/yN
 0hHe1bFONSi7migDk+cefHckQDTJAhaFUPkf7ZBjyLSFzDDld32o0PzK1k7J1XVU1QAYE7RvI
 /lfSHIOykgKOUcI3xw6iHbU00KS7pD4kKWCaNo1nwIcWxvWPrjHl/mW/jXo3GB+pESA3YbHjk
 7HfShTMFFepZtmPMWTXuI3+Xef5Su1ufVSTPOUjIuoN/xTwBpRQJgo6Sxbo70Ej9jzqrIzVIA
 S2Lax2paxRASzQl5MEa/o4JFxjan81Pp8sp/8lznUgaQaoMhdoqbZK3WTgvY++Yvzj9btSbWX
 hCVYhXepBEmXK2pbambNYF1OpIrAvOByUu0UXU8pqrfq76sG/AyEZWPGXibGFfL4M44mgG54+
 NAoFF/W/lhMoPD1EZ/u8guFRUN9+Nx+TjVhBF4eDDQkHw4O/HC0pK7DXHX4O559YIaokUS1tU
 42s0e6Tddr/j9a5yTW+i89EuuTocC7QkM3rY1606f4w1N48ZNZ/YPUACY31cdElrD6oyqdnX3
 3yVH+tjzM28QwhFxBOPvyMe/WV8dG3csgMLNV4iSTF9s+UOD2NjbkrpduMzZWlu25wFxjZ/P9
 sGI5go0AiSGDm4thoUxMkUjx+0BxonSInmqxRHZIx8yXy/lJdswLfIxr10AGkC1B9JPcRcDDJ
 0pMChG4FKuoZ0MutDp6qe/y+L+ZB60xhGFPheS53w0S81+N0/uCuOcfQNtzJCAqR7k5YVAMj+
 6Z1pAclrXS74AP4kWxRZ7ZiKzjIly/f20k4YPq8RJ3YtgoGJ0Tp3mTDpdzGThacjgYe29TN5C
 GXj8E+45JE2w2LcUiMfbWJPQzc+j10Bg4pk
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich,

On Thu, 25 Jul 2019, Ulrich Windl wrote:

> >>> Johannes Schindelin <Johannes.Schindelin@gmx.de> schrieb am 25.07.20=
19 um
> 12:07
> in Nachricht <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet>:
> >
> > On Wed, 24 Jul 2019, Ulrich Windl wrote:
> >
> >> When using "git merge --no-ff --no-commit ..", the pre-created
> >> merge message always contains two empty lines in between the
> >> comment lines. However if there was a merge conflict (being
> >> resolved) an extra blank line is added after the fiVrst line.
>
> [...]

> Could anybody provide a rough overview how and where these editor
> comments are created?

The best bet would be to call `git grep` with text in that pre-created
merge message, preferably some text that is most likely fixed, i.e. that
does not depend on the current worktree/commit.

If you give me an example of such a merge message, I can provide you
with the appropriate `git grep` call and the code locations to touch.

Ciao,
Johannes
