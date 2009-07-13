From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Mon, 13 Jul 2009 19:03:43 +0530
Message-ID: <20090713133343.GA23946@skywalker>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 15:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQLfM-0005wZ-JT
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 15:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815AbZGMNdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 09:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbZGMNdw
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 09:33:52 -0400
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:46217 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbZGMNdw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 09:33:52 -0400
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n6DNQ1EF026792
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 09:26:01 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n6DDXouU1273870
	for <git@vger.kernel.org>; Mon, 13 Jul 2009 23:33:50 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6DDXn77018938
	for <git@vger.kernel.org>; Mon, 13 Jul 2009 23:33:50 +1000
Received: from skywalker ([9.124.220.59])
	by d23av01.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n6DDXiX7018891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 13 Jul 2009 23:33:48 +1000
Content-Disposition: inline
In-Reply-To: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123192>

On Sun, Jul 12, 2009 at 11:40:05PM +0100, Catalin Marinas wrote:
> The first release candidate for StGit 0.15 is available from the
> git://repo.or.cz/stgit.git or http://download.gna.org/stgit/. Bugs can
> be reported on the Git mailing list or via the project bugs page
> (https://gna.org/bugs/?group=stgit).
> 
> StGit is a Python application providing similar functionality to Quilt
> (i.e. pushing/popping patches to/from a stack) on top of Git. These
> operations are performed using Git commands and the patches are stored
> as Git commit objects, allowing easy merging of the StGit patches into
> other repositories using standard Git functionality.
> 
> The main changes since release 0.14.3 (I may miss some important
> features but they can be found in the log):


stg show now gives me output like below

ESC[1mdiff --git a/fs/nfs/nfs4acl.c b/fs/nfs/nfs4acl.cESC[m
ESC[1mindex 09946da..c9a6dee 100644ESC[m
ESC[1m--- a/fs/nfs/nfs4acl.cESC[m
ESC[1m+++ b/fs/nfs/nfs4acl.cESC[m
ESC[36m@@ -37,6 +37,7 @@ESC[m


I guess it is due to coloring enabled in git. I have in git 

$ git config --get  "color.ui"
auto
$ 

git show does the right thing. ie show the diff in color

-aneesh
