Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2041FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 07:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbcF2HNw (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 03:13:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:60800 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbcF2HNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 03:13:51 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MGzwE-1b4MB43550-00Dkb7; Wed, 29 Jun 2016 09:13:40
 +0200
Date:	Wed, 29 Jun 2016 09:13:39 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Ioannis Kappas <ioannis.kappas@rbs.com>
cc:	git@vger.kernel.org
Subject: Re: git svn clone segmentation faul issue
In-Reply-To: <alpine.DEB.2.20.1606281825190.12947@virtualbox>
Message-ID: <alpine.DEB.2.20.1606290911040.12947@virtualbox>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <alpine.DEB.2.20.1606281334450.12947@virtualbox> <alpine.DEB.2.20.1606281530420.12947@virtualbox> <loom.20160628T175016-898@post.gmane.org>
 <alpine.DEB.2.20.1606281825190.12947@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hWTiBITPQTPeZCgOjTubrqT734N07yLpjldaJrXa2A71q/NPrrC
 4VfGHB9lsABySgU0Cvk6Jum13Dmh1FTVhrtQ1vxXW1d1LvBELAWRwkFiX+DA5dl09QyN1EQ
 euQ4k+c2VHFDfD9qjELLY+49AdTdpSKsfErJNX59twUsjjKV8axi4wFGD1gIKjFz3bgEu+4
 DOCYtG+2zFQz7ON77kbkg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YKrpGXCBCuQ=:YMwmq4nenJR0ov9bdiuUXA
 KuZHyCmmJUCU5MZ5LzLMWEbQs0CCvXjKfIYsxusxHi4PtV09/naPIQHAwLkfbxxj/dFCMBl9f
 MDVdIXRoLJiZs4d6EVhUICGz5TSedKMFZ8POusKFmP3i5U4f2gvuux3BL8z8rpgPVOA7gPufg
 DdltY+BUVqmRwcC/SYNe1C1WQuEFuWDh1luSJZINNWyxtvxqI9fxLuWKEAWg7L5k880cCl7ie
 VXvCyEFX6r1h9fQegobURH8lXzFyqv9bbpSfg99CFEaCiTpn4bpmMvjRiW9D/HtO7q89x89Y9
 I7oEJ7gE6TKHPq8sw3HpQtymHZJqJ8fI8cSE3x/w+oFznTVxf/fIN0vvkT3Lcoijlab4toQ7X
 2CQxYwHH/D0CU5Q+X6fyEGtbDGIE4+pf8ItUGFoUOjEfA2mxCeZi8w+C1EZDGXZuSaYLgTQ68
 4r4hY0n7Z+x3rO1WnX/XkRKI3rr4V4tjdnQziJSpvGLHFq0Zx8WLTl2fav45W38DGwiIGTA9/
 AWs6qTCDnEKnxLLkAfEeA0bE2ftQTwD8QDRqJIfw+1wx6oG9cOyafWxWKlIGnwoWLttjKccfe
 dM1ums8tXfie7FbRZz/of8Jd5Fi9qQXu7GAe5Zyxm+SrOS0jyI07i0NgPde745+b4Ih5q3JkB
 C8LevXH5eG1oUjFI43hb7Y6Qh4l3aDdkzsJ+23ByKkl8+lbb759XmEwHnkvL6yeefKJ3LeXhE
 lfWsRldfHT9sCVMVdt9j57n0tyWXo0s6xW6i501AMJUNTpxBlu6OUQIg2SERfimEpOX55y6Xq
 QPlAhVO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Yannis,

On Tue, 28 Jun 2016, Johannes Schindelin wrote:

> On Tue, 28 Jun 2016, Ioannis Kappas wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> > 
> > > Would you mind giving them a whirl?
> > 
> > The patch in "source code (zip)" seems to be missing the line in the prepare
> > () section of PKGBUILD to actually apply the fix:
> > 
> > diff --git a/subversion/PKGBUILD b/subversion/PKGBUILD
> > --- a/subversion/PKGBUILD
> > +++ b/subversion/PKGBUILD
> > 
> > @@ -101,6 +103,7 @@ prepare() {
> >    patch -p1 -i ${srcdir}/17-fix-test-link.patch
> >    patch -p1 -i ${srcdir}/18-fix-serf-config.patch
> >    patch -p1 -i ${srcdir}/19-remove-contrib-from-configure.patch
> > +  patch -p1 -i ${srcdir}/20-fix-stack-corruption-in-swig-wrappers.patch
> >    patch -p1 -i ${srcdir}/subversion-1.9.1-msys2.patch
> >    patch -p1 -i ${srcdir}/remove-checking-symlink.patch
> >    patch -p1 -i ${srcdir}/90-use-copy-instead-symlink.patch
> > 
> > 
> > Would you be so kind to add the above and rebuild. 
> 
> Oh bummer. Sorry for that! I will fix it and rebuild tomorrow.
> 
> > I have just tested it locally to work successfully, but I do not mind 
> > retesting if you wish to provide another build :)
> 
> Thanks, that would be much appreciated! I'll send a reply when I rebuilt
> the packages.

I just re-uploaded new packages, after rebuilding them and making sure
that the patch was actually applied.

May I ask you to re-test, just to make extra sure that the bug in question
is fixed?

Ciao,
Johannes
