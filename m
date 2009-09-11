From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 1/2] mailinfo: add '--scissors' to usage message
Date: Fri, 11 Sep 2009 02:09:20 +0200
Message-ID: <682ef47420f36d8c53e42981370d377b621d7b86.1252626034.git.nicolas.s.dev@gmx.fr>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 02:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MltiE-0005UP-40
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 02:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbZIKAJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 20:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZIKAJl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 20:09:41 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:49555 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbZIKAJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 20:09:40 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so647358ewy.17
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 17:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=mnaSUCIujB7F76q1H6ndyfebmdnYqfERqtyvITLl3Ew=;
        b=Zj/8BsvD3ZlXP21ED+0/qEOcF7eLASo4y5g8QSrtFN9ftX9i6Cs8VINUiemHThVZSf
         aK/aHQ5b5jqAYfI58Jv7ZI5ZcvNh6v+b6WOG19Wj9zSS9OJ6YXU4h3kmYqoaOAo7/CjY
         T3G6e5pbT7iFwsoANaFMaRdi97D8QsMcs8bg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=dM0d6k7SnMlW/fGm+srhwpKzDPW3iNridwiRS8B9Wq3cbpgksOm821dGxO2UAWojzO
         FpDWuxFSwMzAJYcXZ/CF8UQBa+RK8hWfzVWwbSlL6G0GEQE5ICysPVrgR7s6xHlv9lhN
         ILXshCglRNf5xP/gqwyGUXd9HW+cUdGy+6hTE=
Received: by 10.211.146.39 with SMTP id y39mr2381519ebn.65.1252627783735;
        Thu, 10 Sep 2009 17:09:43 -0700 (PDT)
Received: from localhost (91-164-133-105.rev.libertysurf.net [91.164.133.105])
        by mx.google.com with ESMTPS id 24sm1333437eyx.4.2009.09.10.17.09.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 17:09:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.164.g5f6b0
In-Reply-To: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128161>

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 builtin-mailinfo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 03cbcad..7d22fd7 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -1004,7 +1004,7 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 }
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] msg patch <mail >info";
+	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors] msg patch < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
-- 
1.6.5.rc0.164.g5f6b0
