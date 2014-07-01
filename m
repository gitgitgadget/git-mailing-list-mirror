From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 05/16] Documentation/git.txt: improve
 documentation of 'GIT_TRACE*' variables
Date: Wed, 02 Jul 2014 00:58:02 +0200
Message-ID: <53B33CFA.2040601@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBB6XZZSOQKGQEXRP7NTA@googlegroups.com Wed Jul 02 00:58:03 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB6XZZSOQKGQEXRP7NTA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB6XZZSOQKGQEXRP7NTA@googlegroups.com>)
	id 1X26zy-00026k-QB
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 00:58:02 +0200
Received: by mail-wg0-f63.google.com with SMTP id x12sf1044927wgg.18
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=zxgD3+xcyh5K7NBWsvKWDr0OkwsNYNcRmIGHlLMArbI=;
        b=tmWEsH0HqGiwtKpZg5Jx9JrF4i2mkbzILAz1vsbUvOR5FyfLDLBhXGPihUP9/KOmOe
         5d8slWVc3yRTlaflcYmvmBrywY0W0Z5NfeE2Xl315KvK2zyvxOL2v5rwuHFG5IM3mfy5
         51pdxyMelNnA63U2pqsbwqJLkw/6JO2J+usd+Dr07DdxLrqoNjlvAswcYoBZ7c/y+LEv
         jX61KBrZ3kiyQ7fObrL0bEJ8bNhaI6sh5hhx0Ar6Fs4yJ+ZfQ6CZJNKjCuM0pfdgkAcJ
         jhGYcOo+8XkJER0haNOG5ga9AU5pR+ncc6txWD3LoSxZjVUPPt10MggYOKaB7TvyqxyH
         i3JA==
X-Received: by 10.180.205.142 with SMTP id lg14mr79226wic.1.1404255482514;
        Tue, 01 Jul 2014 15:58:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.93.165 with SMTP id cv5ls348739wib.21.gmail; Tue, 01 Jul
 2014 15:58:01 -0700 (PDT)
X-Received: by 10.180.13.196 with SMTP id j4mr3857502wic.0.1404255481806;
        Tue, 01 Jul 2014 15:58:01 -0700 (PDT)
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com [2a00:1450:400c:c05::22f])
        by gmr-mx.google.com with ESMTPS id d15si20058wic.3.2014.07.01.15.58.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:58:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22f as permitted sender) client-ip=2a00:1450:400c:c05::22f;
Received: by mail-wi0-f175.google.com with SMTP id r20so8641532wiv.2
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 15:58:01 -0700 (PDT)
X-Received: by 10.180.228.106 with SMTP id sh10mr27016659wic.51.1404255481740;
        Tue, 01 Jul 2014 15:58:01 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 10sm39280350wjx.26.2014.07.01.15.58.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:58:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22f
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252753>

Separate GIT_TRACE description into what it prints and how to configure
where trace output is printed to. Change other GIT_TRACE_* descriptions to
refer to GIT_TRACE.

Add descriptions for GIT_TRACE_SETUP and GIT_TRACE_SHALLOW.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/git.txt | 50 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3bd68b0..75633e6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -904,18 +904,25 @@ for further details.
 	based on whether stdout appears to be redirected to a file or not.
 
 'GIT_TRACE'::
-	If this variable is set to "1", "2" or "true" (comparison
-	is case insensitive), Git will print `trace:` messages on
-	stderr telling about alias expansion, built-in command
-	execution and external command execution.
-	If this variable is set to an integer value greater than 1
-	and lower than 10 (strictly) then Git will interpret this
-	value as an open file descriptor and will try to write the
-	trace messages into this file descriptor.
-	Alternatively, if this variable is set to an absolute path
-	(starting with a '/' character), Git will interpret this
-	as a file path and will try to write the trace messages
-	into it.
+	Enables general trace messages, e.g. alias expansion, built-in
+	command execution and external command execution.
++
+If this variable is set to "1", "2" or "true" (comparison
+is case insensitive), trace messages will be printed to
+stderr.
++
+If the variable is set to an integer value greater than 2
+and lower than 10 (strictly) then Git will interpret this
+value as an open file descriptor and will try to write the
+trace messages into this file descriptor.
++
+Alternatively, if the variable is set to an absolute path
+(starting with a '/' character), Git will interpret this
+as a file path and will try to write the trace messages
+into it.
++
+Unsetting the variable, or setting it to empty, "0" or
+"false" (case insensitive) disables trace messages.
 
 'GIT_TRACE_PACK_ACCESS'::
 	If this variable is set to a path, a file will be created at
@@ -925,10 +932,21 @@ for further details.
 	pack-related performance problems.
 
 'GIT_TRACE_PACKET'::
-	If this variable is set, it shows a trace of all packets
-	coming in or out of a given program. This can help with
-	debugging object negotiation or other protocol issues. Tracing
-	is turned off at a packet starting with "PACK".
+	Enables trace messages for all packets coming in or out of a
+	given program. This can help with debugging object negotiation
+	or other protocol issues. Tracing is turned off at a packet
+	starting with "PACK".
+	See 'GIT_TRACE' for available trace output options.
+
+'GIT_TRACE_SETUP'::
+	Enables trace messages printing the .git, working tree and current
+	working directory after Git has completed its setup phase.
+	See 'GIT_TRACE' for available trace output options.
+
+'GIT_TRACE_SHALLOW'::
+	Enables trace messages that can help debugging fetching /
+	cloning of shallow repositories.
+	See 'GIT_TRACE' for available trace output options.
 
 GIT_LITERAL_PATHSPECS::
 	Setting this variable to `1` will cause Git to treat all
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
