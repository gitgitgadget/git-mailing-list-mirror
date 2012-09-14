From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] test-lib: add support for colors without tput
Date: Fri, 14 Sep 2012 18:41:45 +0200
Message-ID: <1347640905-1400-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRB3N4ZWBAKGQEOSNEIFA@googlegroups.com Fri Sep 14 18:42:26 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB3N4ZWBAKGQEOSNEIFA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ey0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB3N4ZWBAKGQEOSNEIFA@googlegroups.com>)
	id 1TCYyI-0001uY-KL
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 18:42:26 +0200
Received: by mail-ey0-f186.google.com with SMTP id i13sf1509947eaa.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=/w79BKdBgBL4jkac+0h+zJb4wweujz1XQNnHcF6LiFI=;
        b=NnEmHeb48gRVk5FrynT3tVIckD9Wdp8PHGZOu6ix8HzQBOpTFEOSrVeiApQwWG8YSk
         YeKuUqL7hJ3+M5y1bkeTBWwsIKlLJmWqQKKvjaytzE1FFRdm1bKX7HsLd4UPVBMHcBrQ
         1z0ArYn1e35OyjAkTX04YxKrQWQ+7le1AiCzXnbw1Umr5oCvG6HAVb2EIDdhQkg5HZYx
         mQVgKdVbwZvpwrR6iHYkymtHbaFscg1cTP/uNUwM2aO8DPOxTbyubC5KrkAduQg8LQ5M
         iE12AWYL41EpNHhIl0Z9hMjCWh2uLHCSUGkRwLNM++YZQYKcnW6K4x4NZVnpGeopc2rO
         9niw==
Received: by 10.205.117.17 with SMTP id fk17mr264095bkc.29.1347640942237;
        Fri, 14 Sep 2012 09:42:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.4.74 with SMTP id 10ls4697471bkq.0.gmail; Fri, 14 Sep 2012
 09:42:21 -0700 (PDT)
Received: by 10.204.15.209 with SMTP id l17mr487002bka.6.1347640940964;
        Fri, 14 Sep 2012 09:42:20 -0700 (PDT)
Received: by 10.204.15.209 with SMTP id l17mr487001bka.6.1347640940941;
        Fri, 14 Sep 2012 09:42:20 -0700 (PDT)
Received: from mail-lpp01m010-f45.google.com (mail-lpp01m010-f45.google.com [209.85.215.45])
        by gmr-mx.google.com with ESMTPS id e23si177870bks.0.2012.09.14.09.42.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 09:42:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.45 as permitted sender) client-ip=209.85.215.45;
Received: by lagz14 with SMTP id z14so3516827lag.18
        for <msysgit@googlegroups.com>; Fri, 14 Sep 2012 09:42:20 -0700 (PDT)
Received: by 10.152.112.37 with SMTP id in5mr2862622lab.44.1347640940605;
        Fri, 14 Sep 2012 09:42:20 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id fz8sm655998lbb.9.2012.09.14.09.42.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 09:42:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.msysgit.0.5.g0225efe.dirty
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.45 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205499>

For platforms that does not have tput we can still perform coloring
by manually emitting the ANSI control codes. If tput is missing from
$PATH, install a replacement function.

The exact strings has been dumped from a machine that has tput, by
piping the output of tput through 'od -c -An'.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I got slightly annoyed that we didn't get colored output from the
tests on Windows, so I decided to fix it.

Hopefully other platforms can benefit from this as well.

I'm not super happy with the condition to enable it. I considered
an environment variable as well, but decided against it because
"make -C t" from the root does not seem to pick up environment
variables configured in the main Makefile.

Thoughts?

 t/test-lib.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78c4286..7d1b34b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -129,6 +129,20 @@ export _x05 _x40 _z40 LF
 # This test checks if command xyzzy does the right thing...
 # '
 # . ./test-lib.sh
+
+if ! which tput > /dev/null ; then
+	tput () {
+		case "$1" in
+		bold)
+			echo -ne "\033[1m" ;;
+		setaf)
+			echo -ne "\033[0;3$2m" ;;
+		sgr0)
+			echo -ne "\033(\033[m" ;;
+		esac
+	}
+fi
+
 [ "x$ORIGINAL_TERM" != "xdumb" ] && (
 		TERM=$ORIGINAL_TERM &&
 		export TERM &&
-- 
1.7.11.msysgit.0.5.g0225efe.dirty

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
