From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 5/7] i18n: mark clone nonexistent repository  message for translation
Date: Sun, 10 Apr 2011 19:34:06 +0000
Message-ID: <1302464048-21806-6-git-send-email-avarab@gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 21:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90P5-00036n-6g
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757901Ab1DJTec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:34:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58609 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab1DJTe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:34:27 -0400
Received: by eyx24 with SMTP id 24so1534099eyx.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=DFPvCrpEJO0djFaZC4Wr3JBxRYk5e9Y3jXErx30elbo=;
        b=itys8dLpg26/RZJjUZCMyT+LOS03gpSZPAawwMR97BI5DidN2HaKJojmAgGQO5KKSP
         yZKxMqEaJXMHXuIltZCmid1fqmZlwkX3UwQ0qsIfwLrtKqUdj6ypSAJQd3/gNBkvNgPu
         6924fV0YM3NYbMoFIte699Ms0D/m24rm+REJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L5rEUn7ovXm4RbVttvBlGy3ZHW6dOr8QcqJEClm3l2bqyfvCFQjfUdayREhio6p3b9
         FClP+oRJH47E8Q8Q5F4leLvh6VSvUqp2dDrg8UQ6U3Wj4IgAS1aKIeRYLqzbziAQ2/cV
         xHnL0VZerMoDOYu/Q0P9mtpo/d4sJYRdJ47VE=
Received: by 10.14.119.130 with SMTP id n2mr1902490eeh.59.1302464066687;
        Sun, 10 Apr 2011 12:34:26 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id m55sm1147236eei.8.2011.04.10.12.34.23
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:34:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171278>

Mark the "repository '%s' does not exist" message added in
v1.7.4.2~21^2 (clone: die when trying to clone missing local path) by
Jeff King for translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4144bcf..49c838f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -417,7 +417,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	if (path)
 		repo =3D xstrdup(absolute_path(repo_name));
 	else if (!strchr(repo_name, ':'))
-		die("repository '%s' does not exist", repo_name);
+		die(_("repository '%s' does not exist"), repo_name);
 	else
 		repo =3D repo_name;
 	is_local =3D path && !is_bundle;
--=20
1.7.4.1
