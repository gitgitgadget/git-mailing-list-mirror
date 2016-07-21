Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F242203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbcGUMyq (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 08:54:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:58820 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbcGUMyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 08:54:45 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LuJDv-1bJAMA3N2d-011mM4; Thu, 21 Jul 2016 14:54:17
 +0200
Date:	Thu, 21 Jul 2016 14:53:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607211451060.14111@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com> <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net>
 <xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Fe8K8ZBrA2uojiv3uGtu1HVsPVNPHD0xO1z1ohX+5ZoO7rvyz9z
 X5gwJQhGD9F7+GZDhWcU3KplV0zAAN+6YJOyuqXwIrAfXCRgNHdt5OdEJwoTVJM2sKyoDZk
 HGzey32bRrr56JP5GruQtYYKdwKYk9J4p1sSK4fjwfP/Zavipcjke64T6/HAW+LwjkhPbIq
 H5SASXGiaD8c4q0guvd1w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:vZrfxayDvsE=:wBglSK7RErHPpcAFxODIc5
 fTdSUnjqAY3+uFCQBPAvPyr3bqm2/fX4oVnsPY2cb2/353XaUr9XZd6tpLooO3Yki7/gl66O+
 ga7qdiPoG1r97q09yWSWPVa3RTmPiAE/Lsxq3iUP8K/y9DEZKd5mxHCnvNLaqFms5b544xTK0
 A8y9//zF+667+x3POnUEcizSmehUw/oLk9mgljotejscBZNpdmx5NF7hLJg6yHCnDikVeh49U
 sK4Vxm2WnzQCq4z9QK8dFmYS2uNh8F6nN9f545y1kWsZx6cDez+Z0dmcX1HsLTTVVzUCHfRGw
 1c25SiCwSQVv/mlMCyoDEsRQvPl5r7NYO4NgtOhLRxFqpdCiB4YJqKRZaG+7wxMPLp21i2VTS
 Ly3H2vLz0f/YS+vyn/aA0m84pD0PJEa2Gp6EqlzSpbu0y1SAoO8lENPhN0TFwaOkXeI5roXLb
 URCyk1/FhDvbvCkLe8cZpxG8h1GpiVOvtrdnrq9c4RItqHjJxSPQrYua+BbC9TX+WBICW9Lc1
 xh/65wNcN6hjpHMkBxQzXqdfezU22fy+8Y9ws/xa0AX0azM4Z99/YUffvUq2fXGEZaj+dKzJU
 V47NLWL8jzkEpgRdmnibOeRT7V3cp8m2BsnBY5JIxoGE0AiAYmRv17zjTGW+pjKwE+Q/3j4mC
 lMVJtINxcv6ukDmsBekqqh/eXeWaNZGEtodrfBYphZLN2bXLDyeXKgwpPdHZJtY2WzsZMR698
 BQQe+JJIxhrG3fsfBezNPwJXAL9X3qzK+EpfsZI/bKS19Hd9W27dxmOFa7lzj9US1CiNrGwQH
 k0epvND
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 18 Jul 2016, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > I will say that the pack format will likely require some changes,
> > because it assumes ...  The reason is that we can't have an
> > unambiguous parse of the current objects if two hash algorithms are in
> > use....  So when we look at a new hash, we need to provide an
> > unambiguous way to know what hash is in use.  The two choices are to
> > either require all object use the new hash, or to extend the objects
> > to include the hash.  Until a couple days ago, I had planned to do the
> > former.  I had not even considered using a multihash approach due to
> > the complexity.
> 
> Objects in Git identify themselves, but once you introduce the second
> hash function (as opposed to replacing the hash function to a new one),
> you would allow people to call the same object by two names.  That has
> interesting implications.
> 
> [...]

So essentially you are saying that the multi-hash approach has too many
negative implications, right? At least that is what I understand.

Looks more and more like we do need to convert repositories wholesale, and
keep a two-way mapping for talking to remote repositories.

Would you concur?

Ciao,
Dscho
