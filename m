From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH resend] Documentation: git-svn: fix example for centralized SVN clone
Date: Fri, 14 Nov 2008 22:30:06 -0800
Message-ID: <20081115062927.GA426@hand.yhbt.net>
References: <20081114184514.6f7d437a@perceptron> <7vljvl7d3k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 07:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Egx-00012c-OM
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 07:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbYKOGaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Nov 2008 01:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbYKOGaH
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 01:30:07 -0500
Received: from hand.yhbt.net ([66.150.188.102]:51583 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228AbYKOGaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 01:30:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 21EE52DC01A;
	Sat, 15 Nov 2008 06:30:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vljvl7d3k.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101050>

Junio C Hamano <gitster@pobox.com> wrote:
> "Jan Kr=FCger" <jk@jk.gs> writes:
>=20
> > The example that tells users how to centralize the effort of the in=
itial
> > git svn clone operation doesn't work properly. It uses rebase but t=
hat
> > only works if HEAD exists. This adds one extra command to create a
> > somewhat sensible HEAD that should work in all cases.
> >
> > Signed-off-by: Jan Kr=FCger <jk@jk.gs>
> > ---
> > When I first sent this one I said I didn't like the solution all th=
at
> > much (it would be nicer to use origin/HEAD but we didn't fetch that=
)
> > but Eric said he thinks it's okay and the original author of the
> > section hasn't piped in. It's still better than a nonfunctional exa=
mple
> > in any case.
>=20
> I'll mark this Acked by Eric and apply to 'maint'.  Thanks, both.

No problem.

I see what happened: I mis-CC-ed Adam as never had him in my aliases
file :x

--=20
Eric Wong
