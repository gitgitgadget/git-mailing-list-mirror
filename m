Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063992023D
	for <e@80x24.org>; Wed,  1 Mar 2017 22:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbdCAWGI (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:06:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:64256 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbdCAWF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:05:28 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McluX-1d0S052Vij-00HwLr; Wed, 01
 Mar 2017 22:56:20 +0100
Date:   Wed, 1 Mar 2017 22:56:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>, Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
In-Reply-To: <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703012227010.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>        <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>        <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com> <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pexzc+5PwC/VRz7f1J85ja3heOwXpNd0qBHDwFo8aUkTAFI23wY
 4JQqIk7aSPAHPi7aO8vuONGEFixlQyvHuKtYd96S6dnSDC3kTrnZ0CJ0AHFPjSFeFar25V9
 0qr2PiT5HVcVdljETY19od8XqhS2ONHZ2wAFylPgOxt7Ooj50h4zRI6/fZbp/eQ/eN4jqOH
 8SWUlo2qX8No56S3OrQMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uxog4OasyDE=:30aOPYieE22zVS7RugQFSG
 MGtlpzJCqlfKbf/rTgpfxInfV0fZFkYN78qnUnLErRGd9PIRDesDJlDFhT9cF4htkcK8YEe8N
 dMnpjKjxsf7p43UivFBdyPdx2k1k4jWh7ZRQoQ3zLSBt/PcdXRXWr+IAmM9G8vR+js475lvEC
 1WF7fvm6NvTpDTjjZwEaMaQ74ddPwdnPXqK/nxTzFo6v30x0BQS0+5qGpBXIUNaz9p2n89NqT
 hPfa0niCVRk1l+uNKJPQcnxcvUboo7Ufo/C0ZJnpM7G2Vb0MpEFJ1dNkU3Ieo/ttTbHM+wD8O
 GEoLOvNwkXA5gGlStEiRQ1WIRo9O+7AufgSha5E+JS8jnzJXb0pZuWwUan84cd5irziZaTY+P
 9B6jFAAn8nE7LhuTYVRr5NPcAXsP5jTyGblBNfArgTZcUOwXCwOA4jMpKHiBPrmr66rIoSzIF
 4nsePPvqVFIoq/ORgZypeTYFne8z1dCYTK27n+XydJ9xBq0QCadRfxdwnNUYVTFah2ys3a9Gp
 JavZcEta4lSHyTJZdRS/fvCcyNFde+2JVUJlcAu4lbVkCwPNC8g2Xt7J6Og7KF01oAPIxNCmy
 KQAs9nlytDlNLDXN7f9jD/8ru/1KOwOhk5k7GAQjcaKmoiUM5SrRlA2S15Ar5SbLigzCky0lG
 A6VHRw7KdEil4xrQFlLLK0OYQdsuHV/Dre68ODuChG7Gsy+AlaTmWPq8OVBzz+C8IOeK7Jkau
 xI/dhdqW//8HsAlmkfQHMwVbXxmsd7QAPC9XeQ0vnKi3KFW3CAxim6U864045CYHMEeSZZ1fD
 T6ROYHWL+pfevGvdoqdTHF3fM/cnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 1 Mar 2017, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > That said, I think that it would be lovely to just default to
> > USE_SHA1DC and just put the whole attack behind us. Yes, it's slower.
> > No, it doesn't really seem to matter that much in practice.
> 
> Yes.  It would be a very good goal.

So let me get this straight: not only do we now implicitly want to bump
the required C compiler to C99 without any grace period worth mentioning
[*1*], we are also all of a sudden no longer worried about a double digit
percentage drop of speed [*2*]?

Puzzled,
Johannes

Footnote *1*: I know, it is easy to forget that some developers cannot
choose their tools, or even their hardware. In the past, we seemed to take
appropriate care, though.

Footnote *2*: With real-world repositories of notable size, that
performance regression hurts. A lot. We just spent time to get the speed
of SHA-1 down by a couple percent and it was a noticeable improvement here.
