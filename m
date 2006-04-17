From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Makefile fixups.
Date: Sun, 16 Apr 2006 20:17:38 -0700
Message-ID: <444308D2.7080705@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 05:17:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVKFN-0007Ac-84
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 05:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWDQDRr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 23:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWDQDRr
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 23:17:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:48437 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751000AbWDQDRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 23:17:46 -0400
Received: by nz-out-0102.google.com with SMTP id o37so465952nzf
        for <git@vger.kernel.org>; Sun, 16 Apr 2006 20:17:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Sya5T/jAvAge/b5mZOVQYnuebeY9y/AjHDL2FQwuhtNd6GjmSLCRZ2O+cbcDGorKoErKDb6tnFYNvuQZLwKH2+y54GRFGPX9ibSjwawpdRMhwJKn2j7X+513L01LuN7dMZPGnyyV+ETt4W7EJ8yeIwlX+OVUi8ejAK9dCjcQ/fE=
Received: by 10.36.72.17 with SMTP id u17mr1443495nza;
        Sun, 16 Apr 2006 20:17:45 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.234.187.236])
        by mx.gmail.com with ESMTP id 7sm5020959nzo.2006.04.16.20.17.44;
        Sun, 16 Apr 2006 20:17:45 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18815>


Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>


---

 Makefile   |    2 +-
 t/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

bb576e0c102e68cc55691fa4a5fc7e793e6e1219
diff --git a/Makefile b/Makefile
index 1130af4f3809610436f4c5d17c3970a947ddae5c..8371f7f522b6b02039af2a9d1684a8137197526e 100644
--- a/Makefile
+++ b/Makefile
@@ -653,7 +653,7 @@ ### Cleaning rules
 clean:
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
-	rm -f $(ALL_PROGRAMS) git$X
+	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	rm -rf $(GIT_TARNAME)
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
diff --git a/t/Makefile b/t/Makefile
index fe65f53c5fbcf07bb69214b0f0cff8aef551e906..549598575b9fdcefe857ddef1b6d980a9773b033 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -25,5 +25,5 @@ clean:
 	rm -fr trash
 
 .PHONY: $(T) clean
-.NOPARALLEL:
+.NOTPARALLEL:
 
-- 
1.3.0.rc4.g5bc4
