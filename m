Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D00D1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758117AbcIHHty (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:49:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:62763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752115AbcIHHtw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:49:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LhkiL-1bCzG12kjZ-00mqB9; Thu, 08 Sep 2016 09:49:40
 +0200
Date:   Thu, 8 Sep 2016 09:49:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
In-Reply-To: <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609080933470.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de> <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net> <alpine.DEB.2.20.1609061613270.129229@virtualbox>
 <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9Tu1phLFgzWWmqk/ZQUIIQFynW80jdB/A3gY+e4APdEKF2yMr4x
 yF9gj1Bm1TotdMSqQ6+6i/fCYyFEdlTpmEJu91uUoCJGuL2epB7OSAsBdlBSBsTOs1FKemr
 Z7PxOdtlmL+E3pQgY+bt3pENFRJ+pzxTDIOE+YokGTHEtF1WYoeCzmdPcbNdclRuGvMkkjR
 hD7b8pQgiVUTwNnsHU+ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+OhysxbLYZY=:/3LPtYd3Ovx6tGtH83DRmb
 XKc4nJaeWxx+/w35xrK8SeBchVBZby75O+KvKcdFIuIml4hUJzguP1rLIoJPRF4FrNT/wIJLx
 dxSwjcDfrNtYKeWwBhWdAVSwIHX1xgOjd0zG4ft555cxPVWLZbR9DcxRALH8a7RsgIdefsXlE
 +GReikxyoMfV0Uhs8uvII6bJW3CXr38zFUVouVkPZXTftG1niD3ZrlF5XrrsL523iIt/GNI3j
 lxH1i0IVG/XBhtcEe2lbLIxinC3aY0MYbCGHwhU8dRU8pR1Za7JfxhsNdDTWfVQGvoZE3kXOl
 +zwxkmhtQz+yAELW3n9NlgG8MlJnvIeR+XkoFzgH0fS8NXiUA31NfVJgUkSU8fk9l22hgi0I2
 HMXHYYGQJQTiyxEsuMj3tPJpw8+JyNUFZY8xLNMOo1+LI6DOe5GV0AFnaT4n20oX4XR/mgylz
 ISbiruBDXGae5x8SejIsVUuTsRkJWi6eQHY1+pi/F8atn9KcQyV6moh9n7xGcSLzT5Ggi+SZa
 DXS61U0/vfalD1oZC1v+JI5jHGbIkw6ExOJeMiZDkYTKwLQpV/hFTPZrl3hHriZYYUxG2VnsB
 6inZ4Hs3omOiHlAyYgT1nkW+D3OwAK8BhxYO/yANW158RKNgzmLjEmaE8KCvJxeR7Td7zo2f6
 eqete6MtzabuA9wS2G9YCEV2Qspj1f5shgDPACHwEgHQB5zkzYfuQs7spP6jWDuNBDka9myty
 EVpZFWs2cdsbf3numkC9TKgeNzvQcAqMmFleYCSuPlgtvXosz0AzqUeKdpfGJAJNmGo0Ypnpy
 r0gJjKL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 6 Sep 2016, Jeff King wrote:

> On Tue, Sep 06, 2016 at 06:02:59PM +0200, Johannes Schindelin wrote:
> 
> > It will still be quite tricky, because we have to touch a function that is
> > rather at the bottom of the food chain: diff_populate_filespec() is called
> > from fill_textconv(), which in turn is called from pickaxe_match(), and
> > only pickaxe_match() knows whether we want to call regexec() or not (it
> > depends on its regexp parameter).
> > 
> > Adding a flag to diff_populate_filespec() sounds really reasonable until
> > you see how many call sites fill_textconv() has.
> 
> I was thinking of something quite gross, like a global "switch to using
> slower-but-safer NUL termination" flag (but I agree with Junio's point
> elsewhere that we do not even know if it is "slower").

Urgh.

;-)

> > So now for the better idea.
> > 
> > While I was researching the code for this reply, I hit upon one thing
> > that I never knew existed, introduced in f96e567 (grep: use
> > REG_STARTEND for all matching if available, 2010-05-22). Apparently,
> > NetBSD introduced an extension to regexec() where you can specify
> > buffer boundaries using REG_STARTEND. Which is pretty much what we
> > need.
> 
> Yes, and compat/regex support this, too. My question is whether it is
> portable.

That is only one question.

Another, important question is: is it efficient?

I have no idea whether there exists any hardware-accelerated regex library
out there, maybe even using CUDA (I know that there is some code out there
using SSE to perform LF -> CR/LF conversion, unfortunately it is
intentionally incompatible with GPLv2).

We cannot simply switch everybody and her dog to compat/regex/ just
because we want to avoid a segfault.

> > diff --git a/diff.c b/diff.c
> > index 534c12e..2c5a360 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -951,7 +951,13 @@ static int find_word_boundaries(mmfile_t *buffer,
> > regex_t *word_regex,
> >  {
> >  	if (word_regex && *begin < buffer->size) {
> >  		regmatch_t match[1];
> > -		if (!regexec(word_regex, buffer->ptr + *begin, 1, match,
> > 		0)) {
> > +		int f = 0;
> > +#ifdef REG_STARTEND
> > +		match[0].rm_so = 0;
> > +		match[0].rm_eo = *end - *begin;
> > +		f = REG_STARTEND;
> > +#endif
> > +		if (!regexec(word_regex, buffer->ptr + *begin, 1, match,
> > f)) {

Heh. You introduced the same bug I did. Or maybe you just fetched my
mmap-regexec branch and looked at an intermediate iteration?

The problem with this patch is that *end is uninitialized. I actually
initialized it in my patch, but it was still incorrect. I settled on using
buffer->size - *begin in the end.

> What happens to those poor souls on systems without REG_STARTEND? Do
> they get to keep segfaulting?

Of course not. Those poor souls on systems without REG_STARTEND pay a
little price for that: malloc(); memcpy(); *end = '\0'; ... free();

I think it is worth it: maintenance of the code is much easier that way
than forcing everybody and her dog and her dog's hamster to compat/regex/.

> But I much prefer this approach to copying the data just to add a NUL.

I think it is not worth the burden. The only regex implementation in
semi-widespread use that do not support REG_STARTEND seems to be musl.

I'd rather not spend *so much* effort just to support an obscure platform.
Not when the users of that obscure platform could spend that effort
themselves. And probably won't, because we only copy data to add a NUL on
those platforms when regexec() is called on an mmfile_t.

Better to keep it simple,
Dscho
