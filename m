From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Mon, 28 Apr 2014 18:29:05 +0200
Message-ID: <1398702545-9860-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: patthoyts@gmail.com,
	marat@slonopotamus.org,
	tuomas.silvola@knowit.fi,
	msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBV4D7KNAKGQEI2X4THY@googlegroups.com Mon Apr 28 18:29:12 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBV4D7KNAKGQEI2X4THY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBV4D7KNAKGQEI2X4THY@googlegroups.com>)
	id 1WeoQa-0006ZT-2e
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 18:29:12 +0200
Received: by mail-la0-f56.google.com with SMTP id pv20sf95082lab.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=hWQY2/QUjaN5ItpD+SLjO2zHFptaofbrma+4qjbRSEY=;
        b=QcimkuEFgpEsWR3Z0T00BPlsZxsKOekSG3bvBaT1mpkCXFLvWPWFV6WOEETjgiVCWb
         Bc5o8lLl3xL6LDn3ahfUqZQMX/kCfPPgXB4XZlw5tb4M0KlFxxeGekO8G0JRReAoSGvu
         tVyRiOLjh/1UMeVpoVMn5OUBnNTXd+780BqNPEEisKqpd4Eooz0lCL21+DWuB4Sl/8kT
         XhNeYb89TbHTMxKTVtfFIlOlRJlbZzTKddH0cvjkPHmG3U7M0KJRXey71VqxyJqserTr
         GLrR1KWjVisOreQsKyx1wZUONBAos7TxyDrTy9KmfMByos31FnV62Ece+U76J9zuINu0
         ZeGw==
X-Received: by 10.180.108.79 with SMTP id hi15mr85156wib.1.1398702551871;
        Mon, 28 Apr 2014 09:29:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.109.170 with SMTP id ht10ls491801wib.35.canary; Mon, 28
 Apr 2014 09:29:10 -0700 (PDT)
X-Received: by 10.15.26.9 with SMTP id m9mr443607eeu.3.1398702550679;
        Mon, 28 Apr 2014 09:29:10 -0700 (PDT)
Received: from mail-ee0-x22b.google.com (mail-ee0-x22b.google.com [2a00:1450:4013:c00::22b])
        by gmr-mx.google.com with ESMTPS id u49si397447eeo.1.2014.04.28.09.29.10
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 09:29:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4013:c00::22b as permitted sender) client-ip=2a00:1450:4013:c00::22b;
Received: by mail-ee0-x22b.google.com with SMTP id e53so5013574eek.16
        for <msysgit@googlegroups.com>; Mon, 28 Apr 2014 09:29:10 -0700 (PDT)
X-Received: by 10.15.81.135 with SMTP id x7mr4612629eey.61.1398702550575;
        Mon, 28 Apr 2014 09:29:10 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPSA id m8sm51627374eeg.11.2014.04.28.09.29.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 09:29:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.msysgit.2
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4013:c00::22b
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247377>

MinGW builds of cURL does not ship with curl-config unless built
with the autoconf based build system, which is not the practice
recommended by the documentation. MsysGit has had issues with
binaries of that sort, so it has switched away from autoconf-based
cURL-builds.

Unfortunately, broke pushing over WebDAV on Windows, because
http-push.c depends on cURL's multi-threaded API, which we could
not determine the presence of any more.

Since troublesome curl-versions are ancient, and not even present
in RedHat 5, let's just assume cURL is capable instead of doing a
non-robust check.

Instead, add a check for curl_multi_init to our configure-script,
for those on ancient system. They probably already need to do the
configure-dance anyway.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

OK, here's a proper patch. I've even tested it! ;)


 Makefile     |  8 +++-----
 configure.ac | 11 +++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index e90f57e..f6b5847 100644
--- a/Makefile
+++ b/Makefile
@@ -1133,13 +1133,11 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
-	ifeq "$(curl_check)" "070908"
-		ifndef NO_EXPAT
+	ifndef NO_EXPAT
+		ifndef NO_CURL_MULTI
 			PROGRAM_OBJS += http-push.o
 		endif
-	endif
-	ifndef NO_EXPAT
+
 		ifdef EXPATDIR
 			BASIC_CFLAGS += -I$(EXPATDIR)/include
 			EXPAT_LIBEXPAT = -L$(EXPATDIR)/$(lib) $(CC_LD_DYNPATH)$(EXPATDIR)/$(lib) -lexpat
diff --git a/configure.ac b/configure.ac
index 2f43393..e7ef9f7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -513,6 +513,17 @@ AC_CHECK_LIB([curl], [curl_global_init],
 [NO_CURL=],
 [NO_CURL=YesPlease])
 
+if test -z "$NO_CURL"; then
+
+AC_CHECK_DECLS([curl_multi_init],
+[NO_CURL_MULTI=],
+[NO_CURL_MULTI=UnfortunatelyYes],
+[[#include <curl/curl.h>]])
+
+GIT_CONF_SUBST([NO_CURL_MULTI])
+
+fi
+
 GIT_UNSTASH_FLAGS($CURLDIR)
 
 GIT_CONF_SUBST([NO_CURL])
-- 
1.9.2.msysgit.2

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
