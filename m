From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Mon, 13 Jul 2009 22:50:17 +0530
Message-ID: <20090713172017.GA29333@skywalker>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com> <20090713133343.GA23946@skywalker> <b0943d9e0907131007q18dbed72tc017be92ed23a61d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karl Wiberg <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 19:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQPCc-00005Y-0C
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 19:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbZGMRU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2009 13:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756598AbZGMRU0
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 13:20:26 -0400
Received: from e28smtp01.in.ibm.com ([59.145.155.1]:33221 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514AbZGMRUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 13:20:25 -0400
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id n6DHKKOJ017530
	for <git@vger.kernel.org>; Mon, 13 Jul 2009 22:50:20 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n6DHKKFr1945674
	for <git@vger.kernel.org>; Mon, 13 Jul 2009 22:50:20 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6DHKKrM003734
	for <git@vger.kernel.org>; Mon, 13 Jul 2009 22:50:20 +0530
Received: from skywalker ([9.124.220.59])
	by d28av01.in.ibm.com (8.13.1/8.12.11) with ESMTP id n6DHKH4D003635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 13 Jul 2009 22:50:19 +0530
Content-Disposition: inline
In-Reply-To: <b0943d9e0907131007q18dbed72tc017be92ed23a61d@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123200>

On Mon, Jul 13, 2009 at 06:07:06PM +0100, Catalin Marinas wrote:
> 2009/7/13 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> > On Sun, Jul 12, 2009 at 11:40:05PM +0100, Catalin Marinas wrote:
> >> The first release candidate for StGit 0.15 is available from the
> >> git://repo.or.cz/stgit.git or http://download.gna.org/stgit/. Bugs=
 can
> >> be reported on the Git mailing list or via the project bugs page
> >> (https://gna.org/bugs/?group=3Dstgit).
> >>
> >> StGit is a Python application providing similar functionality to Q=
uilt
> >> (i.e. pushing/popping patches to/from a stack) on top of Git. Thes=
e
> >> operations are performed using Git commands and the patches are st=
ored
> >> as Git commit objects, allowing easy merging of the StGit patches =
into
> >> other repositories using standard Git functionality.
> >>
> >> The main changes since release 0.14.3 (I may miss some important
> >> features but they can be found in the log):
> >
> >
> > stg show now gives me output like below
> >
> > ESC[1mdiff --git a/fs/nfs/nfs4acl.c b/fs/nfs/nfs4acl.cESC[m
> > ESC[1mindex 09946da..c9a6dee 100644ESC[m
> > ESC[1m--- a/fs/nfs/nfs4acl.cESC[m
> > ESC[1m+++ b/fs/nfs/nfs4acl.cESC[m
> > ESC[36m@@ -37,6 +37,7 @@ESC[m
>=20
> It works fine for me. Do you have a pager for StGit configured in .gi=
tconfig?
>=20

No

> StGit now uses the default output from git (with colours)
>=20
> > I guess it is due to coloring enabled in git. I have in git
> >
> > $ git config --get =A0"color.ui"
>=20
> What does "git config color.diff" say?
>=20

I don't have that config set.

I am on ubuntu jaunty. Do you think it could be a pager bug ?

-aneesh
