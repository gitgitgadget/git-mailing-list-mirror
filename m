Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3836B1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJXRGD (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:06:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:58029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbeJXRGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:06:03 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpPg1-1fdA6n2aTF-00f9Zj; Wed, 24
 Oct 2018 10:38:40 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpPg1-1fdA6n2aTF-00f9Zj; Wed, 24
 Oct 2018 10:38:40 +0200
Date:   Wed, 24 Oct 2018 10:38:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] repack: point out a bug handling stale shallow
 info
In-Reply-To: <nycvar.QRO.7.76.6.1810241004440.4546@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1810241033420.4546@tvgsbejvaqbjf.bet>
References: <pull.9.v2.git.gitgitgadget@gmail.com> <pull.9.v3.git.gitgitgadget@gmail.com> <ed8559b91b7a3b51a5950d62e78fc726ed5b44c2.1540245934.git.gitgitgadget@gmail.com> <xmqqr2ggovxk.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1810241004440.4546@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QNT0YnU1ScOJWJ0W6ACNUu2tmY2OMWIRYjCb2okHubCuKgFlP8p
 gI/E8F++fsYd8xa1UkSEs0RY6iSBxIiBk/nCXs186Ohx9SNz4P9m7aaQJcanE/+M6hKMLgl
 K+4iHqSKUztPBqc6rSj4RmCnbLXAuNkwpyaJ2i5DwcBqhNED58ttzhgwwD3Pdj0or5dErwW
 eLgL4MttsK8yc1IiW6wsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eg2CZQD94uI=:5u/3Kh79BsRPyahYnsLyCA
 iRAQnoTNtp0xTITMcLwEPIKF9WZFPpx1CwIEZKgP0DIV7IBfpOelHH5WoSkgWHmDVyIf+2OL3
 webgkNhri1uvsXjuRT+8ydf2+kI3WBQCLIzADjb8Lhga29cyyxDGS0tRKMMkowUQ8cI/vr+L3
 7JNjCG4SggeIX3+Cw0z0PAlmhLH3mpqnOKHI62ITJMASMOlS35nZlVf5cSdmnUCrHAk+cuqRL
 KZXpCIy1K0aRVt0FopbSIJgylE9+TpPNzLuHL86gfe5pWl3OkpE2cTObolBPemEwQFqvSUGNC
 QJtLcqLmbIaVuW7Uz1n85jLkPlOZ0SnSvL/plUo0+TyJkyH5WVoVBVGK1kzPsPvnjy890Smx8
 RTj+AbYGGDJYcij9Y392GpalMl8X7CS08BHCtpY3xiMugwAO0nSWOx9Ll8UvVlV7FHrS4g/eZ
 1ih0O1m/CTXIo61KnYMf9bQ9CWnYCan5faHh57edu3HUkjrCXPNgdY9ensVxIcnVwFJdMgOVv
 ZpFKXeFk70MnNCF6jca3siKBSCMC7Wuhd8sJ7+AU6SHj/PrmpVP2CLxGDeD6gBG6yMzjAiT4x
 1QizOfcP/LgJz5yKhDqJacCljrRexipmBDr9m5he3/cmO/8oe9m0pMFCH9dCHNp3ssLbeDiFp
 OC1YpFTE98jERHHb10nye+Z6UYl4Za0BjxXC52EmH5RHZJ3Tx3WVq2jAJrw8f5jPqp5RyLE4h
 fmxBQvuuW0kFxOAe1rRT03XdfVXUyrGb6uflfwWAX84IX8irShrz224DF6eamiL3490KnhO+D
 HZlC5CjfbJsxLW+nm+W2F3H/7D3bdLBuvwXLHJrpvVCyRM1PVA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

me again. I was wrong.

On Wed, 24 Oct 2018, Johannes Schindelin wrote:

> On Wed, 24 Oct 2018, Junio C Hamano wrote:
> 
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > 
> > > +...
> > > +	d="$(git -C shallow-server rev-parse --verify D)" &&
> > > +	git -C shallow-server checkout master &&
> > > +
> > > +...
> > > +	! grep $d shallow-client/.git/shallow &&
> > 
> > We know D (and $d) is not a tag,
> 
> Actually, it is... the `test_commit D` creates that tag, and that is what
> I use here.
> 
> > but perhaps the place that assigns to $d (way above) can do the
> > rev-parse of D^0, not D, to make it more clear what is going on,
> > especially given that...
> 
> ... that the `grep` really wants to test for the absence of the *commit*,
> not the *tag* in .git/shallow?
> 
> Yes, you are right ;-)
> 
> So why did my test do the right thing, if it looked at a tag, but did not
> dereference it via ^0? The answer is: the `test_commit` function creates
> light-weight tags, i.e. no tag objects. And therefore, the $d^0 you found
> below, that's just confusing.

What I was referring to was the call

	test_must_fail git -C shallow-client rev-parse --verify $d^0

However, here we *have* to append ^0, otherwise `rev-parse --verify` will
(and quite confusingly so) *succeed*. I *repeatedly* fall into that trap
that `git rev-parse --verify 0000000000000000000000000000000000000000`
will succeed. Why? Because that is a valid 40-digit hex string. Not
because the object exists. Because it does not.

So I managed to confuse myself again into believing that I only need to
append ^0 to the earlier rev-parse call, but can remove it from this one,
when in reality, I have to append it to both. In the first case, to avoid
having to think about dereferencing a tag, in the second case, to force
rev-parse to look for the object.

Ciao,
Dscho

> 
> I will change it so that the `rev-parse` call uses ^0 (even if it is
> technically not necessary), to avoid said confusion.
> 
> Thanks,
> Dscho
> 
> > 
> > > +	git -C shallow-server branch branch-orig D^0 &&
> > 
> > ... this does that D^0 thing here to makes us wonder if D needs
> > unwrapping before using it as a commit (not commit-ish). 
> > 
> > If we did so, we could use $d here instead of D^0.
> > 
> > > +	git -C shallow-client fetch --prune --depth=2 \
> > > +		origin "+refs/heads/*:refs/remotes/origin/*"
> > > +'
> > > +
> > >  . "$TEST_DIRECTORY"/lib-httpd.sh
> > >  start_httpd
> > 
> > 
> 
