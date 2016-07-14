Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18BEB20196
	for <e@80x24.org>; Thu, 14 Jul 2016 16:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbcGNQHK (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 12:07:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:56369 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbcGNQHI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 12:07:08 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LosFD-1au8xw1VwR-00glLk; Thu, 14 Jul 2016 18:06:55
 +0200
Date:	Thu, 14 Jul 2016 18:06:53 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqq8tx51hmx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607141804570.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox> <xmqqbn2267zq.fsf@gitster.mtv.corp.google.com> <20160713020132.GA13918@sigill.intra.peff.net> <xmqqh9bt34n1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607132048370.6426@virtualbox>
 <xmqq8tx51hmx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7emhG3snPCV1aVbYp2zDP6GaOZponbvi+Zjr3ZyM5LNrkLw4CZL
 3E1qs4D6RHrk08BSmo7+bQAg/Er8fMt+LQtXARWpn+YkyPqDH2HG/zV7S/mDguSDolXtv/V
 MfFvWMC5E3/ztF+pIuW5fHUcHRx2w68sSfQrog10Kh1rx3rAy9dXdUwbDMTfJR/mlxmtxO9
 co3jD/TWVY/0oSKNhySfw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:A8u1ynkNn+w=:DvDD3slstFpzA7mgUTk70N
 8ZmW4gEAVkVK1v0AhV8leF7oTWrTljI96nUc7KRspsZfSxLKfeNN15jefXK/va7xUlfFb6YkL
 JmoRPMprQS4Bsod07wnCocB35PguQQA1fdUDyeekTwI3lDh6IhcpcNDSP5pFJ9YVvrP8EKQ/j
 ectY0GI7ik0ARXLLBByGcHoUCBc3xZe8R/jw2o4+TkuxQpHX9DldClzU5qrUXNq+on9YX/hpd
 ZZXWosl2H5LMVB5WJhErKqdTGckWi+S6pd/AnZ/vKfjhPy9QDvOvwBJPjcDhYFPkgqtQXOrJG
 2/XH/uLNuGNCgnsKzXfa+yN5JDZeN+eeu0/5FZk3Scdt4p2oTgjkMVHGAaX7kaYOdGi+9IEwC
 nZBLVRQeA84ZuaP8S1ywbA1wB5S1uz35cQO4I7cXM3xMIf/6viOB4ESpqVilqwURMlDSnBWDD
 jU70eoTdA2HkoPLTu6Yus2arehXXsFMnHOVxo7Lx3xdQUiwXuzKbtnaqEh6oO/7IzG7moLUZn
 0Jlk9yK6p43S3YBUjSfV9pEQV5mXNTUnbTF6wGZfS38u+Azs2HLjRjyJ4Xa/Tc2ipQfH4ATQb
 n/nxqUOJ1u6IeX/vhKLDNOsgQmbp0IQYPZjh+AOglXkuTH9+qTuVPX+eUE5kN/a8oThTEYLYh
 yzqHCV7GErirnvpb8gzIWphbJmjlwAD7O5EYVJZ7/HAXeUXuEuc8HA/Xdg9eIXglV0ADwVa3s
 +7+VEQRP/0dgXdHcmOrplOuTotVLp4PPEg7vqIviJrWLV95WtsSNszinDj3GnO/aZYzI7UyOm
 i7b5q9X
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> Moving of [64BIT_TIME] lazy_prereq to test-lib might be an upside if we
> were planning to add a test that depends on the system having or not
> having 64-bit timestamp elsewhere, but I do not think of a reason why
> such a new test cannot go to t0006-date, which has the perfect name for
> such a test and is not overly long right now (114 lines).

Turns out we *already* have another test in `master` that needs this lazy
prereq:

https://github.com/git/git/blob/79ed43c28f/t/t5000-tar-tree.sh#L378-L384

Ciao,
Dscho
