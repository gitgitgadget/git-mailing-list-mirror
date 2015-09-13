From: Max Kirillov <max@max630.net>
Subject: [PATCH v9 0/2] Submodule object path
Date: Mon, 14 Sep 2015 01:17:40 +0300
Message-ID: <1442182662-28834-1-git-send-email-max@max630.net>
References: <1441922231-18270-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbFbA-0005Ro-HF
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 00:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbIMWSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 18:18:06 -0400
Received: from p3plsmtpa07-08.prod.phx3.secureserver.net ([173.201.192.237]:50585
	"EHLO p3plsmtpa07-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893AbbIMWSF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2015 18:18:05 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-08.prod.phx3.secureserver.net with 
	id GmHx1r0035B68XE01mJ17P; Sun, 13 Sep 2015 15:18:04 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1441922231-18270-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277797>

Since v8:
Use strbuf_git_path_submodule() as Jeff suggested

Max Kirillov (2):
  submodule refactor: use strbuf_git_path_submodule() in
    add_submodule_odb()
  path: implement common_dir handling in git_pathdup_submodule()

 cache.h                          |  1 +
 path.c                           | 22 ++++++++++++++++++----
 setup.c                          | 17 ++++++++++++-----
 submodule.c                      |  8 +-------
 t/t7410-submodule-checkout-to.sh | 10 ++++++++++
 5 files changed, 42 insertions(+), 16 deletions(-)

-- 
2.3.4.2801.g3d0809b
