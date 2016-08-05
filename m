Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5BF2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 14:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759771AbcHEOTT (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 10:19:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:53283 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbcHEOTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 10:19:18 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LiHc7-1askiS0lOd-00nQkw; Fri, 05 Aug 2016 16:19:11
 +0200
Date:	Fri, 5 Aug 2016 16:19:08 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t5533: make it pass on case-sensitive filesystems
In-Reply-To: <xmqqwpjw4fmj.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608051613570.5786@virtualbox>
References: <93e1fb21d1d24c5b751e2d9d25d9220704bae5aa.1470322425.git.johannes.schindelin@gmx.de> <xmqqwpjw4fmj.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dF7oBNrxx97baEgV/E/46VdlFYUjIRTS9IcAgkXC4V+opj3svUr
 0Q3OdD945Ad/ar+NMo7CuyD8hmlCfiGyoQL2+XiThkJEq60k3pscEPnL+z04Dg+ePkX37SY
 1NbJg6vjyX8ZXTWA+pqyCCs5nnEZt+GoL8tY/t1bZ2ofaAqm82DXX/v6m/1HzvMlN+C9L2W
 sRLY7a1LbVt39YOqDRzjA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Sk7VDz66Qb4=:/JvfcMm2wpm8c3ZTU0k2c8
 D8wNinG9EjBPzEaDCV3GNqv7/I73LeUzv9smGzv98cJP1nLKwinrKqRSctncnr1TWF/5Cke6I
 578MnhRc4wopa7F+TV6lupsC/PwYJDnUqLmRh89e/GGzSqEnt/hGaZQMa3Ai2pepG5uHhOb3+
 EofS8T7fW1xhgHrcxnZN1FWkdtHJbh9NzMGHiYsqustmVZCmiFshYfVR6EQJvEStHjKqpsXfz
 ZfFvbzuT+iWCYkqPg+yznGW7JtC/7shu8PZMUrFjpQF2a/ryZrQIEnTsjWd9bQQzveCy2Z7xY
 gbYzSzkeWOTXS1yYP2ko/w+NIP/ahGhrF4VtSlWWNb5riAJkj5crsIvCd3WWMlfq1bJkyRMfE
 CIjG5FdA7C1RpsghvbvZyCarqW55flrPrPijUNoabIRunixYCGqF0157nIOrYe9kf0OoEOcEm
 c6DZQY6hxXLkOMeJXmVNhMD3orD8upJje/TFl+OgJPFV3NPuBgF2E8Oqkc9Smumb7H0FUqDrc
 Hc8poSwlFk+1+41ve3Rw17E694NVpTqCd37+KhJhfBOKz2qQa8i9G9Xaxiay2d93lFwj7WntT
 +09+4iL6axPJvLNZQ04tJDOio1DoAJfImFC+EZXB1722YjvCmiA/T/dwGDcNpjndCjg+9D5M1
 dwLspkGolVMMmwUDnjhCvty4+Tvqoodx1Pg7Zd1gtrPqgkL0vQq/tjhBWDY06Xq91221Y6nB7
 Nh0p7DXo8HmsohVTv9JXu/4kHEwxmwgWCXdeMwlqfYf8PYlgbD+ue8WA16kNDPOqFbP0Do/iQ
 4koFQLm
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Thu, 4 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The newly-added test case wants to commit a file "c.t" (note the lower
> > case) when a previous test case already committed a file "C.t". This
> > confuses Git to the point that it thinks "c.t" was not staged when "git
> > add c.t" was called.
> >
> > Simply make the naming of the test commits consistent with the previous
> > test cases: use upper-case, and advance in the alphabet.
> >
> > This came up in local work to rebase the Windows-specific patches to the
> > current `next` branch. An identical fix was suggested by John Keeping.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > Published-As: https://github.com/dscho/git/releases/tag/t5533-case-insensitive-v1
> > Fetch-It-Via: git fetch https://github.com/dscho/git t5533-case-insensitive-v1
> 
> Thanks.  It may make it easier to see to have a blank line here,
> separating them from the diffstat.

Good suggestion! I made it so:

	https://github.com/dscho/mail-patch-series/commit/1776cb18

> > base-commit: 9813b109b4ec6630220e5f3d8aff275e23cba59e
> 
> A totally unrelated tangent.
> 
> This line turns out to be less than useful at least in this
> particular case.
> 
> The fix is meant for jk/push-force-with-lease-creation topic, but I
> had to find it out by the old fashioned way, i.e. running blame for
> these lines in 'pu' to find eee98e74f9 is the culprit and then
> running "git branch --with eee98e74f9".  The only thing the line
> made easier is I _could_ start the blame at the named commit (which
> is on 'next') instead of 'pu'.  When I took that "base-commit"
> series, I was hoping that it would give us a lot more useful
> information.

Sorry for that. The way my mail-patch-series.sh script works is that it
tries to determine which branch between `master`, `next` or `pu` is the
base (and it then submits *all* commits that are on top of that branch).

So my branch was indeed based on `next` for that reason, not on
top of `jk/push-force-with-lease-creation`. Otherwise, I would have
resubmitted John's patches because the script would have determined that
my patch is on top of `master`, not on top of `next`.

Will try to think of a better way,
Dscho
