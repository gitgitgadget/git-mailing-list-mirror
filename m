Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168162023D
	for <e@80x24.org>; Tue, 28 Feb 2017 10:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdB1KVj (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 05:21:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:49823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdB1KVg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 05:21:36 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MI5JG-1ckIDx1SAw-003tnh; Tue, 28
 Feb 2017 11:18:31 +0100
Date:   Tue, 28 Feb 2017 11:18:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http: add an "auto" mode for http.emptyauth
In-Reply-To: <xmqqpoi3xz1i.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702281116360.3767@virtualbox>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net> <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net> <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com> <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702251243390.3767@virtualbox> <20170225191506.4it7pdsi6ijanfft@sigill.intra.peff.net> <20170225191831.dkjasyv3tmkwutre@sigill.intra.peff.net> <xmqqpoi3xz1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R/+x/g2NWMDbLbAj+9Qxxz/u/MXSCGJ7TtTT2HNBoDG4L/nArWn
 7x5zGqJ8ftXAsVRxnZNqAVGYpKQl7I58ox4cIKfHmQQ+VCT59FKa19rvgAv3YZ0Rn6zpIO0
 j7kTQGKUQlcaZSfhU6XhKMfff8FNTm7kvnkGqg5E3OFChnXhVxR8GOJWMD5+SztAZUoNX/x
 iClRPv9F2yI2Xv7ltZumQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GbzFTCJSvr8=:/XcU/bSCBAH+KcblvaOowd
 6Jhy8QnltN7z3suSOOy8L5a7Cf0eEfFtFPHFmyahPLar+XBxQMg5DFUrpNICOyLAwMe2F3250
 w84lwm2pSRy1qn0SLqAQSH8sISRpKwE6HBDemu/mKbXwi+VSRNRAoUK8wqrSPH3g+ZqQqqgRI
 koOJ18Qww/mUq6RwNekHWEin5bI+THUa0UId39yd7vc18DLxUnPCkJ4PK0JD6IuqpItuqYwlC
 yP0FUz24Mjth8cqB/GhGSmjBO7bA+g9ioF0ONaAlD9ZRL3d1zr5bsN+bB/VVIIRrmMyTG1dIj
 cGqDdIpdthTqMrzuwfrFtrRC8VyQtYbSABomZ83CEzoRwxpbLSJtioqdfyKjBVTYv63ytj3e8
 LrkASrofGGn1230Kae0SQ44xmWpOZwKfU9KrTtK557b14dmfXsQORF+pWwgE/gmtzfT9NE+tU
 Yph5dgmQanTa6lch6r3VBQWTcZjviQidz0ZWaNlzlqVfPFKV2oi37eRW/lJKUu3X3vM0S1d5y
 TsiRoypHThbvVo/7mPgNz5nDrsfueEe1+JcJR36FUUrRVsMNeKJ5G8/067gE+8+Y6jt8rH3K3
 +xLts2QAqAmaaTUseEShdcF1fy52ksLWHzGFnGgCbyiGbyIOIvF7CPJRVXAZ+wQ5crKm6NxOO
 6tAepOHPnf+cnJbRYEZAmxv4nH4McG7bi6b5SMbENgd+Wr1V2agFA3UlzmohmQk9n0QSIhqDG
 wGraGd8u73u3Ms2ZKuZirsOcPQU11ZsSPdbbSxQqgIn3KCcsDS00ZdwthMQj4mHxVRf5ai5Wl
 gw8ePni2MYOsIIMYxaXXp9kry6hCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 27 Feb 2017, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The auto mode may incur an extra round-trip over setting
> > http.emptyauth=true, because part of the emptyauth hack is to feed
> > this blank password to curl even before we've made a single request.
> 
> IOW, people who care about an extra round-trip have this workaround,
> which is good.
> 
> This, along with the possible security implications, may want to be
> added to the documentation but that is outside the topic of this change,
> and I think we would want to see such an update come from those who
> actually use NTLM (or Kerberos, but they know they have minimum security
> implications).
> 
> > +#ifndef LIBCURL_CAN_HANDLE_AUTH_ANY +	/* +	 * Our libcurl is
> > too old to do AUTH_ANY in the first place; +	 * just default to
> > turning the feature off.  +	 */ +#else +	/* +	 * In the
> > automatic case, kick in the empty-auth +	 * hack as long as we
> > would potentially try some +	 * method more exotic than "Basic"
> > or "Digest".  +	 * +	 * But only do this when this is our
> > second or +	 * subsequent * request, as by then we know what
> 
> I'll drop the '*' that you left while line-wrapping ;-)
> 
> > +	 * methods are available.  +	 */
> 
> Thanks.  This looks good.

I replaced the previous version in Git for Windows' `master` branch with
the one in `pu`.

Thanks,
Johannes
