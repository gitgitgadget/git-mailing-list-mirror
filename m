From: Stelian Pop <stelian@popies.net>
Subject: Re: Mercurial to git converter.
Date: Fri, 12 Jan 2007 21:14:20 +0100
Message-ID: <1168632860.29218.5.camel@voyager.dsnet>
References: <1168537766.22649.19.camel@localhost.localdomain>
	 <eo8ngk$ja$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 21:14:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5SnF-00020i-DE
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbXALUOY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 15:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbXALUOY
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:14:24 -0500
Received: from sd291.sivit.org ([194.146.225.122]:3904 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030243AbXALUOX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:14:23 -0500
Received: from [192.168.6.3] (deep-space-9.popies.net [82.225.86.56])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by sd291.sivit.org (Postfix) with ESMTP id EA65458122;
	Fri, 12 Jan 2007 21:14:21 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eo8ngk$ja$1@sea.gmane.org>
X-Mailer: Evolution 2.8.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36700>

Le vendredi 12 janvier 2007 =E0 20:28 +0100, Jakub Narebski a =E9crit :
> Stelian Pop wrote:
>=20
> > I switched recently from Mercurial to git for some of my projects, =
and
> > needed a conversion tool with branch support (unlike tailor). I did=
n't
> > find any, so I ended up writing my own one.=20
> >=20
> > hg-to-git.py can probably be greatly improved (it's a rather crude
> > combination of shell and python) but it does already work quite wel=
l for
> > me. Features:
> >       - supports incremental conversion (keep a git repo in sync=20
> >         with a hg repository)
> >       - supports hg branches
> >       - converts hg tags=20
> >=20
> > Feel free to use it, improve it or even include it in mainline git =
(like
> > git-svn and friends).
>=20
> Thanks. Added to
>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#hg-to-git

Thanks.

> (Perhaps you should send it as git patch adding file contrib/hg-to-gi=
t.py
> or contrib/git-hgimport/hg-to-git.py ?)

Sure, I can do that (patch against 'master', right ?)

Do I put this in contrib/ as you suggest or directly in / (where friend=
s
like git-p4import.py live) ? What is most likely to be accepted ?

Stelian.
--=20
Stelian Pop <stelian@popies.net>
