Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8401F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfA3TPl (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:15:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:43531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfA3TPl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:15:41 -0500
Received: from MININT-6BKU6QN ([62.119.166.9]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiTm8-1hRHsn3GpA-00chv1; Wed, 30
 Jan 2019 20:15:26 +0100
Date:   Wed, 30 Jan 2019 20:15:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 09/13] Use symbolic links rather than hard
 links for files in libexec
In-Reply-To: <230CA858-D709-4142-9563-20A4887F2ED8@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901302010210.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-10-jeremyhu@apple.com> <20190130095006.GC24387@genre.crustytoothpaste.net> <230CA858-D709-4142-9563-20A4887F2ED8@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1105006177-1548875725=:41"
X-Provags-ID: V03:K1:Oc7rDJfXWWr137vnSV/U/RD6lpV5sVm47MnFe8Q0fWIGx9trED7
 tq7BA4pjTm7uHD+Zb227DuCEM5p3BrnrUO4OX6uU3lrnWd2POSlDcP7pBxgX8f0WBd03cyd
 JO8HykYfZ4n30sSzGbz2GAs0zr3nS1bcwYASv1sPt1HCwXToSTxHikTLM0pHtV0HxlPCKr/
 BUnOgzhXJqvbx69UQEKVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xU7E8sxUNEs=:QOkWHrfhjeZce/Y6Elli7+
 mi7L/MATiSKaMgjoOr6zwHtnZUVPw28vCXtB2h0QXki45Sv3bCceALNMUskiDnvFn/Af/MfKs
 BYsgacJP/z0DoXa3GINEB9ZHB38x7QENrSUiJZyg3b4WelWwcnzdGwUs+dceYlN56AWP24kHE
 awDdrlx07ePr136Jt1TGirIXzH1o+ShXhMRp0UyiWN4P5r8OZRxFg5ViVAqeH3F4+ZhAjWcTn
 CsLGodqrbCX4x8auztmJEBGlXaGdujXSHsEHjL6aHQWDp0ZSowREJNg6uX2WGwWHCqfunRTVB
 BD+YpPM2Gv/TlPKRh/W7jHdznAKKDLYw82sGNcK5p/ah5hr9AGewrKtosTIiIuuYq/rDu7GUF
 gmOZbWx5RjhSZQ1v6xP3Q5jvPA0goQF+Hxc/VSiXvGIBbBIpkXdOlc7AiapklGgel73pKBJFb
 tEFQKlFYpHQnobux/ReW+r4VSYR64W9evMLrHcDtFlRsiaWT5v2RayaXpBS7zdBv+e9IjrvSL
 /+bBOWNVdzQ4JWqbqthu5PiA+CcNzVla9pSt1khf8wcjQKZeb/Mu4cvgt2K5v7AN/PTOnsKCB
 iSKKw7fNFyPY2YMuHjFSJWoqp9YolT9C4TbtqLbP6aV+/76h1LMRCCfzTPVXOyR5VlTyEwsV8
 HgrjFwTc/Qrge75r+2AXspkirw79DxZoY6s5Z1pVoQzKCFs3DqWPcLs28i+TS257alffk4/Yx
 wpvpGRVa7oiSMAwPHgGRVobB/8y+LIAir5UjbKLYU34Bhy5adTC2rs5wyDURCw1yIim4pLwKm
 r4m/db4esN5NLufQG65ghdCMJP/Df5kCWZGdoXOBzyyKAOyhogKPtj0E0WMGGHzH2BSScCXXF
 w9RGtRLyuPpaQSgyJzFoky1YPpxlcKIctHv4lZcWGWdnNWN+GjaAl116RbqFHpaMUYppwGhn1
 MvZA8amoHfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1105006177-1548875725=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Jeremy,

On Wed, 30 Jan 2019, Jeremy Huddleston Sequoia wrote:

> > On Jan 30, 2019, at 01:50, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > 
> > On Tue, Jan 29, 2019 at 11:38:15AM -0800, Jeremy Huddleston Sequoia wrote:
> >> See <rdar://problem/10573201>
> > 
> > It's my understanding that Radars aren't public. Could you summarize the
> > reasons behind this change in the commit message for those of us who
> > don't have access to view this issue?
> 
> There was a bug in some tool in our packaging pipeline that resulted in
> hardlinks not being preserved.  That was fixed, but I decided to leave
> these as symlinks anyways in case users did a file operation on
> Xcode.app that didn't preserve hard links.
> 
> The point here is that it would probably be nice to have hard vs soft be
> a configuration option.

Your patch does not make it a configuration option. (Or a build option,
which would probably be the more appropriate thing to do here.)

You need not spend the time on this, though, as Ævar already did, in
ad874608d8c9 (Makefile: optionally symlink libexec/git-core binaries to
bin/git, 2018-03-13), which made it in v2.18.0 already. All you need to do
is to define INSTALL_SYMLINKS.

Ciao,
Johannes
--8323328-1105006177-1548875725=:41--
