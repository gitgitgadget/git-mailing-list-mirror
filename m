From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 0/3] git-submodule add: Add -r/--record option
Date: Thu, 08 Nov 2012 22:35:11 -0500
Message-ID: <cover.1352431674.git.wking@tremily.us>
References: <20121029222759.GI20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 04:42:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWfUe-0003mK-Uo
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 04:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab2KIDmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 22:42:43 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:20843 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757501Ab2KIDmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 22:42:42 -0500
Received: from odin.tremily.us ([unknown] [72.68.90.158])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MD700LFMBMIRF40@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 08 Nov 2012 21:42:19 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id A9F9468EDC2; Thu,
 08 Nov 2012 22:42:18 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.gc2eb43a
In-reply-to: <20121029222759.GI20513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209202>

=46rom: "W. Trevor King" <wking@tremily.us>

Here's my revised patch.  Changes from v2:

* Revised =C3=86var-vs-Gerrit usage to show agreement, following Shawn'=
s
  comments.
* Added a cleaned up version of Phil's $submodule_* export patch, with
  docs and tests.
* Added a caveat to the -r/--record documentation to make it explicit
  that submodule.<name>.branch is not used internally by Git.  Give an
  example of how the user may use it explicitly for =C3=86var-style
  updates.

W. Trevor King (3):
  git-submodule add: Add -r/--record option
  git-submodule foreach: export .gitmodules settings as variables
  git-submodule: Motivate --record with an example use case

 Documentation/git-submodule.txt | 22 +++++++++++++++++++++-
 git-sh-setup.sh                 | 20 ++++++++++++++++++++
 git-submodule.sh                | 35 +++++++++++++++++++++++++++++++++=
+-
 t/t7400-submodule-basic.sh      | 25 +++++++++++++++++++++++++
 t/t7407-submodule-foreach.sh    | 29 +++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 2 deletions(-)
 mode change 100644 =3D> 100755 git-sh-setup.sh

--=20
1.8.0.3.gc2eb43a
