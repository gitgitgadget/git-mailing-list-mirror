From: Max Kirillov <max@max630.net>
Subject: [PATCH v8 0/2] Submodule object path
Date: Fri, 11 Sep 2015 00:57:09 +0300
Message-ID: <1441922231-18270-1-git-send-email-max@max630.net>
References: <1438725925-3689-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 00:05:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za9xZ-0007IL-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 00:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbbIJWEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 18:04:45 -0400
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net ([173.201.192.231]:37497
	"EHLO p3plsmtpa07-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbbIJWEp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 18:04:45 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2015 18:04:45 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-02.prod.phx3.secureserver.net with 
	id FZxT1r00H5B68XE01ZxawM; Thu, 10 Sep 2015 14:57:37 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1438725925-3689-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277641>

* Rebased to recent master (v2.6.0-rc0).
* Use git_pathdup_submodule() instead of git_path_submodule()
* There are more conflicts in pu with [1], not sure
  what should I do about it.
* Style fixes as Stefan suggested

[1] http://thread.gmane.org/gmane.comp.version-control.git/276628

Max Kirillov (2):
  submodule refactor: use git_pathdup_submodule() in add_submodule_odb()
  path: implement common_dir handling in git_pathdup_submodule()

 cache.h                          |  1 +
 path.c                           | 22 ++++++++++++++++++----
 setup.c                          | 17 ++++++++++++-----
 submodule.c                      | 30 ++++++++++++------------------
 t/t7410-submodule-checkout-to.sh | 10 ++++++++++
 5 files changed, 53 insertions(+), 27 deletions(-)

-- 
2.3.4.2801.g3d0809b
