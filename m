From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: new GIT-VERSION-GEN with old GIT
Date: Sat, 23 Feb 2008 18:34:01 +0100
Message-ID: <20080223173401.GA7808@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 18:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSyHg-0001Ai-79
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 18:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756852AbYBWReN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 12:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756767AbYBWReL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 12:34:11 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:49052 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756750AbYBWReF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 12:34:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C302D6CF0080;
	Sat, 23 Feb 2008 18:34:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ejmtreQttX8S; Sat, 23 Feb 2008 18:34:01 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 985CF6800674; Sat, 23 Feb 2008 18:34:01 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74829>

On Debian, git 1.4.4 is still shipped in the stable distribution.

Since e5fc9a0aea2c3c49829b5cdf499339e5c759706b, simply running make in
a git checkout yields to an error message.

The error is in GIT-VERSION-GEN:
| + git diff-index --quiet HEAD
| usage: git-diff-index [-m] [--cached] [<common diff options>] <tree-i=
sh> [<path>...]
| common diff options:
|   -z            output diff-raw with lines terminated with NUL.
|   -p            output patch format.
|   -u            synonym for -p.
|   --patch-with-raw
|                 output both a patch and the diff-raw format.
|   --stat        show diffstat instead of patch.
|   --numstat     show numeric diffstat instead of patch.
|   --patch-with-stat
|                 output a patch and prepend its diffstat.
|   --name-only   show only names of changed files.
|   --name-status show names and status of changed files.
|   --full-index  show full object name on index lines.
|   --abbrev=3D<n>  abbreviate object names in diff-tree header and dif=
f-raw.
|   -R            swap input file pairs.
|   -B            detect complete rewrites.
|   -M            detect renames.
|   -C            detect copies.
|   --find-copies-harder
|                 try unchanged files as candidate for copy detection.
|   -l<n>         limit rename attempts up to <n> paths.
|   -O<file>      reorder diffs according to the <file>.
|   -S<string>    find filepair whose only one side contains the string=
=2E
|   --pickaxe-all
|                 show all files diff when -S is used and hit is found.
|   -a  --text    treat all files as text.

The problem is not critical, as the build process continues with wrong
version information.

mfg Martin K=F6gler
