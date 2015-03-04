From: Max Kirillov <max@max630.net>
Subject: [PATCH v5 0/3] gitk: save only changed configuration on exit
Date: Wed,  4 Mar 2015 05:58:15 +0200
Message-ID: <1425441498-29416-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 04:58:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT0SA-0000uj-MP
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 04:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189AbbCDD6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 22:58:25 -0500
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net ([173.201.193.239]:53358
	"EHLO p3plsmtpa09-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754499AbbCDD6Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 22:58:25 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-10.prod.phx3.secureserver.net with 
	id zFyH1p00U5B68XE01FyP2X; Tue, 03 Mar 2015 20:58:24 -0700
X-Mailer: git-send-email 2.1.1.391.g7a54a76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264716>

The changes:

* remove unused views_modified_names assignment
* use if {[catch...] to check saving error
* split error reporting from busy wait

The busy wait parameters are unchanged, mostly because I did not have time yet to test them.

Max Kirillov (3):
  gitk: write only changed configuration variables
  gitk: report file saving error
  gitk: synchronize config write

 gitk | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 14 deletions(-)

-- 
2.1.1.391.g7a54a76
