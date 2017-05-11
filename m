Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B9F201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756851AbdEKTPA (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:15:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:49607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752505AbdEKTO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 15:14:59 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmazv-1dimfG0cGB-00aIHg; Thu, 11
 May 2017 21:14:53 +0200
Date:   Thu, 11 May 2017 21:14:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] git-parse-remote: fix highly misleading man page
In-Reply-To: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705112109410.146734@virtualbox>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <b26882e61ef466c787b575d3fd60bfeec8a9281a.1494509599.git.johannes.schindelin@gmx.de> <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:X/XuxSfmA1umOL5yaPfFxaaWQzvmdqkoDBtCtQLvg40wfZN9wHx
 Jurf/n6RyXz+oIkRInI15jgOoVtWX6fWFmBes1aK6kRGoIpL9DjYPxIdFYm121zOXLiUFbb
 ZQt+qyNxQ3SCmefLADiE6TnmswQ/RtLKRAtz/vOaxMDSn7OWrbvnPLYm2PCYnBShG3f2Hlx
 /5fMaN5EzlE2I9yuCJl3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AYEEN6Q7Nbs=:K5E/myMB5FMY8P6sJk63th
 zak2rjbDI3CMm9dijYWW8xiJUO7ZRIVCK8hlYOW1bjXXapsq1Xvgx6Y9aiWboeWAGqTkrAQbU
 e5hVHy1cuuvJmJ9V1Kn9Qe18WBnLX3OrlkwFz6yqQO1PhXFpvZfGm0TRYy+sF/FTXpCLyOgjE
 h+USf46aX482rhuEWzbphrt0JaoB7jAeSbPPO1pqL9XEJHchCLSU3zJvTS37ZIQyUwDm9hyxL
 TgK5/CxP6YImBoCCpBe5o3anXLUF/RVlJxfTJ3BJJulH0/qZJyJcGym58KpMGyrO0mOTYsfvA
 eb9kB74h5qqu2tlBee90u/Pm1C1tnP5BuoNkPWktIKUfrRU3tpn4LQ9Or7EEoqq13bWQB6W1A
 cf8arPNUK1BMuqRF4uzH/+Xf6Z6Rq/OXG//XDrjdlAHFYGLCY74/LM/EeJWnVpuKzN2iYlQ18
 ON5zk98uo2CiWxVDNoof3jDPZXXZGuA2Fa13mVMp+hcdP3VLyMVoxTwcoT1GwK3i2FDa56F4D
 BwYfZw4ZH19auP3JH4KGE7UDRije0vKHRljxcu0PqikBo8jFUFKz5i1QA+FTRYkYkxI2340K6
 r/bpNmAxaCfIUOftZjuJuSWhPQmzIj5//KBw2j3xoQBU3UG5DgmaWttKUxPCf3BxtyOxpLBAq
 RJff9XfxQcE2NKBpBZCO+aPx5nUH9HsNCSifXwyakPCBp+NwyJUDB1D8XXIGUUcljAJxWfnib
 uegROOp9GbuiJYpqSBBsu5pe6/6OloMBo/49vY+aQwjJ+Jap+ht8ncu4exgXfnMi+Z+7bf/zO
 5/Nn7gE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,


On Thu, 11 May 2017, Stefan Beller wrote:

> On Thu, May 11, 2017 at 6:47 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The man page still talked about the .git/remotes/ directory (which is
> > no longer in use, as of 75c384efb52 (Do not create $GIT_DIR/remotes/
> > directory anymore., 2006-12-19)).
> >
> > Let's just revamp it almost completely to reflect the *purpose* of
> > that scriptlet, as opposed to its implementation details.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-parse-remote.txt | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
> > index a45ea1ece81..7f865f33898 100644
> > --- a/Documentation/git-parse-remote.txt
> > +++ b/Documentation/git-parse-remote.txt
> > @@ -3,7 +3,7 @@ git-parse-remote(1)
> >
> >  NAME
> >  ----
> > -git-parse-remote - Routines to help parsing remote repository access parameters
> > +git-parse-remote - Routines to help parsing remote repository information
> 
> Today I learned about git-parse-remote. Upon further inspection it is
> just a lib, not anything useful for a user. (The man page with or
> without this patch is not very helpful to me)

Yes, I figured as much when I read the man page. It shows how much most of
our man pages of the olden days improved when you find an unchanged one...

> Only git-rebase as well as git-submodule include this lib, the
> submodules only need get_default_remote (4 lines of sh), which is also
> available in the submodule--helper, we'd just have to expose it and make
> it accessible.
> 
> I wonder if we'd want to retire this script in the long run.

I do not think that we can. Just like git-sh-setup, we advertised it for
use in custom scripts.

> I also wonder if rewriting the man page is good use of (your) time, as
> the last contribution specifically to Documentation/git-parse-remote.txt
> is 62d955fd43 (parse-remote: remove unused functions, 2009-06-12), which
> has been a while since.

1) we still advertise those "shell library files" for consumption in
   users' scripts, so I think we have to keep the man page, too, and

2) The fact that the man page is stale just shows how dearly it is in need
   of being edited, no? ;-)

> The outline in the coverletter promised more than just rewording, but
> I am fine with the change as is; it's a good start.

You mean the commit message (I do not think I talked about the
git-parse-remote man page in the cover letter)?

If so, I think I only promised to completely revamp it and to stop talking
about implementation details...

Ciao,
Dscho
