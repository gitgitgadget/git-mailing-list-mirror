From: Max Kirillov <max@max630.net>
Subject: [PATCH v7 0/2] path: implement common_dir handling in git_path_submodule()
Date: Wed,  5 Aug 2015 01:05:23 +0300
Message-ID: <1438725925-3689-1-git-send-email-max@max630.net>
References: <1438725067-3295-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:05:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMkL9-0006sl-N6
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 00:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbbHDWFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 18:05:39 -0400
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:53461
	"EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752411AbbHDWFi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 18:05:38 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-09.prod.phx3.secureserver.net with 
	id 0m5X1r01S5B68XE01m5cLf; Tue, 04 Aug 2015 15:05:38 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1438725067-3295-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275340>

Emphasized that 1/2 does not change behavior.

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
