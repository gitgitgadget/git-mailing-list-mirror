From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 7 Feb 2011 00:19:14 +0100
Message-ID: <20110206231914.GA8147@neumann>
References: <4D4DEDC4.4080708@hartwork.org>
	<20110206051333.GA3458@sigill.intra.peff.net>
	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Pipping <webmaster@hartwork.org>,
	Jeff King <peff@peff.net>, Git ML <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 07 00:19:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmDt7-0006S9-C7
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 00:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1BFXTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 18:19:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:60906 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab1BFXTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 18:19:20 -0500
Received: from localhost6.localdomain6 (p5B13100E.dip0.t-ipconnect.de [91.19.16.14])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M8JwA-1Q7thJ3PAQ-00w19d; Mon, 07 Feb 2011 00:19:16 +0100
Content-Disposition: inline
In-Reply-To: <vpq1v3kopn3.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:cmE1DWQSl8/74ikiOuCM/xRAbB+VyH+LZPznbjugQ6/
 Fm41HHBaU//KaeWgJcj2//LUdFok5Ey0nVnQfvmaKhQxvQ/SlW
 TZinmfIDgN8T7So0nVV801bSbpWYfm7gVWYUi1KzFtK1Tu86NH
 r75oeDEMi4ls7TZfmjBsz4fX1OAftCk5/rCH2DS4Uj8DawWGQ1
 SUIZTbjYQyljeA2icQ23Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166212>

On Sun, Feb 06, 2011 at 09:48:48PM +0100, Matthieu Moy wrote:
> Sebastian Pipping <webmaster@hartwork.org> writes:
> > Is that behavior needed to be as is or could you change it to work =
from
> > everywhere?
>=20
> I consider it as a design bug that "add -u" is not tree-wide, but it'=
s
> not easy to change the existing behavior without breaking expectation=
s
> of people used to the current behavior.

And others are bitten by it every once in a while.  Yes, myself
included ;)  Maybe this is also one of those things that might be
reconsidered for 1.8.0?

> > Could it be it has been working from anywhere before?
>=20
> Can you post an example where Git 1.7.4 and a previous version behave
> differently? Up to now, I see difference between your expectations an=
d
> what Git does, but not between new and old versions.

git add -u was tree-wide when it was introduced in dfdac5d (git-add
-u: match the index with working tree., 2007-04-20), but 2ed2c22
(git-add -u paths... now works from subdirectory, 2007-08-16) broke it
while fixing something related.


Best,
G=E1bor
