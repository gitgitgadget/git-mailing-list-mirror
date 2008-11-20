From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git.pm
Date: Thu, 20 Nov 2008 09:34:46 +0100
Message-ID: <20081120083446.GF10544@machine.or.cz>
References: <200811191856.44252.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: nadim khemir <nadim@khemir.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 09:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L351A-0002Bw-Jh
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 09:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbYKTIet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2008 03:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbYKTIet
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 03:34:49 -0500
Received: from w241.dkm.cz ([62.24.88.241]:52088 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943AbYKTIes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 03:34:48 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 497D239395F8; Thu, 20 Nov 2008 09:34:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200811191856.44252.nadim@khemir.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101390>

  Hi,

On Wed, Nov 19, 2008 at 06:56:44PM +0100, nadim khemir wrote:
> Hi, I'm new on this mailing list and quite new to git too. I named on=
 irc that=20
> I develop mainly in Perl (http://search.cpan.org/~nkh/) when I do ope=
n=20
> source. I heard that Git.pm needed some love and I can take over its=20
> maintenance if there are things that need to be done.
>=20
> I need to know:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0- what needs to be done
> =A0=A0=A0=A0=A0=A0=A0=A0- who was doing maintenanace before
> =A0=A0=A0=A0=A0=A0=A0=A0- how do you want to release it (perl modules=
 are best placed on CPAN=20
> (too))
> =A0=A0=A0=A0=A0=A0=A0=A0- what (and who) is depending on Git.pm
> =A0=A0=A0=A0=A0=A0=A0=A0- what would be expected of me

  I know it's quite some time since you wrote this mail originally -
have you read the Lea's thread I have recommended? What is your current
plan?

  I think the current rough consensus in the Git community is to go wit=
h
Lea's design and implementation after extending it with a nice way to
run arbitrary Git commands. This is also desirable since then we can us=
e
her patches to make gitweb use Git.pm.

--=20
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
