From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [BUG] git-svn not following svn moves
Date: Thu, 18 Oct 2007 14:13:28 +0200
Message-ID: <20071018121328.GA5358@xp.machine.xx>
References: <ff7fhg$2eu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: cho <tobutaz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:13:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiUFf-0003Fb-7V
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 14:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763410AbXJRMNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 08:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763349AbXJRMNL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 08:13:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:50716 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763288AbXJRMNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 08:13:10 -0400
Received: (qmail invoked by alias); 18 Oct 2007 12:13:08 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp055) with SMTP; 18 Oct 2007 14:13:08 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18pkKVJw94pCPUvdg7tW4cnbhhNE/sPv6Trv+ZY+1
	OHtufNfUJnK6L4
Content-Disposition: inline
In-Reply-To: <ff7fhg$2eu$1@ger.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61522>

On Thu, Oct 18, 2007 at 11:20:16AM +0000, cho wrote:
> Hello,
>=20
> I have a git-svn checkout that apparently did not follow a move corre=
ctly.
> The files are not present in an svn checkout, but are in a git svn cl=
one.
>=20
> According to a trac browser, some of the files that appear in my git=20
> checkout had in fact been moved to their separate branch before doing=
 git-
> svn clone. I noticed this when trying to commit changes to those file=
s,=20
> getting the error message:
> > Le syst=E8me de fichiers ne contient pas cet =E9l=E9ment: Fichier n=
on=20
> trouv=E9 : transaction '3926-1', chemin '.../composants.py' at /home/=
marc/
> bin/git-svn line 2960
> It's a standard subversion error, "Filesystem has no item"
>=20
> I've made a clean checkout (with today's 1.5.3.4.206.g58ba4), and I s=
till=20
> have the moved files present.
> The clone command is just:
> git svn clone --stdlayout svn+ssh://host/srv/subversion/proj/appli/pr=
oj
>=20
> Tell me if I can give more info (the repository isn't public).
>=20

Any chance you could provide a testcase which is similar to what happen=
ed
in your private repo so that the problem could be reproduced here?

-Peter
