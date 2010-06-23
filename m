From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn relocate [SCRIPT]
Date: Wed, 23 Jun 2010 09:53:03 +0000
Message-ID: <20100623095303.GA19651@dcvr.yhbt.net>
References: <20100622114043.1419733jtkx6m0co@webmail.tu-harburg.de> <m3r5jznr9z.fsf@localhost.localdomain> <AANLkTil6VEPqJxp4wiE7f25zmrnZ9vS1M-f4tFuV4pMO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Stimming <christian@cstimming.de>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 11:53:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORMeA-00006S-GG
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 11:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab0FWJxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 05:53:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40054 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab0FWJxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 05:53:03 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0C61F43D;
	Wed, 23 Jun 2010 09:53:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTil6VEPqJxp4wiE7f25zmrnZ9vS1M-f4tFuV4pMO@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149501>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> wrote:
> On Tue, Jun 22, 2010 at 13:15, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> > If you can put this script somewhere (e.g. GitHub, or repo.or.cz), =
could you
> > please add information about it to InterfacesFriontendsAndTools pag=
e on Git
> > Wiki (http://git.wiki.kernel.org)?
> >
> > Alternatively, perhaps you could send it as a patch adding it to so=
mwehere
> > in the contrib/
>=20
> This is part of the "Reconstructing git-svn metadata after a git
> clone"[1] problem for which there's an open thread. You have to
> rewrite history using git-filter-branch to fix the branch references
> if you need to change the SVN URL.
>=20
> It would be nice if you could specify that sed replacement in some
> git-svn config file if you needed to change e.g. someone's http://
> clone to a svn+ssh:// clone without rewriting the whole thing.
>=20
> Would that sort of thing be possible? Eric?
>=20
> http://kerneltrap.org/mailarchive/git/2010/5/8/30062

Does the existing rewriteRoot configuration option work for this?
(I had almost forgotten about it myself :x)

--=20
Eric Wong
