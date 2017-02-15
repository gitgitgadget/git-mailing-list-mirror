Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E9D2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 12:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdBOMtB (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 07:49:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:53913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbdBOMtA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 07:49:00 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQiVh-1co6xn3TCf-00Tyao; Wed, 15
 Feb 2017 13:48:46 +0100
Date:   Wed, 15 Feb 2017 13:48:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
In-Reply-To: <xmqq37fga9rn.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702151332540.3496@virtualbox>
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de> <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702141545380.3496@virtualbox> <xmqq37fga9rn.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:h5NALFFf9ASNdCKsb7GdjuucvY2TnlcGpzDMVdDYeJoxKdnfE52
 LzYTuwzg7jucJRXM9ki+cJ070IfW1JmWQE7SJpWtE9CDM091x0xIWjPCDYFLjzTSl2WyPX1
 1/DFu7o/P+NRDITVuIMAhCd5PFvB5aeL5thbReFu0bQjhcNQ/6K2bzs8ZJ6B7w9cC+dUx2o
 RiRVqO1rfecUwLhkXooAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Vm6uxthB+A=:EfTgDwhvSxTXkl4MAYRlGF
 Dus/mMFHt9MbvAN2J5bQp+s8aBdr1Ta/LExZIMfaMm4lt2gAFo0yqq6XzbK5vJTsTkTB3ceiQ
 TDrRhZ84Ob9i9lvG8RpWlOZLz+rgfZuiunB9RnXHUrfkle51wpwZ4Y782hnjsdmCeyAVoAYQS
 aOpxNfH3iadLv5+L8ix3LQfLQ+q0PfwRgBQztU1K0TznWgCsFXmXRsYJa5xpXMvANKSSVlfLX
 cxoCGaKE6iqIRGx58/+pDy0RYHHhllDL5nRY/NHbZ7/226a4+HESJw+EppvSg8/qPMqUsO8GA
 SDhEHeoR0sqPYto1+oGA3JY/GnOODPAkphnZMTvoqaD6FjTZxSZT43LjUEv7FEgu3TWz3Vfup
 TVMGVjuPmzWvBreXiaUWItqNQqdQ8esATXlsUYB0XXBeHS/OwWYO2z0FbWGNOXALKNGxu0o/d
 tmgW+r7ENhEVIeklCl2d+8qLcQb1SogBLa+fnSUqDhieIUg6kRL12PZcMvb5i64GwcMPEjvzj
 A/0Euf6yWFccp+QrGHi0mAesxKFCCyj7WDXLhHSSOvS7IXwS8YU2JNKC32/6348XH7E1uee59
 J77p7rz3wczzjAx/2sXZV1WNiG26Yid7rJ7EIQIIar2vhakvDna29LJ6ca+eZabU3fEKrgoSE
 En+lTvPXtsU/ITuMy3S+i6DDSy6XPoVw49eaxseYJi6lc4W1jVom44IkxOZfCND4q1hZgYU3s
 WQIhHqUakdrstMPxERsncvogWMxiSC8Is7w0xIPh7cDt/my7CcZE118QyjdmA4dEGP5mM0kwL
 SxgTiQD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 14 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> OK.  Should this go directly to 'master', as the isatty thing is
> >> already in?
> >
> > From my point of view, it is not crucial. The next Git for Windows
> > version will have it, of course, and Hannes is always running with his
> > set of patches, he can easily cherry-pick this one, too.
> 
> What hat were you wearing when you said the above "From my point of
> view"?

The hat of a person who sees how patches are reviewed before they enter
pu/next/master/maint of git.git.

If that review had anything to do with Windows, and refused to accept
patches unless they work correctly on Windows, I would agree that it is a
wise idea to fast-track important fixes for Windows.

But that is not the case. Quite often `pu`, sometimes `next`, and rarely
even `master` are regularly broken on Windows.

The only branch that is tested very stringently on Windows, and into which
nothing is allowed that breaks on Windows, is git-for-windows/git's
`master` branch.

BTW this is not just an opinion, this is just an account of the current
state.

Once you accept that this is reality, you will understand why I *dared* to
say that a criticial Windows-specific fix needs to be fast-tracked to
git-for-windows/git's `master`, but not into git.git's `master` branch.

FWIW I wish it were different, that git.git's `master` reflected more
closely what the current Git for Windows version has. If you are
attentive, you will have noticed that I continuously work toward that
goal. I frequently "upstream patches" from Git for Windows[*1*], even if
it seems that the influx of new patches is higher than the rate of patches
that make it into git.git's `master`. And even if I am often asked to
change these patches so much that it is virtually guaranteed that they
regress (hence my recently increasing reluctance to accept each and every
reviewer's suggestions as "must implement").

Ciao,
Johannes

Footnote *1*: Yes, I even "upstream patches" from developers other than
myself, trying to shield contributors from having to send their patches as
mails and to cope with the reviewers' suggestions that may, or may not,
make sense. This makes my life harder, but I believe that the alternative
would be *not* to have those patches in git.git *at all*.
