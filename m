From: Alfred Perlstein <alfred@freebsd.org>
Subject: [PATCH] git-svn: propset support v3
Date: Sun, 7 Dec 2014 02:46:28 -0800
Message-ID: <20141207104628.GA54199@elvis.mu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 11:46:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxZMH-00071B-LB
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 11:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbaLGKqa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 05:46:30 -0500
Received: from elvis.mu.org ([192.203.228.196]:23628 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161AbaLGKq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 05:46:29 -0500
Received: by elvis.mu.org (Postfix, from userid 1192)
	id 4F56A341F854; Sun,  7 Dec 2014 02:46:28 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260985>

Added:

Eric Sunshine's:
- suggestion to include the comment about propset only
  working on files with content changes.

Eric Wong's:
- use && to chain commands throughout tests
- use svn_cmd wrapper throughout tests
- show $! in die messages
- favor $(...) over `...` in tests
- make new_props an array simplify building the final list
- wrap long comments (help output still needs fixing)
- remove unnecessary FIXME comment
- commit message improvements.

Torsten B=C3=B6gershausen:
- Fixes for test cases.

=46inally, I have refactored the test cases to reduce duplicate code
such that further fixes and improvements can be done in one place.


JFYI, branches are here:
1st review changes:
  https://github.com/splbio/git/compare/master-git-svn-propset-upstream=
?expand=3D1
Squashed into:
  https://github.com/splbio/git/compare/master-git-svn-propset-upstream=
-one-diff?expand=3D1

Current review in different commits:
  https://github.com/splbio/git/compare/master-git-svn-propset-upstream=
2?expand=3D1
Squashed into:
  https://github.com/splbio/git/compare/master-git-svn-propset-upstream=
-one-diff2?expand=3D1
 =20
Thank you very much.


Alfred Perlstein (1):
  git-svn: Support for git-svn propset

 git-svn.perl               | 49 ++++++++++++++++++++++-
 perl/Git/SVN/Editor.pm     | 42 ++++++++++++++++++++
 t/t9148-git-svn-propset.sh | 97 ++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100755 t/t9148-git-svn-propset.sh

--=20
2.1.2
