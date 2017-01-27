Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62AC1FAD5
	for <e@80x24.org>; Fri, 27 Jan 2017 10:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932529AbdA0Kbz (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:31:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:55135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932424AbdA0Ka7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:30:59 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LyVcA-1cTPH52TN0-015n9C; Fri, 27
 Jan 2017 11:30:01 +0100
Date:   Fri, 27 Jan 2017 11:29:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] mingw: allow hooks to be .exe files
In-Reply-To: <xmqq4m0l64pg.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701271127520.3469@virtualbox>
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de> <20170125211529.jq4halip4ndbff5k@sigill.intra.peff.net> <alpine.DEB.2.20.1701261321010.3469@virtualbox> <xmqq4m0l64pg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lwB9uyRprzzoNzfk3gIp/l2vpROvYK8SnSFlTiZojqsd9Vwtjct
 GSm1Lo9EO5eZhZ/C9UF1yIDpOtZ6T+EtkgtReSOkd0y/Gqz0y2ztB9dPyEtUawUoPBjYOXf
 aYKPjhCA0JAyvA2Ql4LiGtiOfENWkg6Vwskn+5Io6YHg274osDTIccA9WAJHG5RfpxLOdWs
 oXWa+pygjnjq8sJ5tnS2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qk+QyXF/R1I=:S3Op3SeSlCxDPMdg8J8tj/
 AwByt86gEG1arMXPbPY0IOky288jsw3VZoPR4NPQG6Hwsn++YZABKi0uAsXywhIpXjvkmCycs
 jEbU3DPMvZoKjiRmEUaHjA0jgyOxCwTPT+3Ho2xr5PqNjfS6Xq17WUEqthX6d/BWRnJMffp6L
 lXAZoEFWkdcBOvjPRXey5EkBlCS2nBddkUmDuqt2kAQT2aIEhvbDy1jTppsJS0SjzQ7KBzUJM
 +QG+iKLAjKxZV0F7VVH88MfJIBELzJD8lmReR78a8e5ykA/zqazLyBN9GR0STPlK42N9dGZKk
 X1W4nbrFLovq13bNTDsCFvDZOJAMFzM/bjFo0L4KRu3SaWVZMHz4Nx0h/QGmjLS91UgFp7KUn
 SRn34QIJy7nYZ9b5LxxcRUwB94GEjXazHhgseoacxMfCxC0WdzM+JiGTmx13et/WKflZzKAaq
 2v7966gjKTYHW1frfI9utvZhFXMYriSlVvnC5AeVPtqWMxP+x5ycuREqWTSKceFc6DMUsF4eO
 xFNxObS1nFRQnH1+mDZUFBuRlP6I9zYoqQRFXz2lvLiy6HLofz837mRszTa444jmh+k5aYhl4
 rRCZIdysY0ojdpxJyd01A+QboCyzbWnJy3qC9GaLoFOtiI8QdWXPMXavsXx/fSo5TMCm2fuUA
 6fflweNUL38TeTscxQkuLPKW2NDKE/B8jCu5t/cXb5HpVNWBmsWU4a5DeoNqn6vjGP6Tp5sae
 NXjOTglFsjh5+3J9zYtLsSdSqfaYDfQZRKE6G0TpxSgbGZpNQHzVVS/ra6o6gh4bNWfMPa5zD
 ZDQ85B5JmiMu0pIcvTnGrqC3wXOGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 25 Jan 2017, Jeff King wrote:
> >
> >> On Wed, Jan 25, 2017 at 05:58:42PM +0100, Johannes Schindelin wrote:
> >> 
> >> > -	if (access(path.buf, X_OK) < 0)
> >> > +	if (access(path.buf, X_OK) < 0) {
> >> > +#ifdef STRIP_EXTENSION
> >> > +		strbuf_addstr(&path, ".exe");
> >> 
> >> I think STRIP_EXTENSION is a string.  Should this line be:
> >> 
> >>   strbuf_addstr(&path, STRIP_EXTENSION);
> >
> > Yep.
> >
> > v2 coming,
> > Johannes
> 
> I think I've already tweaked it out when I queued the original one.

After digging, I found your SQUASH commit. I had not known about that.

In any case, I much rather prefer to have the final version of any patch
or patch series I contribute to be identical between what you commit and
what I sent to the mailing list. We do disagree from time to time, and I
would like to have the opportunity of reviewing how you tweak my changes.

Ciao,
Johannes
