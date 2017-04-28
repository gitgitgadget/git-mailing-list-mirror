Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B9C207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997573AbdD1Ngd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:36:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:63316 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165493AbdD1NeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:34:09 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBnSJ-1dDChF3gdb-00AkAF; Fri, 28
 Apr 2017 15:33:42 +0200
Date:   Fri, 28 Apr 2017 15:33:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
In-Reply-To: <20170428112002.tjkcjjdfqenl2aie@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704281346480.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de> <6cc5670f-2de3-33f2-3c85-5a6d99fcca12@kdbg.org> <alpine.DEB.2.20.1704281206500.3480@virtualbox>
 <20170428112002.tjkcjjdfqenl2aie@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6ZhwY4UPlWLjUc9+e3vJ6zjlVHCkl14XDWTCS6HyuzN2EWuYLbw
 //5Xdc3dHnkqq3BVfx4otwWjEJoiE6kjTS4Q6tqTV5visQV19KwcsX+tIaDhKEjqggJ7OKK
 nb/h3B0cxUQmQKWl1t6uIoa4M0veNtlC6o009S0tTlHAUxRoswKiL942IXKH/WOQ6vQVfnS
 gD4UqN4RhM0wFoUIKhAwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vtSr8gY5I8A=:QqeuqhtOa2RC1wwK18pH2x
 5KjGlUV0kfD9eUU8tGDxewxElZzI/jQN16q8d+9mC3KmR3JzEuLNid4mgecJz/wRes58oxMcM
 hMRbwWaidIZZEYU3dyzuu5jsUnJgL4/UDL7hc0V7oub4lWhL6H0k9u+VjKdPbI30m2dH33OBn
 Wh+4jgwVQPWbiqXhgDMnnN80A1kfqAOe+qL3CF/UySH2cN3EBdTCjRjUGwLa2aC61WzS5zaAH
 5uB+q8vYeC7MMHGL5sVjb7yKKjd6QBLF2drmygKmK0pWJbXjZRypJ3BKWyg6Y61v8d71mU8W0
 K0t/KgRl1wuHPMPHnz9pH3V9GaH/MgPzIquL3cuuHfHdPobl1+c34/ClfdzFz/Kb26lM7tbrE
 Xn/QjNTXMUtr6L24NBjEBK7UNyXgm+nATS9Q/Ut/deCrnWGtmSNs+S3E2xg7eq0BjQJKOOBVB
 oEduTjPOhop44kxkkCX39oCn6PvPsE5w5LqeiZ/IpiaTSbpzxz2u6v+ElvXHZHQdSWDCOrZ5T
 uVqF0yq7zP87SKxTlcoxi5fTZVHUuvvJJ0BoMaPmtzEPtE55sGUc/1c+puXQuIGL4H6bNmyru
 dDblrYL9mtivCE1EtO3Q0mvexDBnqTFrM0cGqC5pmyL0atYs+py+2OrumTxVcU+snqsuxXULv
 sIO7sZWfxoD6SLOf5rYRVQLCblB9fbDaKHWap0X9RiYmmjrsOlpylgoTp1wbYjUdgkyz8SRVi
 h7ehpmXS2Z6Ru+uHVd5TLpbxzqBsxBKQ+xVw9u4CyaD0klTKeNoxuvKgU5A07p6uGgAz06XEh
 iBLiSfs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 28 Apr 2017, Jeff King wrote:

> On Fri, Apr 28, 2017 at 12:41:02PM +0200, Johannes Schindelin wrote:
> 
> > But then, I guess I misunderstood what Coverity complained about:
> > maybe the problem was not so much the isspace() call but that EOF is
> > not being handled correctly. We pass it, unchecked, to ungetc().
> > 
> > It appears that I (or Coverity, if you will), missed another instance
> > where we simply passed EOF unchecked to ungetc().
> 
> I think that is also fine according to the standard.
> 
> Do you happen to have the exact error from Coverity?

Wow, that was unnecessarily hard. It is a major hassle to get to any
scan other than the latest one.

But I did it. Call me tenatious.

The report says this:

233        do {
   2. negative_return_fn: Function mingw_fgetc(f) returns a negative number.
   3. var_assign: Assigning: signed variable peek = mingw_fgetc.
234                peek = fgetc(f);
   CID 1049734: Negative array index read (NEGATIVE_RETURNS)
   4.  negative_returns: Using variable peek as an index to array sane_ctype.
235        } while (isspace(peek));
236        ungetc(peek, f);

So part of the thing is that we use mingw_fgetc() instead of fgetc().
However, the return value is *still* the one from the "real" fgetc(), even
if we intercept what appears to be a Ctrl+C from an interactive console.

> I'm wondering if it is complaining about some aspect of our custom
> isspace() when used with EOF.

That would appear to be the real issue, yes, and I should have
double-checked the claim that POSIX isspace() handles EOF properly: we
override isspace() with our own version, after all:

	#define isspace(x) sane_istest(x,GIT_SPACE)

where

	#define sane_istest(x,mask) \
		((sane_ctype[(unsigned char)(x)] & (mask)) != 0)

(rewrapped for readability)

As usual, EOF is defined as -1 in Git for Windows' context, meaning that
we look at the last entry of the sane_ctype array, which returns 0 for any
sane_istest(x,mask) test for x >= 0x80:

        /* Nothing in the 128.. range */

So it would appear that it happens to work, but I doubt that it was
intentional.

Having said that, it is really curious why Coverity should get confused by
the code and not realize that casting a negative number to (unsigned char)
will make it valid as an index for the sane_ctype array.

I double-checked, and there is no override for the isspace() function in
what Coverity calls a "model file" (i.e. pseudo code intended to helping
Coverity realize where it can stop reporting false positives).

> > The next iteration will have it completely reworked: I no longer guard
> > the isspace() behind an `!= EOF` check, but rather handle an early EOF
> > as I think it should be handled. Extra eyes very welcome (this is the
> > fixup!  patch):
> 
> I do think handling EOF explicitly is probably a better strategy anyway,
> as it lets us tell when we have an empty patch.

I agree, I came to the same conclusion independently.

Ciao,
Dscho
