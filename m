From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 0/3] Improve branch UI for setting upstream information
Date: Mon, 20 Aug 2012 15:47:37 +0200
Message-ID: <1345470460-28734-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 16:00:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3SWp-0002Ng-Am
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 16:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502Ab2HTOAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 10:00:17 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:47722 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755176Ab2HTN4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 09:56:17 -0400
Received: from flaca.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by hessy.dwim.me (Postfix) with ESMTPA id BC7B5802C6
	for <git@vger.kernel.org>; Mon, 20 Aug 2012 15:47:40 +0200 (CEST)
Received: (nullmailer pid 28772 invoked by uid 1000);
	Mon, 20 Aug 2012 13:47:40 -0000
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203843>

Hi all,

After way too long, here's the next iteration of the concept that
began with swapping arguments in --set-upstream like -m does.

After the feedback from the list, --set-upstream-to was born and
--set-upstream is being deprecated in favour of either --track or
--set-upstream-to depening on which of the behaviours the user wants
to have.

Using --set-upsteam with one argument now also leads to a message
explaining how to undo it. For that, branch has learnt
--unset-upstream which will remove the upstream information for the
given branch (or HEAD).

Carlos Mart=C3=ADn Nieto (3):
  branch: introduce --set-upstream-to
  branch: add --unset-upstream option
  branch: suggest how to undo a --set-upstream when given one branch

 Documentation/git-branch.txt | 14 +++++++-
 builtin/branch.c             | 65 +++++++++++++++++++++++++++++++++--
 t/t3200-branch.sh            | 82 ++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 157 insertions(+), 4 deletions(-)

--=20
1.7.11.1.104.ge7b44f1
