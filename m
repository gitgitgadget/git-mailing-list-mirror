Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60C820986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbcJDRQd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:16:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:50299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752572AbcJDRQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:16:33 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVrQS-1bOnQW1jJo-00X2sa; Tue, 04 Oct 2016 19:16:08
 +0200
Date:   Tue, 4 Oct 2016 19:16:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Rich Felker <dalias@libc.org>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        musl@lists.openwall.com
Subject: Re: Regression: git no longer works with musl libc's regex impl
In-Reply-To: <20161004161130.GX19318@brightrain.aerifal.cx>
Message-ID: <alpine.DEB.2.20.1610041915320.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx> <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net> <20161004154045.GT19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610041802310.35196@virtualbox> <20161004161130.GX19318@brightrain.aerifal.cx>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KEm9/0QVP7u/okA2r9rGUM98VUW+5T7xTQOeC6CNUnGIVAHyP5f
 k/tiO03tpSAmYRsEWoB9sd9TNYdcPRYCziCAhhHpxd70LMEXTOxFmFRZpskkEqsix6FqzSJ
 thXE0eisqK8irk9eEkTAZUqWhDsneqzviycjgw1+o/62BzcAaxGv1nRhzGVp9wwxfaX9KWD
 YYQxgB2QKmCWezfCDl00Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vMgvTVJiI/I=:H4fR+s//xwIYE4vmmChjAg
 oHCaIhmMxrF9ZWAVO1C4exQZDrjtDRQtg9BprhBzijq5fi5Gl1LQ6CxB6Wc5aspupBmj/jTHY
 TeXCawR1BjfQmpJNG+TjiTaYQoBCwMAaACYY6TFL5hHYp/QM9hGoOkcI/hpOvtB2rqIWNxNa3
 1iF28DMQ1ztxgZlCXaSH6qp9DLp3Q0vf8yxWLB5uqsoPmF15sUlADeb8QtGss26OjMpF1Ylrr
 BCRqx/+g1tZoHPtdpzOGY8KzzJHbt20Qw4n2+n/vMJM/ZHjEBhIHJcJh/qNwyWNkd73zoOUHg
 7Lwe4avgX1/sCCe8z+eqcoc/T1CL3nDnaBwPW2Av3xdZFYxNbgZ3dr26L8RWlMYbf9p7Gvl4/
 YLwfOQbhcr7C5oZTPDsWz0QVqif/mpy69iB44XW1uo8XvINcdAKiTROgSwfKxAYHjKc6AUbrt
 toxlBK1vLB+kzJVHznXUY+2CizA5FGgptDP4PZaKoDWGhjbGbviiFTZOcEB8luXMGzmvxA0EE
 AIFh0rLLbWFz1/ARHyVAxtPdYzZO+GiuEs0TRwW4PdzgQFy4Qy6uGBrwEGyNt9Pn0SSsBFj9+
 a2ysXbVdpBn85WhzaSNJq2bHR6rwrr2MigdNtO4uq+OJcUor45Ys8V8S84oLNYyvH7UgmV2AB
 JrNyvbdGlUAulWKhlEoqOSX3cKkSHnqM5hg+ix15PHKI0/wNGckbBdcFnQoj39AFPSvtLy1ZW
 B/Zcw5FwuQWiCs09D0b/jgclqNDCX8yB/Wqr808afvr8Ofstg53f+Tz5R3Y3iyE1rgIDR5n4o
 mU14AbG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rich,

On Tue, 4 Oct 2016, Rich Felker wrote:

> On Tue, Oct 04, 2016 at 06:08:33PM +0200, Johannes Schindelin wrote:
> > Hi Rich,
> > 
> > On Tue, 4 Oct 2016, Rich Felker wrote:
> > 
> > > On Tue, Oct 04, 2016 at 11:27:22AM -0400, Jeff King wrote:
> > > > On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
> > > > 
> > > > > 1. is nonzero mod page size, it just works; the remainder of the last
> > > > >    page reads as zero bytes when mmapped.
> > > > 
> > > > Is that a portable assumption?
> > > 
> > > Yes.
> > 
> > No, it is not. You quote POSIX, but the matter of the fact is that we use
> > a subset of POSIX in order to be able to keep things running on Windows.
> > 
> > And quite honestly, there are lots of reasons to keep things running on
> > Windows, and even to favor Windows support over musl support. Over four
> > million reasons: the Git for Windows users.
> 
> I would hope that in the future, git-for-windows users will be using
> musl, via midipix, rather than the painfully slow and awful version
> they're stuck with now...

Git for Windows actually uses the MSVC runtime, which is blazing fast.

You are probably confusing Git for Windows with Cygwin Git.

Ciao,
Johannes
