From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 38/48] i18n: git-bisect add git-sh-i18n
Date: Sat, 21 May 2011 18:44:19 +0000
Message-ID: <1306003469-22939-39-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCj-0001Bj-OV
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200Ab1EUSql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:41 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815Ab1EUSpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:38 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444607eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=GjryPe4QTn6HsTb99R7lJR4H+D1L7DJ/dp1ogJPAEbk=;
        b=r3ugeXWSGVBXFNcx9ryr6vU8LZO4wlerO7eDvRezxjMeIYgDwPLBmQ+i4ZAn94Ci4t
         4jgVAe6Xnu3YIE5W+10k69AbgtISgTeircMXWGCpW3s327eo5ft8RRQOVOy+JVWNtuOF
         BY+f51MVUWC/w8M9efQ6bvsZyzZK7wYaL1XkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tVusd9IJfK1NuBYmGU2xI19iTpOOI+tX83YMy2B13pNQ7/W7b4UyHWfOEP5xrSUN6I
         hij3VoT9lVo8ckCGwH4sQZ0eJd55l7p74YEb2FQKPUiBh4WQv16LNRHhPIjURqSmdD9s
         t4tNVbxd0j/DqvNYMvOOsAAMG1cI7EY8Lpotg=
Received: by 10.213.32.17 with SMTP id a17mr264002ebd.124.1306003538081;
        Sat, 21 May 2011 11:45:38 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.37
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174152>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 415a8d0..751c733 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -28,6 +28,7 @@ Please use "git help bisect" to get the full man page=
=2E'
=20
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 require_work_tree
=20
 _x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
--=20
1.7.5.1
