From: =?UTF-8?B?VGFkZXVzeiBBbmRyemVqIEthZMWCdWJvd3NraQ==?= 
	<yess@hell.org.pl>
Subject: [PATCH 1/2] git-filter-branch.txt: clarify ident variables usage
Date: Thu, 21 Feb 2013 21:22:50 +0100
Message-ID: <5126821A.9020800@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 21:23:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8cfk-0004Fv-66
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab3BUUWw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2013 15:22:52 -0500
Received: from hell.org.pl ([213.135.50.122]:57410 "EHLO hell.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab3BUUWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 15:22:51 -0500
Received: from [10.2.0.23] (unknown [193.107.214.17])
	by hell.org.pl (Postfix) with ESMTP id E0A85F0082
	for <git@vger.kernel.org>; Thu, 21 Feb 2013 21:22:50 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216792>

There is a rare edge case of git-filter-branch: a filter that unsets
identity variables from the environment. Link to git-commit-tree
clarifies how Git would fall back in this situation.

Signed-off-by: Tadeusz Andrzej Kad=C5=82ubowski <yess@hell.org.pl>
---
 Documentation/git-filter-branch.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index dfd12c9..e50ee2f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -65,9 +65,9 @@ Prior to that, the $GIT_COMMIT environment variable w=
ill be set to contain
 the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
 GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_E=
MAIL,
 and GIT_COMMITTER_DATE are set according to the current commit.  The v=
alues
-of these variables after the filters have run, are used for the new co=
mmit.
-If any evaluation of <command> returns a non-zero exit status, the who=
le
-operation will be aborted.
+of these variables after the filters have run, are used for the new co=
mmit
+(see linkgit:git-commit-tree[1] for details).  If any evaluation of <c=
ommand>
+returns a non-zero exit status, the whole operation will be aborted.
  A 'map' function is available that takes an "original sha1 id" argume=
nt
 and outputs a "rewritten sha1 id" if the commit has been already
--=20
1.7.11.7
