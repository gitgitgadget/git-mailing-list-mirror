From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 0/2] path: implement common_dir handling in git_path_submodule()
Date: Wed, 18 Mar 2015 23:10:50 +0200
Message-ID: <1426713052-19171-1-git-send-email-max@max630.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLMz-0004xn-Qv
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbbCRVTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:19:13 -0400
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:52308
	"EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755157AbbCRVTM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 17:19:12 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-07.prod.phx3.secureserver.net with 
	id 59Bw1q00T5B68XE019C1TJ; Wed, 18 Mar 2015 14:12:03 -0700
X-Mailer: git-send-email 2.1.1.391.g7a54a76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265762>

After http://thread.gmane.org/gmane.comp.version-control.git/261990
the only thing which did not enter the serie is these 2 pathes.

Should be applied over the patches by link, or
ecf2ff6ace6a1cc3d55b6f917be5452b5fb0c21b in current pu.

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
2.1.1.391.g7a54a76
