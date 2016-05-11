From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: syntax error in git-rebase while running t34* tests
Date: Wed, 11 May 2016 15:28:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605111518470.4092@virtualbox>
References: <CALR6jEiF9Ooi1f0O3KG0wYmN0KRWBQTNarXx79-wBD2E-8q2jA@mail.gmail.com> <xmqq60ulpw1s.fsf@gitster.mtv.corp.google.com> <20160510204758.GB19958@sigill.intra.peff.net> <xmqqy47hmy6z.fsf@gitster.mtv.corp.google.com>
 <20160510210709.GD19958@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 11 15:29:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0UCD-00055B-M8
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbcEKN26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:28:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:51275 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbcEKN25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:28:57 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lkwpt-1baeHp11V7-00ajb9; Wed, 11 May 2016 15:28:36
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160510210709.GD19958@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EAi42JVFSLw4qcnCecHZl6uFHm9nVtLTdiuA5skYDCCfAeayz50
 KWAin943vcmhJ7uhB3+R4l+ilIyMBPV3veO9QVEsNjdchGMAi6MwCYlYXUOaHu3sCXzrpBf
 Z2dxz5noUDz91XLoaTBXjZ78TGDi5+zzlPrU5xo+4DhXDkkC9j3EfshaPm5fbJO0THhFEYu
 4bLENGuYRKUyOrb4YUrww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vFqqanFBvCk=:czBHZPbn4JiquXcECzaPDL
 tuXCuwQNwGxOwNvC0LR56yh9k+PeE8PxYa6WPbkGrRlfHlyP07zRSuK7/gzIK/YUOGLPPF8cU
 WSlkX7HCIqTgcDEp4gwUEwnW1jaWTluuUXBEzAF/JEDiq/SIarD46llVT16lykw83LKEV8kQz
 xLCCVuy69KXz4X0ZSfzoHDifa/+prhgqe+qodnKkGTpvSpD31lSML+pgUXJZlXx5jm7NOihar
 YXBFfBUN9t94+QvsfQI4NWzmmVNwCPYWE7mY3NCQ2DosGgEcEy/WwLVKS8pYkz3DZa/lS7MvU
 DtwPcFWWbdEgsTAC+Qr8pbrlQEyBXbA3HAI+KPyt6B8bmUvZufA0e2SRC1Cxao//4/avtmtn3
 IHi9SLOpy/c3/eU0orr7eSgGBQQoTnqj6nZ8hU8Qn1xZ0HjhIG16aNzk3LZHjhc9ugHMTnYy6
 vncblCxcn6qPbNYX87gBaAASVNOvLi5edbdTCfrsiKr7yRLiETOVpoA+QuEtjekkWYK3ttFe0
 ZpO7oKipSUTBwK5v5OcSY/DujPqm/t8n/wj7om4jjx+eaNRpuhlZDEkaHoC1xpNDYxgc/Llai
 3kJG4QOAW0j8se0f3V9E2fI3lyDiUjE3m490Xt0moKw+oftniu17HwLxcfivYOa7dZdyp+X9V
 LphoOnkfmDDum/8Plgd3IKsCOi1UGohCDzSIJrR+WIgUgl66H/mvyG3yEcMgOZPHYAlG4QTb5
 9KgSTdetP81Ya/Rn1DdUkBKfbaTJDpUAqAypcVIekB0YVFeQzmjyx1f6lh70QWFIPJqpI+k5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294341>

Hi,

On Tue, 10 May 2016, Jeff King wrote:

> On Tue, May 10, 2016 at 01:53:56PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > I think it is clear why it works. If $strategy_opts is empty, then the
> > > code we generate looks like:
> > >
> > >   for strategy_opt in
> > >   do
> > >           ...
> > >   done
> > 
> > Ah, of course.  Thanks.
> 
> Here it is as a patch and commit message.
> 
> -- >8 --
> Subject: [PATCH] rebase--interactive: avoid empty list in shell for-loop
> 
> The $strategy_opts variable contains a space-separated list
> of strategy options, each individually shell-quoted. To loop
> over each, we "unwrap" them by doing an eval like:
> 
>   eval '
>     for opt in '"$strategy_opts"'
>     do
>        ...
>     done
>   '
> 
> Note the quoting that means we expand $strategy_opts inline
> in the code to be evaluated (which is the right thing
> because we want the IFS-split and de-quoting). If the
> variable is empty, however, we ask the shell to eval the
> following code:
> 
>   for opt in
>   do
>      ...
>   done
> 
> without anything between "in" and "do".  Most modern shells
> are happy to treat that like a noop, but reportedly ksh88 on
> AIX considers it a syntax error. So let's catch the case
> that the variable is empty and skip the eval altogether
> (since we know the loop would be a noop anyway).
> 
> Reported-by: Armin Kunaschik <megabreit@googlemail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-rebase--interactive.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 9ea3075..1c6dfb6 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -82,6 +82,7 @@ rewritten_pending="$state_dir"/rewritten-pending
>  cr=$(printf "\015")
>  
>  strategy_args=${strategy:+--strategy=$strategy}
> +test -n "$strategy_opts" &&
>  eval '
>  	for strategy_opt in '"$strategy_opts"'
>  	do

Looks obviously correct to me.

I had a look at our other shell scripts and it looks as if there is only
one more candidate for this issue: git-bisect.sh has a couple of 'for arg
in "$@"' constructs. But from a cursory look, it appears that none of
these "$@" can be empty lists because at least one parameter is passed to
those functions (check_expected_revs() is only called from bisect_state()
with 1 or 2 parameters, bisect_skip() makes no sense without parameters,
and bisect_state() has another for loop if it got 2 parameters).

So I think we're fine.

Ciao,
Dscho
