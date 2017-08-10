Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C966620899
	for <e@80x24.org>; Thu, 10 Aug 2017 09:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdHJJgy (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 05:36:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:64572 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdHJJgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 05:36:52 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1BMy-1dM8fr3PAG-00t97a; Thu, 10
 Aug 2017 11:36:43 +0200
Date:   Thu, 10 Aug 2017 11:36:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
In-Reply-To: <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1708101111080.11175@virtualbox>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net> <alpine.DEB.2.21.1.1708092337350.11175@virtualbox> <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vcVURqwHFM5FIhRaYUw7c8w3125pLmIuQDelQXvxXcQyQijGwqN
 R4yp5tdE9k/3t5h+A0qxVLu5aqtNEeIIrelCBEm9cyFyUnGxezgt4h8iZ5TlY1K8nMwPFVB
 O+Oe7QUfgChb9YD3EplUxzq0FwOkbCPNA+E1UjJUt5cVfScqlXI29t1beLUTtw4iaxu0TG0
 zxmvPh9OUCUrAe1nJ87zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ADQtuQNzSLU=:h8geQWU6Yx1W8lmNpwJ9+G
 b/TKvQPnMVRBJAm/4IfaqMbCxIXvdR9tS06MGvU4bviXEQxz083PtyPq0DGWziFt+Gmxt7qeK
 LK2LukoWYbFPPTQSdclQq/ebDJZWTIJ5NCA6ADubZnIWDcUGg6KSky+q8VX4n/YQ6jhvc6w7W
 5qWewLjxM8zpKfjzBWLQZjM4/OOMPn4/kX/0ah+2p6It8PM6wzHL1UvC7rPpLRRL/c+oPq50I
 xRo3P/uQVE39/pt4kicEDIHt2Yr/9vxAV3Q+y1w+34AIdqrYFZpebkZGV7By/Tbtoztds803+
 v0hCZV33hkDVBBaooNjpk+/HlQWH0/OAHxpE2our7ITTKVkwuXv4RAcFvwFN8OjNIL+2wRXo2
 1bZltowuZbKL1srlkEYFZmx1gpYQlrgPT/FxiTedbi55tGLr988/tne9M3J0GLYsR6w45I/zO
 uI6PkdC0kaba8KVMDedqQ7jB2wOy/WN+v9jLQU/R+cbrwCU63GrllgbNGycHKGHGwFOjMcKjr
 IKng4CSNMgKuoXNvAyFSqp6jdGSA0Xivr8rpNmrRmf8Zeo+X+IJ997T3BYu5g8ikw8cBPJq2N
 t2TQsGapADULY+TIfGrZI9lVgxdH9Qs5TyqfsrKOFKfTxU1F+wUYMQgPw1YplrLdSGcfDpH1N
 r4YRJ4fZagN+hpOlSPAl2gNNP49nokYEDmJJEIRJv+nR9c/UHl4krsRV0XFYJYqii//w7xA6E
 9jxDSk9iBR0d7jdgrigSuzAXb7ROm0kurOkf/SXUtvk6GeslYaxLXdkDbTUXlAOX/Ku/IKYi3
 OO0xssUCKUzE6xzjYBCMpnyOeE9oObVcr4kNO+JP4/1tTbF4s8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 9 Aug 2017, Jeff King wrote:

> On Wed, Aug 09, 2017 at 11:42:12PM +0200, Johannes Schindelin wrote:
> 
> > > This is a resurrection of the thread from April:
> > > 
> > >   https://public-inbox.org/git/20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net/
> > 
> > As before, I would like to point out that people running with older cURL
> > are most likely not at liberty to change the system libraries.
> > 
> > I know that I didn't when I was working on a very expensive microscope
> > whose only certified control computer ran a very old version of CentOS,
> > and I really needed to install Git on it.
> > 
> > In such a case, it is often preferable to be able to build against an old
> > cURL -- even if some of the fancier features might be broken, and even if
> > some minor compile errors need to be fixed.
> > 
> > I know I was happy to compile Git against an ancient cURL back then.
> > 
> > Just so you understand where I come from when I would like to caution
> > against dropping support for older cURL unless it *really* adds an
> > *enormous* amount of maintenance burden.
> > 
> > I mean, if we even go out of our way to support the completely outdated
> > and obsolete .git/branches/ for what is likely a single user, it may not
> > be the worst to keep those couple of #ifdef guards to keep at least
> > nominal support for older cURLs?
> 
> You've totally ignored the argument I made back then[1], and which I
> reiterated in this thread. So I'll say it one more time: the more
> compelling reason is not the #ifdefs, but the fact that the older
> versions are totally untested.  In fact, they do not even compile, and
> yet I have not seen any patches to fix that.

Let me re-quote from above:

> > In such a case, it is often preferable to be able to build against an
> > old cURL -- even if some of the fancier features might be broken, and
> > even if some minor compile errors need to be fixed.

As far as I remember, I *did* have to fix a minor compile error.  Took
something like 15 minutes from first compile error to fully running test
suite.

Compare that effort to the effort of compiling a current cURL, possibly
having to compile newer c-ares, spdylay, jansson, nghttp2, openssl,
nettle, libunistring, libtasn1, libidn, libmetalink, rtmpdump and whatever
else.

> So IMHO this is about being honest with users about which versions we
> _actually_ support.

We will most likely never, ever have a fully 100% bug free system. That
does not mean that we should rip out everything that is not totally,
completely working.

Instead, we try [*1*] to welcome patches.

I can buy some argument like: this support is so invasive, so brittle, and
nobody takes care of it, and if it breaks, it is hard to fix, and those
who could, won't, so let's remove it.

That argument is why Git for Windows dropped XP support.

I cannot buy the argument: there are a dozen #ifdefs and I don't know
whether they still work. I don't know whether anybody (who most likely has
better things to do than read the Git mailing list) is still using those.
So let's just remove them.

That argument was what let us go overboard, and actually go too far by
removing the fallback when REG_STARTEND is missing, even while fixing a
very real bug. And that overzealous action hurt users. It also cost *us*
time, having to deal with the ensuing conversation, but we deserved to be
paying for this, the users didn't.

I did not have time to look closely over your patches to remove cURL
support for older versions. From a cursory look, I did not get the
impression that there is a lot of maintenance burden there, though.
Therefore, I currently believe that the downsides of removing the support
outweigh the benefits.

Mind, I agree that cURL should be upgrade to version 7.55.0 wherever
possible. But it is a huge mistake to assume that everybody who wants to
build, or just use, Git is at liberty to perform that upgrade in their
setup. To make that assumption is really harmful to users who are stuck in
a bad place out of no fault of their own. It is also not very nice.

Hopefully I had better luck expressing my concerns this time?

Ciao,
Dscho

Footnote *1*: It is no secret that I find our patch submission less than
inviting. Granted, *I* use it. *I* did not have problems entering the
mailing list. But then, my mails were not swallowed silently, because my
mail program does not send HTML by default. And prepared by the German
school system (I learned the term "sugar coating" only when exposed to
some US culture), I had little emotional problems with being criticized
and not thanked for my contribution, I persisted nevertheless. The opinion
that the Git contribution process is a lot less inviting than it could be
is not only my view, by the way. I hear this a lot. I give you that we are
not quite as textbook "keep out from here unless you look like us, smell
like us, talk like us, have the same genital setup like us" as the Linux
kernel mailing list, but we are in a different universe compared to, say,
the Drupal community. And their universe is a lot nicer to live in.
