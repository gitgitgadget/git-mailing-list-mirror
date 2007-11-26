From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 07/10] Teach the new infrastructure about the index and worktree
Date: Mon, 26 Nov 2007 09:31:04 +0100
Message-ID: <20071126083104.GA3591@diana.vm.bytemark.co.uk>
References: <20071125203717.7823.70046.stgit@yoghurt> <20071125205140.7823.46991.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 09:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZNL-0002tc-1I
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 09:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbXKZIbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 03:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbXKZIbM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 03:31:12 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3713 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbXKZIbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 03:31:11 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IwZMv-0000w7-00; Mon, 26 Nov 2007 08:31:05 +0000
Content-Disposition: inline
In-Reply-To: <20071125205140.7823.46991.stgit@yoghurt>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66052>

On 2007-11-25 21:51:40 +0100, Karl Hasselstr=F6m wrote:

> And use the new powers to make "stg coalesce" able to handle
> arbitrary patches, not just consecutive applied patches.

Obviously, this should come with an updated help text for "stg
coalesce". Will amend the patch.

diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index 2b121a9..6c0ae6d 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -27,8 +27,11 @@ help =3D 'coalesce two or more patches into one'
 usage =3D """%prog [options] <patches>
=20
 Coalesce two or more patches, creating one big patch that contains all
-their changes. The patches must all be applied, and must be
-consecutive."""
+their changes.
+
+If there are conflicts when reordering the patches to match the order
+you specify, you will have to resolve them manually just as if you had
+done a sequence of pushes and pops yourself."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-n', '--name', help =3D 'name of coalesced p=
atch'),

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
