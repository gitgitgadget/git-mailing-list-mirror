From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Mon, 13 Jul 2009 23:17:43 +0530
Message-ID: <20090713174743.GB29333@skywalker>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com> <20090713133343.GA23946@skywalker> <b0943d9e0907131007q18dbed72tc017be92ed23a61d@mail.gmail.com> <20090713172017.GA29333@skywalker>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karl Wiberg <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 19:48:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQPdB-0002uW-9U
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 19:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741AbZGMRrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2009 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbZGMRrx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 13:47:53 -0400
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:35358 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbZGMRrw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 13:47:52 -0400
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n6E3loJc031859
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 13:47:50 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n6DHlpNA467256
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 03:47:51 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6DHlopx024107
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 03:47:50 +1000
Received: from skywalker ([9.124.220.59])
	by d23av03.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n6DHlitd024083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 14 Jul 2009 03:47:48 +1000
Content-Disposition: inline
In-Reply-To: <20090713172017.GA29333@skywalker>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123201>

On Mon, Jul 13, 2009 at 10:50:17PM +0530, Aneesh Kumar K.V wrote:
> On Mon, Jul 13, 2009 at 06:07:06PM +0100, Catalin Marinas wrote:
> > 2009/7/13 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> > > On Sun, Jul 12, 2009 at 11:40:05PM +0100, Catalin Marinas wrote:
> > >> The first release candidate for StGit 0.15 is available from the
> > >> git://repo.or.cz/stgit.git or http://download.gna.org/stgit/. Bu=
gs can
> > >> be reported on the Git mailing list or via the project bugs page
> > >> (https://gna.org/bugs/?group=3Dstgit).
> > >>
> > >> StGit is a Python application providing similar functionality to=
 Quilt
> > >> (i.e. pushing/popping patches to/from a stack) on top of Git. Th=
ese
> > >> operations are performed using Git commands and the patches are =
stored
> > >> as Git commit objects, allowing easy merging of the StGit patche=
s into
> > >> other repositories using standard Git functionality.
> > >>
> > >> The main changes since release 0.14.3 (I may miss some important
> > >> features but they can be found in the log):
> > >
> > >
> > > stg show now gives me output like below
> > >
> > > ESC[1mdiff --git a/fs/nfs/nfs4acl.c b/fs/nfs/nfs4acl.cESC[m
> > > ESC[1mindex 09946da..c9a6dee 100644ESC[m
> > > ESC[1m--- a/fs/nfs/nfs4acl.cESC[m
> > > ESC[1m+++ b/fs/nfs/nfs4acl.cESC[m
> > > ESC[36m@@ -37,6 +37,7 @@ESC[m
> >=20
> > It works fine for me. Do you have a pager for StGit configured in .=
gitconfig?
> >=20
>=20
> No
>=20
> > StGit now uses the default output from git (with colours)
> >=20
> > > I guess it is due to coloring enabled in git. I have in git
> > >
> > > $ git config --get =A0"color.ui"
> >=20
> > What does "git config color.diff" say?
> >=20
>=20
> I don't have that config set.
>=20
> I am on ubuntu jaunty. Do you think it could be a pager bug ?
>=20

I had PAGER=3Dless in my .bashrc. I had set it that way because of
https://bugs.launchpad.net/ubuntu/+source/less/+bug/67381

Removing that fixed the problem

-aneesh
