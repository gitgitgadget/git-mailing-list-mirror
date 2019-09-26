Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDC71F463
	for <e@80x24.org>; Thu, 26 Sep 2019 19:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfIZTkV (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 15:40:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:60509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfIZTkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 15:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569526813;
        bh=Msr4pZ+2Y2wNAsfpzDZjhjKMpcNhChn7Yrun8iGrPJY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Sosc+lkaPvf0IK+xRe9Mt0EiPLYlVp6bBflIy1cmEynHwuc4+GZz/YjAEgc7AtuDX
         EAsRW+PNmxpWfIgKCnN18pallGCdZdbX08iuESu06xZRdnQUjCGt514pe4gaAG0Efx
         NmNkvKrlmL9JT65hpTi04xvZRKnIaBUztr1MnZPA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1i0Z2a45Fw-00vS7r; Thu, 26
 Sep 2019 21:40:13 +0200
Date:   Thu, 26 Sep 2019 21:39:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190926132852.GF2637@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1909262138450.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com> <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com> <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev> <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet> <20190923165828.GA27068@szeder.dev> <nycvar.QRO.7.76.6.1909261257160.15067@tvgsbejvaqbjf.bet> <20190926132852.GF2637@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-888021810-1569526814=:15067"
X-Provags-ID: V03:K1:Txwleoo1WP6OFdhgCKhJ16hvi1EEKfe0q8UqQmmcdUB6JfmN6Ea
 A7Z/RARBDm4eP8m8G0r6p7s14dAqvJoPNkS/tTyKjiRaCXC62mnVEN+47ik882CXpLlJm7K
 jeVFX0CJOBqlZdVsH/C6GEWhavYkZQrekpvykmfHJyRgteOQTQAcW8zuIW32lhbeUwQYrlH
 uG/QUZlN8KSPxl3a3s3dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xmKW1jkRp7I=:2WI5QrP1YiGFP+ATx/EpWi
 NlLuNRELBb3kxjwb/KHudq0YL0ZsyBCG7018lKWTvB4t817T3v4ae1Lw/FkGbEO6QjnwdZSPQ
 ILswY7tb9/F9J+hbOXnOzNpP5sjBIZZu4Rv6dcnnWxr7TuNz0S7M5bNu5Z4MN0XoKpr+bLeSe
 0cXR7J1PK/4zFjih+WxJ0KXAr5kMoG3rp3gRKr+wO0kEZtDiHIIABXDhxpkH0oz4VoJz638oC
 52ITIDuOAlqojMHlaGFVuPbXKKPYR2FgdMON1QcykQcz8A54yGYu25kLAuQAVko5sze1LmwUq
 yeOgjchQzvN9AHHcxerRPaBu0rQEQWmWtKkVAQvBk1UNB1qitzg3d6g6vqcVuYjqnwDI1QLpy
 XZEIilXkgtCJR/tKKlfImP1AVbdETB+17g9rd3iP4FDoSm/pgfFTPG5OfM6a+cBjI4EE4Gdt5
 86pIdlXHZ3lUxkPVmfity/9mEKu/0I4OdqXbEYTz8YN73NAqY4DH5iLjVHwqNrBDsNfBFcFFc
 L3pMSepmKZhdPfYcDHFi96VFsAUgRYV1UlzB3uWNL2c0JA3MBkK/MSBu200Or6rlYSKEd94ZD
 v4VNgzspEJ+mBupDZhe9fZmUSFhouRzZDDijph5H0vYjrmBez9sJ5HL/C/Yw/sq8TJHXFSldo
 5b0zneh/awPs3pMydSnnyZnKBRvzFaS6kpybdvKkmzz1p0FLVV7bNwd5m2pFyTJ+3yrouEJBH
 ZaPcwz3kvVAoZM1Z14Z2rbvA+dJKR9vfGYkOHpwWYN7Wbk1IYSMKqJ5IhGSBYFuCtfaRwFUfW
 l0dvkAOfYsMCX4UO8Jy58t2sDUEuYTvlc7hmAPipaUMo8hCYMBTyj0d0gfWZxarhjjkDtoY/6
 y83/w0ebS/Tcul9bKst/U4Nn6t9vZWcoepBgLwzAqjL4VTvN5yuB7HZGFPS4+lXI+rpGwpcWx
 nkvAJkhuizTyaW0TIFNUnIpaT5FkTw6b7f7SfBaloQb4hVqDtynHwjnhsY2mIMMMh0fwrBCP5
 sGajNXsn9XBkH0mOr1NYLmbkqN/3skv+6+Lokbr5YdiEvl6CHOHOcLFfFhB3jSheQrrDVe+RS
 Owi5wWlZPCPgB0ZriJZHRCjRGz0lIY64+jUja5Dj/Hgfq2epcucB00eRdGbykI+uBma5SEvLr
 M5727OR+a9DETjcP/+G9rwjns6RFZYFMCAss6faa/Xjj73jXf1oLe7xYfWCZTXhWXh9a4l3fg
 yudL3u9KU9JWYzkToZS8Hd6oirVl3/4LQI+I2n0rcv55r0HsFhDgiaTx9ELo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-888021810-1569526814=:15067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 26 Sep 2019, SZEDER G=C3=A1bor wrote:

> On Thu, Sep 26, 2019 at 01:04:48PM +0200, Johannes Schindelin wrote:
> > > > > > Also, things like the code tracing via `-x` (which relies on B=
ash
> > > > > > functionality in order to work properly,
> > > > >
> > > > > Not really.
> > > >
> > > > To work properly. What I meant was the trick we need to play with
> > > > `BASH_XTRACEFD`.
> > >
> > > I'm still unsure what BASH_XTRACEFD trick you mean.  AFAICT we don't
> > > play any tricks with it to make '-x' work properly, and indeed '-x'
> > > tracing works properly even without BASH_XTRACEFD (and to achive tha=
t
> > > we did have to play some tricks, but not any with BASH_XTRACEFD;
> > > perhaps these tricks are what you meant?).
> >
> > It works okay some of the time.
>
> As far as I can tell it works all the time.

I must be misinterpreting this part of `t/test-lib.sh`, then:

=2D- snipsnap --
if test -n "$trace" && test -n "$test_untraceable"
then
	# '-x' tracing requested, but this test script can't be reliably
	# traced, unless it is run with a Bash version supporting
	# BASH_XTRACEFD (introduced in Bash v4.1).
	#
	# Perform this version check _after_ the test script was
	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
	# '--verbose-log', so the right shell is checked and the
	# warning is issued only once.
	if test -n "$BASH_VERSION" && eval '
	     test ${BASH_VERSINFO[0]} -gt 4 || {
	       test ${BASH_VERSINFO[0]} -eq 4 &&
	       test ${BASH_VERSINFO[1]} -ge 1
	     }
	   '
	then
		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
	else
		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEF=
D"
		trace=3D
	fi
fi

--8323328-888021810-1569526814=:15067--
