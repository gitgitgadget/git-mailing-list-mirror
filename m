Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1DAE2070F
	for <e@80x24.org>; Wed,  7 Sep 2016 11:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938610AbcIGLbt (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 07:31:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:57404 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937716AbcIGLbs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 07:31:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0ME33j-1bqcAI1OrH-00HRGr; Wed, 07 Sep 2016 13:31:37
 +0200
Date:   Wed, 7 Sep 2016 13:31:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: Fixup of a fixup not working right
In-Reply-To: <6C5AB39424064692A416A490B861D330@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1609071327290.129229@virtualbox>
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>        <55512A8927384A0790DDC7F526B09053@PhilipOakley> <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1609040923390.129229@virtualbox>
 <8F7471262D1C45D9A7BD1C29277004AD@PhilipOakley> <alpine.DEB.2.20.1609050950130.129229@virtualbox> <6C5AB39424064692A416A490B861D330@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gn/QIlAT/ZaAoxXKekt2a+6QUh8/6PUYUJLuuhgGEdNYO9jiGu9
 nqacRQLGqAY9NsGz3YsRtIz6xNAhm9hJRU+LY+7Vr+7EdOM93bEokvR0e9mo+K7D9ijUha0
 O31dAHCT5PyTuKyWmjpi6HFrC57hTayBAupFr3PFkiTmZwh2BzR+f9Ft6DvjeXM6rkxBQ99
 L51JChClqEth5n7A05IKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1aTqxnvn8Tw=:A+Wx2SplhudCkQzM8pfIWB
 ydCLwlnKP+pfWFrpVBsQZWTKiljivtEnbPRhu1rQT8bj9QbUgrudW0l1AfCN9GqOoAKbmkZkK
 woJ/PcXccUb351xEI+dCy0M4lUdnDmCp0Xj1VLO8U6Cz+UhiMIjPfdKqE7Y25pAxDBtkAMVAk
 neIYM2qJ2GvwdjFer42Y5+1FewsUr/WPq13dKkXxm4g8kdyMwm81zT6Ur49Z4Hfvk2az67Cui
 wZ/+3E6NAXMb1F/HffLq8GBRgTLX4wm81IooOfa2scQrf/WBUGVWYurJ8/q6H6Ui6GNzFBXf2
 Z2vmb+cYBy9DMwBizeISiB/4Xm8eNLlTA8WNsus8qp2PMpYr8Z/z5UOh2z1B2TSA8IFoVocBv
 3e3N938PjDb3Yygg/5zxRrn3YnfSu5ZVNVqxxmdwKWd71jlOt5ijmNZDuyFtU5ILdJyM7rdtU
 Nb3VpiXVzdIknd8DF6ppybMw1pe3dSA4N102uqxvISaRK7d7Xbsp/Hr8OHn44rBUowcw5S6vz
 +fsmaOec8ktwVftp9jQ7lJDcZxJu5+/7ybDVo3Gl/1d/oVYo4usAOn0pq0ro033GoBuVhq9xZ
 HI1Ag1FrXryspCMlQdVmBq6K2avjq6DjgRoz0UMpP7pPZACNSHCl1QsoLGcDXeyRQcDtUMI0P
 nUz+62II3S7gHjnH/xgp9bu8cZ+rFpI+dQ07qClobvw2XDDemwFNLOEDE1XQUaeGBn/zFIFXF
 tgHEWuND7Bt11stjosyubqWjaARJsSXNlE+3yC2sk2HuRFGuL4OymdRniAvaqd00NT9kdpdmI
 thGzpxW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Tue, 6 Sep 2016, Philip Oakley wrote:

> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> >
> > On Sun, 4 Sep 2016, Philip Oakley wrote:
> >
> > > I suspect that some use cases have intermediate repositories that
> > > contain a 'master' branch (it's just a name ;-) that isn't blessed
> > > and golden, e.g. at the team review repo level. In such cases it is
> > > possible for a fixup! to be passed up as part of the review, though
> > > it's not the current norm/expectation.
> >
> > In such a case (which can totally arise when criss-crossing Pull
> > Requests on GitHub, for example, where a Pull Request's purpose may be
> > to fix up commits in another Pull Request before the latter is
> > merged), the most appropriate course of action is... to not reorder
> > the fixup!s prematurely.
> 
> We just need to be careful about that plural just there.
> 
> If it is multiple fixup!s for the same commit, then I believe they should be
> grouped together at the same point as the first fixup! commit (in their
> original order).

We should they be grouped together? In the final rebase (the one that
actually also includes the commit that is to be rewritten), they will be
grouped together anyway.

And it is not like users cannot regroup manually if they choose to perform
an intermediate rebase. In that case, the user will also choose whether
she wants to simply regroup the fixups, or squash them into a single
fixup, too.

> > > > In short, I am opposed to this change.
> > >
> > > It's not like G4W doesn't need fixup!s on the side branches e.g.
> > > 5eaffe9 ("fixup! Handle new t1501 test case properly with MinGW",
> > > 2016-07-12)
> 
> I note that you don't have two fixup!s for that commit

Not for that one, no. But there have been cases where I had to add two or
more fixups for the same commit, in preparation for the next merging
rebase.

> > Yeah, well, Git for Windows' `master` branch is special, in that it is
> > constantly rebased (as "merging rebases", to keep
> > fast-forwardability). I would not necessarily use Git for Windows as a
> > role model in this respect.
> 
> I don't see GfW as 'special', rather as being a representative of a
> broader realpolitik where some of the rugged individualism of open
> source is moderated in some way or another.

Sure, it is an example of a project that needs to solve the problem where
patch series are accumulated, to be submitted to an upstream project, and
so we have to keep fast-forwardability at the same time as we have to
rebase.

But Git for Windows is special in the way it solves the problem. I am not
aware of anybody else performing merging rebases.

Ciao,
Dscho
