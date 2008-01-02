From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Commit a series of patches to SVN without rebase
Date: Tue, 1 Jan 2008 19:11:02 -0800
Message-ID: <20080102031102.GA11711@untitled>
References: <20071220164044.GA22683@alea.gnuu.de> <20071222045340.GA21524@soma> <slrnfmttoo.28m.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Wed Jan 02 04:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9u13-0002Fw-Co
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 04:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYABDLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2008 22:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbYABDLK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 22:11:10 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55150 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbYABDLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 22:11:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 8B5DD2DC034;
	Tue,  1 Jan 2008 19:11:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <slrnfmttoo.28m.joerg@alea.gnuu.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69451>

J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
> Hi Eric,
>=20
> Eric Wong <normalperson@yhbt.net> wrote:
> > J=F6rg Sommer <joerg@alea.gnuu.de> wrote:
> >> I've a number of patches in git I want to send to a SVN repository=
=2E git
> >> svn dcommit does a rebase after each commit which makes the whole =
commit
> >> takes very long. Is it possible to skip the rebase? All patches ar=
e in
> >> one branch without merges, a simple chain. Is it save to use --no-=
rebase
> >> in this case?
> >
> > Right now, only if the changes don't depend on each other (they all
> > modify different files).
>=20
> May I ask you what the rational behind doing a rebase every time is? =
Is
> it needed? Why is it not possible to send all commits and do one reba=
se
> after the last one?

Rebase is done to alert the user of potential conflicts before
attempting to commit them to a remote repository.  Formerly it was
done to prevent potential clobbering of upstream changes if
there were conflicts, but I think that's been rectified in recent
months.

--=20
Eric Wong
