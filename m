From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 23/25] builtin: use builtin.h in git-status
Date: Thu,  2 Sep 2010 19:40:44 +0000
Message-ID: <1283456446-22577-24-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgU-0006jt-UR
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab0IBTmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693Ab0IBTmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:42 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so81343wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zUABqHJmrhM0W5RILjbQ1WiNOhB2nRMbtj8D4Y73xpU=;
        b=W6BZeb+zbb9c2IQUNQED0aYamxDlubdSjSoihtpSKQOxjAZlT64T+BALVx1Ts7N6FE
         77dFZwZO75GqVSuGDJO7BtncSv9gJuYNY9qRl1Usv9q5wyQGRtZSjtNlnCHJhZ2g5pha
         rh0pKoQybwveM0eWnw9m8WOIkh5zwlEacFvJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nDl67METhE/Sjj5KWRvJTAF1CVh/Th+EEdPEWXMP8IHfEVCg3H+XQZ0k1BuJYxgyRw
         snSvJIXqZKmNREfQuSeBei8Ucg/Y0kev+7JzPmPDA1crpfjfjfO6Hob3d0cIP629yuVr
         w3BCwITEcYWAOwaGwN0Kq5ZCZytjcefs+tg+4=
Received: by 10.227.154.211 with SMTP id p19mr104880wbw.19.1283456557656;
        Thu, 02 Sep 2010 12:42:37 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.42.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:42:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155185>

Change wt-status.c to include gettext.h via builtin.h. This is needed
to be able to mark messages for translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 wt-status.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 54b6b03..7716dd9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "wt-status.h"
 #include "object.h"
--=20
1.7.2.2.614.g1dc9
