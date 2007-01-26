From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Allow users to have their own project directories.
Date: Fri, 26 Jan 2007 14:44:51 +0100
Organization: At home
Message-ID: <epd0id$a7e$1@sea.gmane.org>
References: <11697558112701-git-send-email-mdw@distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 14:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HARNH-0003GG-1D
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 14:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965640AbXAZNoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 Jan 2007 08:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965651AbXAZNoH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 08:44:07 -0500
Received: from main.gmane.org ([80.91.229.2]:38063 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965640AbXAZNoG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 08:44:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HARN0-0007ud-2X
	for git@vger.kernel.org; Fri, 26 Jan 2007 14:43:58 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:43:58 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:43:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37854>

Mark Wooding wrote:

> The git-daemon understands `~USER/...' as referring to a project with=
in
> USER's home directory. =A0This change makes gitweb able to serve each
> user's personal projects without them all having to be linked into on=
e
> place.
>=20
> If the gitweb_config.perl file defines $user_path then a username giv=
en
> in the `u' argument, or as a leading `/~USER/' string in the PATH_INF=
O,
> causes gitweb to look for projects in $homedir/$user_path (where
> $homedir is USER's home directory).
>=20
> Rather than expose all their projects, or the ones with an export fil=
e
> in them, a user can write a file listing the projects to be exported =
by
> gitweb. =A0(Maybe this ought to force strict_export on, but it doesn'=
t at
> the moment.)
>=20
> This patch leaves it as someone else's problem to actually work out
> which users have exported GIT repositories, and maybe compile them in=
to
> a list.

Nice idea. Thanks.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
