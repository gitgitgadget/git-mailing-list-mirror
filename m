Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1671FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 20:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754008AbdBIU5K (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 15:57:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:56269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751440AbdBIU5J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 15:57:09 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqQzp-1byS943gnZ-00e41R; Thu, 09
 Feb 2017 21:56:04 +0100
Date:   Thu, 9 Feb 2017 21:55:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
In-Reply-To: <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702092142020.3496@virtualbox>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com> <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GqNIcV9KsdXjiV4UqdOZFFakxKVoll4wMk/XNqPHecC8tqy9r+p
 L7ZYAPdhqCpPuIl2YWkbnF4XeQCaVSGGG3AKXxE+ADZMZ+wtUaOqfpLS80kmECAZj7LuVF+
 VF2qWTehHlZK7w1SF+FH742Hexo2UURhzrHJE+ituVFAx4IL4f38o4zwCqRwcvtD0cRAuMu
 knKz9YQwIh7fDCpY6/WEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kS3VRkq2H10=:CM+n5NqRdKzwiHj3i1nzJN
 BEME3SyVDe3h9fMnqAAQS9DS3+gAkS4Xrp7k84h3k+uayiYrUZxBJdbfDZzEQJaFTYMb022Pg
 osevOEE7lLPrJ7FB4mLsTWsGaCV8t28wSP93ImnDWvbeQOO5r//+1f2u2Eaew7KyAiwgZZ1Pf
 aTl9LZpkVLSs7olDkSDYV11ASLbFitu04b/gru6SZZRpKM6BoSkBNh39mMTAS8ytvV0DDGPYc
 3OOQNqgT8B21TDEfw0Dfn5z01hmTHdxAmiOknNJ943Nw5TlNVm55TpFNnGQ80IqhUBXZ0euQP
 U1AwnEd2RTpzc65pkHGBxQ0k9IOC7qmS0gMFppaCCoMVC1Dsu8SZDuZ313mWTIFw/WnZ6EwFT
 UB9DJZFm+7iE38L+JTmoqpln4i52oRGq+j3Z8ThQim3nt3GpEq3x54fj+HHoTK+ZYUpyi53lF
 YZW7SIU4L6r1xnAUUah1T4VHpeBafBlVMIF5m5zOXv45QSzR65y9GuN6VlMJkoJX/Dz2siXvi
 kpbRLoBL02OdQKTMs93SFh/xOIoIkdAprarhZbdcoujbrBvUl+O4NGgVFK7hiTl1zAVkwiujq
 EclWXGfsPl3hnvt2HtRXN5N6M1V2s9iw/K0cV57fzb3a9JxWwDr0ke8+ZTpUJnTjADaWXAds1
 xUNjHRgLhAmS645hqyBwsXIjdmCl1MqmCz2BMaLLi9nvG/o+/S4VZMZa6ziQKai30h/C07F6Y
 u3XIggo0K1BW8fs0gcXEXcnqOe8pad00HjvjopFhUvKfc1fwbbdvdcdyn7YNGQ1boTGlYD9D1
 6JfcRGW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ashutosh and Junio,

On Wed, 8 Feb 2017, Junio C Hamano wrote:

> Ashutosh Bapat <ashutosh.bapat@enterprisedb.com> writes:
> 
> > I have been using git rebase heavily these days and seem to have found
> > a bug.
> >
> > If there are two commit messages which have same prefix e.g.
> > yyyyyy This is prefix
> > xxxxxx This is prefix and message
> >
> > xxxxxx comitted before yyyyyy
> >
> > Now I commit a fixup to yyyyyy using git commit --fixup yyyyyy
> > zzzzzz fixup! This is prefix
> >
> > When I run git rebase -i --autosquash, the script it shows me looks like
> > pick xxxxxx This is prefix and message
> > fixup zzzzzz fixup! This is prefix
> > pick yyyyyy This is prefix
> >
> > I think the correct order is
> > pick xxxxxx This is prefix and message
> > pick yyyyyy This is prefix
> > fixup zzzzzz fixup! This is prefix
> >
> > Is that right?
> 
> [...]
> 
> Unfortunately, "rebase -i --autosquash" reorders the entries by
> identifying the commit by its title, and it goes with prefix match so
> that fix-up commits created without using --fixup option but manually
> records the title's prefix substring can also work.  

This prefix match also happens to introduce a serious performance problem,
which is why I "fixed" this issue in the rebase--helper already (which is
the case if you are using Git for Windows, whose master branch builds on
Linux and MacOSX as well). I quoted "fix" because my motivation was to fix
the performance problem, not the "incorrect match" problem.

The rebase--helper code (specifically, the patch moving autosquash logic
into it: https://github.com/dscho/git/commit/7d0831637f) tries to match
exact onelines first, and falls back to prefix matching only after that.

Now that the sequencer-i patch series is in `master`, the next step is to
send the patch series introducing the rebase--helper. The patch series
including the fix discussed above relies on that one. Meaning that it will
take a while to get through the mill.

So please do not hold your breath until this feature/fix hits an official
Git version. If you need it[*1*] faster, feel free to build Git for
Windows' master and run with that for a while.

Ciao,
Johannes

Footnote: By "it" I mean "the feature/fix", not "an official Git version"
nor "your breath".
