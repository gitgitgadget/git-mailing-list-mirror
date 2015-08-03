From: Max Kirillov <max@max630.net>
Subject: [PATCH v5 0/2] path: implement common_dir handling in git_path_submodule()
Date: Tue,  4 Aug 2015 00:03:54 +0300
Message-ID: <1438635836-7857-1-git-send-email-max@max630.net>
References: <1426713052-19171-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:11:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMN1A-0006BK-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbbHCVL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:11:28 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:36754
	"EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755198AbbHCVL1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2015 17:11:27 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-09.prod.phx3.secureserver.net with 
	id 0M4A1r00M5B68XE01M4FAP; Mon, 03 Aug 2015 14:04:17 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1426713052-19171-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275201>

Rebased to latest master, also merges cleanly to pu. Otherwise no changes.

Max Kirillov (2):
  submodule refactor: use git_path_submodule() in add_submodule_odb()
  path: implement common_dir handling in git_path_submodule()

 cache.h                          |  1 +
 path.c                           | 24 ++++++++++++++++++++----
 setup.c                          | 17 ++++++++++++-----
 submodule.c                      | 28 ++++++++++------------------
 t/t7410-submodule-checkout-to.sh | 10 ++++++++++
 5 files changed, 53 insertions(+), 27 deletions(-)

-- 
2.3.4.2801.g3d0809b
