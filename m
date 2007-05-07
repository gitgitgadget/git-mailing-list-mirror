From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Documentation Bugs
Date: Mon, 7 May 2007 14:58:37 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070507125837.GA16370@informatik.uni-freiburg.de>
References: <20070506130921.GA3750@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 07 14:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl2nc-0002C5-83
	for gcvg-git@gmane.org; Mon, 07 May 2007 14:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647AbXEGM6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 08:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933699AbXEGM6l
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 08:58:41 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33504 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933647AbXEGM6k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 08:58:40 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Hl2nX-0006m0-K8
	for git@vger.kernel.org; Mon, 07 May 2007 14:58:39 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l47Cwb18016978
	for <git@vger.kernel.org>; Mon, 7 May 2007 14:58:37 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l47Cwbs6016977
	for git@vger.kernel.org; Mon, 7 May 2007 14:58:37 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070506130921.GA3750@lala>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46461>

Hello,

> 2) rebase a merged tree:
>=20
>    If I made a local commit and pulled from origin, I get:
>=20
> 	zeisberg@cassiopeia:~/gsrc/git$ git show
> 	commit 15386213004a20dfdf92c654c737795079202545
> 	Merge: 9d740f0... 9159afb...
> 	Author: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
> 	Date:   Sun May 6 14:49:59 2007 +0200
>=20
> 	    Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
>=20
> 	zeisberg@cassiopeia:~/gsrc/git$ git rebase junio/master
> 	Current branch master is up to date.
>=20
>    (where junio/master is the tracking branch for
>    git://git.kernel.org/pub/scm/git/git) but git-rebase(1) states:
>=20
> 	All changes made by commits in the current branch but that are
> 	not in <upstream> are saved to a temporary area. This is the
> 	same set of commits that would be shown by git log
> 	<upstream>..HEAD.
>=20
>    and git-log junio/master..HEAD is not empty.
After having thought about that one once more, here some more info:  Th=
e
two patches I had in master were merged in the meantime.  So it was
correct for git-rebase to state that master is up to date.  Rereading
the documentation I realize there is no bug.  I just missed that both
patches were already merged and format-patch generated a patch anyhow.

The first issue remains however.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

If a lawyer and an IRS agent were both drowning, and you could only sav=
e
one of them, would you go to lunch or read the paper?
