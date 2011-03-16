From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 0/3] Rename make_*_path with clearer names
Date: Wed, 16 Mar 2011 17:06:16 +0100
Message-ID: <1300291579-25852-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 17:06:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PztEy-0005Dk-5e
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1CPQGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:06:22 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:42448 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab1CPQGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 12:06:20 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 06112460FD;
	Wed, 16 Mar 2011 17:06:13 +0100 (CET)
Received: (nullmailer pid 25890 invoked by uid 1000);
	Wed, 16 Mar 2011 16:06:19 -0000
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169164>

The first patch in this series is in fact a memory-access, but they
together logically as enhancements to make_*_path. Just say so if
it'd be better to split them up.

The calls have been converted 1-to-1 to use the new names, as the real
resolved path is what is needed most of the time.

Carlos Mart=C3=ADn Nieto (3):
  make_absolute_path: return the input path if it points to our buffer
  Name make_*_path functions more accurately
  Use the new {real,absolute}_path function names

 abspath.c              |   26 +++++++++++++++++++++++---
 builtin/clone.c        |   12 ++++++------
 builtin/init-db.c      |    8 ++++----
 builtin/receive-pack.c |    2 +-
 cache.h                |    6 +++---
 dir.c                  |    4 ++--
 environment.c          |    4 ++--
 exec_cmd.c             |    2 +-
 lockfile.c             |    4 ++--
 path.c                 |    2 +-
 setup.c                |   14 ++++++--------
 t/t0000-basic.sh       |   10 +++++-----
 test-path-utils.c      |    4 ++--
 13 files changed, 58 insertions(+), 40 deletions(-)

--=20
1.7.4.1
