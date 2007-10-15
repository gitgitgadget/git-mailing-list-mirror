From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: .gitignore and svn:ignore [WAS: git-svn and submodules]
Date: Mon, 15 Oct 2007 11:14:05 -0400
Message-ID: <20071015151405.GA1655@pe.Belkin>
References: <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <20071015144513.GB7351@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Eric Wong <normalperson@yhbt.net>,
	git list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 17:26:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhReY-0004gD-8m
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 17:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552AbXJOPOJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2007 11:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757582AbXJOPOJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 11:14:09 -0400
Received: from eastrmmtao102.cox.net ([68.230.240.8]:45486 "EHLO
	eastrmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757948AbXJOPOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 11:14:07 -0400
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071015151407.DIXN3884.eastrmmtao102.cox.net@eastrmimpo01.cox.net>;
          Mon, 15 Oct 2007 11:14:07 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo01.cox.net with bizsmtp
	id 0fE51Y00U0epFYL0000000; Mon, 15 Oct 2007 11:14:06 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1IhRdt-0000R8-VY; Mon, 15 Oct 2007 11:14:05 -0400
Content-Disposition: inline
In-Reply-To: <20071015144513.GB7351@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61007>

On Mon, Oct 15, 2007 at 04:45:13PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-10-15 09:07:21 +0200, Benoit SIGOURE wrote:
>=20
> >   - git svn create-ignore (to create one .gitignore per directory
> > from the svn:ignore properties. This has the disadvantage of
> > committing the .gitignore during the next dcommit,
>=20
> I built ignore support for git-svnignore a long time ago. It converts
> the per-directory svn:ignore to per-directory .gitignore at commit
> import time, which is very handy:
>=20
> -I <ignorefile_name>::
>         Import the svn:ignore directory property to files with this
>         name in each directory. (The Subversion and GIT ignore
>         syntaxes are similar enough that using the Subversion pattern=
s
>         directly with "-I .gitignore" will almost always just work.)
>=20
> The only downside with that is that svn ignore patterns are
> non-recursive, while git ignore patterns are recursive. This could be
> solved by prefixing them with a "/".

Has anyone put any thought into mapping the other direction?=20
i.e. .gitignore  ->  svn:ignore

-chris
