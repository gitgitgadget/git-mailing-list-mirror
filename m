Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65311FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 11:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbcLLLDQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 06:03:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:56475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbcLLLDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 06:03:16 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdXSC-1bzzYu0JfY-00PNM6; Mon, 12
 Dec 2016 12:03:08 +0100
Date:   Mon, 12 Dec 2016 12:03:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Klaus Ethgen <Klaus@Ethgen.ch>
cc:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
In-Reply-To: <20161211110208.642unp7c2i653sav@ikki.ethgen.ch>
Message-ID: <alpine.DEB.2.20.1612121133220.23160@virtualbox>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch> <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net> <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org> <20161210093230.26q7fxcrs2cpll6g@ikki.ethgen.ch> <alpine.DEB.2.20.1612101918040.23160@virtualbox>
 <20161211110208.642unp7c2i653sav@ikki.ethgen.ch>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0+B7nEN1Dtqu8Gh4jKwnfKpndx/xrd3x5sSPdVdTKokCvIByZcf
 +38aIrZ6l6QtggPqT0H36YUpS250acAlK0UBdBIe6RJvKzmlYPn9gi2dKR5hzrSqDtdI4K/
 HtUzrtwHSr023A1ODsNwMFjNGDdrIpv6nbgXL1VRQv9iny4meWaLXyVoSghjMe0BWWHhSa1
 do+c3UOu16ubJAbgiK1Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nyqvtvBnttk=:QPAbnSTTAKCBP6LG2bDDir
 srIL5izvZoYwrbnZ2d6cKHQSS5O12HKW/6+iBMSzw5vRZTLdbOHegxSa7DjoqrK1TUcFaT0ap
 rDjk1Ows5LQvypTWIDl0u4b3vvrjZE8yRUZhQGhdC5r08eyG7oT87uGVFp2Xf95CtJdU+F26T
 e6QMQ026r5OJaCyM3dfB+eVmdiMu6yHG39wK8wEUIJiiAP+LI+MEOvd5jelcRqxq/S796NvjZ
 fVRG31joWSozhTx4DCl3pDqx4JwhrqGxPFSsaSKEF2mtSluI3Cx35+BwwLLsHx/86LZzQMyZn
 FZ646glY0RyQwBtPJGYNuOV/8ZWMRLDSKI6+uGXs4z7kHY9K7D7gnjnXWThhK8hSZHt3qDTaJ
 yCKVd/4+QWWIIvU4YmueocmlqzTPAuwOPPi8xHSyxly+kE5XK4/BeVHm8znXtN3sBtrX9mM9Z
 CRFyS/PsDYgpLIgPSPYRBC4c8UhKEbRbtySLqS48egq6QeX14cfOhV5nyKI9cAE96rOHt3ri5
 aywdUHH94djWKGiq4CFKbXrC9oKy2lOvoEUgeZKamVwiBASGDPPnLLJlRcq1q6vChQpM7z6Xc
 eWR8uiyqVb7ZgYlo03L0QyVpSud3y0yD9sdqYef5dtkQHRg5gV61vwYDD6mi6ozWCypG42JIC
 VhWZDyRKK1qha3INV5B2brqlkSisBFCo+W+yKdw3g9Ig/ETfGAgctOO8bpnjo82kmpJ2KDbv5
 jz40/+rBNgQNEusj2drPN/Ck0Vd7oUXp1b0w5P+yWSlnwRjypfqlr69nm/OggouEcKTKEWd/S
 EyqP0cj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Klaus,

On Sun, 11 Dec 2016, Klaus Ethgen wrote:

> Am Sa den 10. Dez 2016 um 19:18 schrieb Johannes Schindelin:
> > On Sat, 10 Dec 2016, Klaus Ethgen wrote:
> > > Am Fr den  9. Dez 2016 um 22:32 schrieb Johannes Sixt:
> > > > There are too many systems out there that use a backslash in path names. I
> > > > don't think it is wise to use it also as the quoting character.
> > > Well, the minority, I believe. And only the minority where the command
> > > line git is used anywhere.
> > 
> > Please provide evidence for such bold assumptions.
> 
> How is it "bold" to see that the majority of widows users does not use
> or even like command line tools.

First of all, it is "Windows users", not "widows users", unless, of
course, you want to discuss things that are completely inappropriate for
this list.

Second, you still did not back up your claim with anything resembling
evidence, instead just reiterating your beliefs. That is not good enough.

Third, my experience contradicts your beliefs rather violently.

So let's try some evidence for a change: the 64-bit installer of Git for
Windows v2.10.2 was downloaded over 1.25 million times. That is not a
negligible number.  If you want to go back to v2.8.1, it is even 3.8
million downloads. That is a tall number to call a minority.

Now let's look at your claim that Windows users do not use the
command-line. The mere existence of posh-git (Powershell bindings for Git)
is already a contradiction to that claim.

Even if that was not enough, the Git for Windows bug tracker is full of
reports of users who clearly use the command-line.

And there is more evidence: When comparing the download numbers of the
different Git for Windows versions, one thing really sticks out: those
versions were downloaded the most (by a factor of more than 2x over the
other versions) which were made available through Visual Studio's
"Download command-line Git tools" feature, e.g. v2.8.1 and v2.9.0. That is
a rather strong indicator that users wanted to use the command-line.

Fourth, even if Windows users were the minority, and even if Windows users
were not using the command-line, which are claims soundly refuted by the
evidence I presented above, the fact alone that you are talking about
putting a group of people at a disadvantage based merely on your belief
that they are in a minority should not inform us, the Git developers, on
any kind of policy decision.

We will not intentionally break Git usage, or make Git usage hard, for
a specific group of Git users, unless there are technical reasons to
do that. Demographic reasons do not count.

For example, we will not make Git hard to use for female programmers,
on the grounds that they currently constitute a minority.

> I know companies where the "developers" doesn't even know of the
> existent of a git command line use. They look with owe when they see
> that I use a shell to use git.

I must have spoken to hundreds of Git for Windows users, and must have
been in communication with many more via email or bug tracker, and I
cannot recall a single one who used Git without using the command-line.

Note: I do not count my personal experience here as evidence, but the
numbers alone are a strong indicator to me that your argument has a pretty
weak foundation.

Ciao,
Johannes

P.S.: Maybe reply-to-all in the future; it is the custom on this here
mailing list.
