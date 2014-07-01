From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 08/16] trace: disable additional trace output for
 unit tests
Date: Wed, 02 Jul 2014 00:59:56 +0200
Message-ID: <53B33D6C.4040809@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBB3H2ZSOQKGQELKUKRSI@googlegroups.com Wed Jul 02 00:59:58 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB3H2ZSOQKGQELKUKRSI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f61.google.com ([209.85.215.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB3H2ZSOQKGQELKUKRSI@googlegroups.com>)
	id 1X271p-0003CP-1m
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 00:59:57 +0200
Received: by mail-la0-f61.google.com with SMTP id pv20sf996495lab.6
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=JhWNrx3oWljtXpa/qbT3gZzid7eEP4pf3gDBWz4X348=;
        b=ftEmtYg9ro0US0QaaLRuWCV9fKftLXXft7dZBGrRiTHH/4UdXD33UxHEwP3J6s7Auu
         dWDD+efVMO3Og2Yl9pYmFWTh8Vfq1d5FAln3KJfbW69GIoY9wgXRuPyeBtkdZWsfOJjB
         4ajieSo73ZtIEKmqq2JalUHmh+SxFjlvTQt57MTVg3VtCUZ30LjS6KLxlBXV3BJsQXoZ
         s3PRjKgprLiPDqXHS75ez43LBFuWWTqlV43moYAOitU/H1ZACTbblC5dTGRgifDlnROD
         ZDa0hhNF6RidH75A+Y3ZKd6iQ2tr5SQL3jYz+M5PGsMz29bcylZMBDTdAABrq4axk98D
         SzTA==
X-Received: by 10.180.211.111 with SMTP id nb15mr144726wic.4.1404255596832;
        Tue, 01 Jul 2014 15:59:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.91.225 with SMTP id ch1ls676440wib.25.gmail; Tue, 01 Jul
 2014 15:59:56 -0700 (PDT)
X-Received: by 10.180.189.138 with SMTP id gi10mr3852167wic.0.1404255595940;
        Tue, 01 Jul 2014 15:59:55 -0700 (PDT)
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id d15si20270wic.3.2014.07.01.15.59.55
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:59:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e as permitted sender) client-ip=2a00:1450:400c:c05::22e;
Received: by mail-wi0-f174.google.com with SMTP id bs8so8649152wib.1
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 15:59:55 -0700 (PDT)
X-Received: by 10.194.79.135 with SMTP id j7mr56691456wjx.56.1404255595878;
        Tue, 01 Jul 2014 15:59:55 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hi4sm51007902wjc.27.2014.07.01.15.59.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:59:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252757>

Some unit-tests use trace output to verify internal state, and unstable
output such as timestamps and line numbers are not useful there.

Disable additional trace output if GIT_TRACE_BARE is set.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 t/test-lib.sh | 4 ++++
 trace.c       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 81394c8..e37da5a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -109,6 +109,10 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+# Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
+GIT_TRACE_BARE=1
+export GIT_TRACE_BARE
+
 if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
 then
 	GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
diff --git a/trace.c b/trace.c
index 3d02bcc..a194b16 100644
--- a/trace.c
+++ b/trace.c
@@ -87,11 +87,17 @@ static const char err_msg[] = "Could not trace into fd given by "
 
 static int prepare_trace_line(struct trace_key *key, struct strbuf *buf)
 {
+	static struct trace_key trace_bare = TRACE_KEY_INIT(BARE);
+
 	if (!trace_want(key))
 		return 0;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
 
+	/* unit tests may want to disable additional trace output */
+	if (trace_want(&trace_bare))
+		return 1;
+
 	/* add line prefix here */
 
 	return 1;
-- 
2.0.0.406.ge74f8ff

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
