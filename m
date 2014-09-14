From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 0/3] gitk: save only changed configuration on exit
Date: Sun, 14 Sep 2014 23:35:56 +0300
Message-ID: <1410726959-20353-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 22:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTGXZ-0000XM-R9
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 22:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbaINUgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 16:36:42 -0400
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:41331
	"EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752788AbaINUgm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2014 16:36:42 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-04.prod.phx3.secureserver.net with 
	id r8cb1o0065B68XE018cfsW; Sun, 14 Sep 2014 13:36:41 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257027>

Changes since v1:

* Add value check to config_variable_change_cb
* Squash 2/3 and 3/3 and the value check into one commit. There is no really
  reasons to divide them except following the real coding history
* Describle the previous undesirable behavior in commit message
* Synchronize writing of config file

Max Kirillov (3):
  gitk refactor: remove boilerplate for configuration variables
  gitk: write only changed configuration variables
  gitk: synchronize config write

 gitk | 215 +++++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 139 insertions(+), 76 deletions(-)

-- 
2.0.1.1697.g73c6810
