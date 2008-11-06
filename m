From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: How to rebase for git svn?
Date: Thu, 6 Nov 2008 11:24:25 +0100
Message-ID: <20081106102425.GA4192@atjola.homenet>
References: <4911EF4C.8030703@gmail.com> <20081106095500.GA9587@untitled> <bd6139dc0811060215j1ad7ee0ahd0b568283da06cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Yang Zhang <yanghatespam@gmail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Nov 06 11:25:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky23a-0002NW-Ve
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 11:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbYKFKY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 05:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbYKFKY3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 05:24:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:50008 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753452AbYKFKY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 05:24:28 -0500
Received: (qmail invoked by alias); 06 Nov 2008 10:24:26 -0000
Received: from i577BA50B.versanet.de (EHLO atjola.local) [87.123.165.11]
  by mail.gmx.net (mp033) with SMTP; 06 Nov 2008 11:24:26 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18IIi5eASMIthe9ZZaI1FdN58qFtKo9JcWT1m5Wdi
	qZQh7dMvvplYxR
Content-Disposition: inline
In-Reply-To: <bd6139dc0811060215j1ad7ee0ahd0b568283da06cb@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100227>

On 2008.11.06 11:15:21 +0100, Sverre Rabbelier wrote:
> On Thu, Nov 6, 2008 at 10:55, Eric Wong <normalperson@yhbt.net> wrote=
:
> > Yang Zhang <yanghatespam@gmail.com> wrote:
> >> Thanks in advance for any help!
> >
> > Try passing --rebase or --squash with "git pull" to keep history li=
near
> > for SVN.
>=20
> Consider doing the following:
> git config alias.repull "pull --rebase"
> And then using 'git repull' instead of 'git pull'.

Or set branch.<name>.rebase in your config and just use "git pull" ;-)
Setting branch.autosetuprebase might also be useful in that case.

You should be careful to make sure that the other side does not lag
behind WRT svn, though. Otherwise, you end up rebasing commits that
corresponds to svn revisions. Bad.

Bj=F6rn
