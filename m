From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Reinstate the old behaviour when GIT_DIR is set and GIT_WORK_TREE is unset
Date: Fri, 10 Aug 2007 13:28:21 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070810112821.GA11026@informatik.uni-freiburg.de>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site> <20070809223530.GA29680@cassiopeia> <Pine.LNX.4.64.0708100129200.21857@racer.site> <7vd4xww6mr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708100210280.21857@racer.site> <7vr6mbu8iv.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 13:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJSfi-0002jC-6c
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 13:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbXHJL2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 10 Aug 2007 07:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757565AbXHJL2g
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 07:28:36 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:37094 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757030AbXHJL2f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 07:28:35 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IJSfS-0000uA-E0; Fri, 10 Aug 2007 13:28:34 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7ABSTgL011438;
	Fri, 10 Aug 2007 13:28:29 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7ABSLs6011436;
	Fri, 10 Aug 2007 13:28:21 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6mbu8iv.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55530>

Hello Junio,

Junio C Hamano wrote:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date: Sun, 5 Aug 2007 14:12:53 +0100
>=20
> The old behaviour was to unilaterally default to the cwd is the work =
tree
> when GIT_DIR was set, but GIT_WORK_TREE wasn't, no matter if we are i=
nside
> the GIT_DIR, or if GIT_DIR is actually something like ../../../.git.
>=20
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
>  Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
>  > I think I sent a patch for that, but was negative about it, even i=
f I=20
>  > promised not to question your decision.
>=20
>  Yes you did.  Here is a refresher with an affected test
>  adjusted.
>=20
>  We already have a few changes that worked around the semantics
>  change by either setting GIT_WORK_TREE or cd'ing up, but I
>  think they should not need to be reverted.
>=20
>  It makes more sense to keep the old semantics -- people who use
>  unusual GIT_DIR setting should know what they are doing, and
>  the new GIT_WORK_TREE feature (and core.worktree) would give
>  them better control.  We just should not break existing users
>  that set GIT_DIR and nothing else.  Which means I need another
>  rewrite on the Release Notes, and probably yet another rc
>  cycle.

I don't know if you planed to make=20

	git checkout-index --prefix=3D/tmp/tra -a

work (again) in a bare repo.  Probably not, so it's no surprise that it
still doesn't work.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

cat /*dev/null; echo 'Hello World!';
cat > /dev/null <<*/=20
() { } int main() { printf("Hello World!\n");}
/* */
