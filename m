From: Paul Mackerras <paulus@samba.org>
Subject: Please pull gitk update
Date: Sat, 24 Mar 2012 16:55:40 +1100
Message-ID: <20120324055540.GA20898@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:56:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBJyC-0004CE-Gw
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 06:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab2CXF4T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 01:56:19 -0400
Received: from ozlabs.org ([203.10.76.45]:59516 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab2CXF4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 01:56:18 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 97D88B6EE8; Sat, 24 Mar 2012 16:56:16 +1100 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193817>

Junio,

The following changes since commit 811c70fc8369cfeae2f1e843c695c37e3b0c=
3109:

  gitk: Make vi-style keybindings more vi-like (2011-10-08 18:01:54 +11=
00)

are available in the git repository at:

  git://ozlabs.org/~paulus/gitk.git master

for you to fetch changes up to b2b76d10696d945bf19318831b64d009d119e051=
:

  gitk: Teach gitk to respect log.showroot (2012-03-24 16:44:12 +1100)

----------------------------------------------------------------
=46r=C3=A9d=C3=A9ric Bri=C3=A8re (1):
      gitk: Skip over AUTHOR/COMMIT_DATE when searching all fields

Jim Meyering (1):
      gitk: Make "git describe" output clickable, too

Jonathan Nieder (1):
      gitk: Use symbolic font names "sans" and "monospace" when availab=
le

Marcus Karlsson (1):
      gitk: Teach gitk to respect log.showroot

Pat Thoyts (2):
      gitk: Use a tabbed dialog to edit preferences
      gitk: Fix the display of files when filtered by path

Paul Mackerras (2):
      gitk: Speed up resolution of short SHA1 ids
      gitk: Add menu items for comparing a commit with the marked commi=
t

Zbigniew J=C4=99drzejewski-Szmek (1):
      gitk: Use "gitk: repo-top-level-dir" as window title

 gitk |  412 +++++++++++++++++++++++++++++++++++++++++++++-------------=
--------
 1 files changed, 282 insertions(+), 130 deletions(-)
