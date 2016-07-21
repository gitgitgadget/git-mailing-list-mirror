Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DFE203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 13:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbcGUNU6 (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 09:20:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:58576 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbcGUNU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 09:20:57 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MYwQh-1bn27S03cp-00Vh79; Thu, 21 Jul 2016 15:20:13
 +0200
Date:	Thu, 21 Jul 2016 15:19:29 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
cc:	Junio C Hamano <gitster@pobox.com>, Theodore Ts'o <tytso@mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <20160718230324.GG6644@vauxhall.crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1607211454061.14111@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com> <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
 <20160718230324.GG6644@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hCEDFUMCQby/9H3SFkUMMrmmaLe8hZXR4betEg+fIM9nKwPXqUV
 vIqQ5aIt3TZv1aIDt+kYsQIKfoAuzbFALeAzdarfDzCmz1a/imPVI/EpB75UxBfoNIavGLF
 fMJahNPNqnt6oL0HSTO4UJd9Rowl4S8M08yjE1qjw4QNWKKjdAXVfT7QMF9DFQVYNAL0Z9T
 JIrgrJ0Wus5ckbOETHMbg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:r7grqr4Aym8=:Hot696Uxd9LkFUPHj9qAyh
 t6ofk5wg3aInuLRNyB9gWP4pzr5xwcJjoFPbvb8255ARyHRWCP4UD0wb8iidReAvzH/9EIZ8m
 NHUgBcLg9SsvZtF5uercD/GgY+8pDnYfKm1DJol6RyKgMhNXVxPjD3+lzHiGQPfID9Jw2vn/t
 4Sh5QgAqgk+seHOEhXO0k2bBgpgv0Ccia499U/kdK7tItWp18KXmNlRuwnMWdK21agpn14GxI
 gPgSeEg92DD0Mn1HyEnT+r/wYBIqlorlpHzMIATtRwS2sA5l5BOTHYbfxUmi4jWy9s3ggp1UW
 fSQ51sjrNr3rRxG98xvP7yCthxJRzGQr4ooYQgPqphxpRsN0n1YH7n25ijuWBsE8ANiFlcV0y
 /2iA5OyjzBR5EFdIiNQOtdrjq2uSLw3BxrrlTi3IEJk5zMOah+qwBaePFpquKhCA4uk4cm24E
 qQlqsIJ+2hkhMIgqhj7inHTOPyNZ7Edlwvw+eIWdsjpQQY+sK8qWp278gWB/nHSqOO6GoNCA8
 aNnbHnjuhA1M2F9rUnTwxjBDfFN+qrZ4EeNlaLc8w3qv+t9uefYDUpuZ5A6nFi9AWmCzjgdDp
 5pFBX9doYOgVsKjIRwxE+RxGv4Pr72FzjXxbjN6WIDxnmB11DUL+L6sY9aNxs55WleWUaiF/c
 y/b/7RqOQPibniKOvLNgDe3SM8l98XU45n4Cp7tiW8aPGmI1vjW06iE2UxV+f10qMgVsuvcOL
 1fbNNMaNtyf2QdHQ4PxThwkbzib1r0cs2Ni8xAENr2siDOUY7S8QfouKpe/lFdAGNdxJsdIMI
 ezqpg6p
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Brian,

On Mon, 18 Jul 2016, brian m. carlson wrote:

> On Mon, Jul 18, 2016 at 11:00:35AM -0700, Junio C Hamano wrote:
> > Continuing this thought process, I do not see a good way to allow us
> > to wean ourselves off of the old hash, unless we _break_ the pack
> > stream format so that each object in the pack carries not just the
> > data but also the hash algorithm to be used to _name_ it, so that
> > new objects will never be referred to using the old hash.
> 
> I think for this reason, I'm going to propose the following approach
> when we get there:
> 
> * We serialize the hash in the object formats, using multihash or
>   something similar.  This means that it is minimally painful if we ever
>   need to change in the future[0].

This adds a lot of redundancy, though, and has an adverse performance
impact, no?

Could we not simply require packs to identify the used hash *once*, and
use a single hash algorithm per repository?

That would mean that we would have to re-hash packs on-the-fly if, say,
talking to a SHA-1 remote from a SHA-256 local repository.

> * Each repository carries exactly one hash algorithm, except for
>   submodule data.  If we don't do this, then some people will never
>   switch because the submodules they depend on haven't.

If we re-hash transparently, we could get away with SHA-256 even for
submodules.

> * If people on the new format need to refer to submodule commits using
>   SHA-1, then they have to use a prefix on the hash form; otherwise,
>   they can use the raw hash value (without any multihash prefix).
> * git fsck verifies one consistent algorithm (excepting submodule
>   references).
> 
> This preserves the security benefits, avoids future-proofing problems,
> and minimizes performance impacts due to naming like you mentioned.
> 
> [0] We are practically limited to 256-bit hashes because anything longer
> will wrap on an 80-column terminal when in hex form.

We are not really bound by the 80-column limit when choosing a hash
algorithm. We typically refer to a commit by a shorter name, and the
80-column limit applies only to Git's own source code.

Ciao,
Dscho
