From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Sat, 05 Jul 2014 00:42:29 +0200
Message-ID: <53B72DD5.6020603@gmail.com>
References: <53B72DAA.5050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBVG33SOQKGQEINTPPRA@googlegroups.com Sat Jul 05 00:42:29 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBVG33SOQKGQEINTPPRA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBVG33SOQKGQEINTPPRA@googlegroups.com>)
	id 1X3CBZ-0005s2-81
	for gcvm-msysgit@m.gmane.org; Sat, 05 Jul 2014 00:42:29 +0200
Received: by mail-lb0-f192.google.com with SMTP id w7sf251492lbi.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jul 2014 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=RojkjYWJV/Vu6cg3FX09jvldpPQBw90Ixjx8hirtaCs=;
        b=ZA+rU8mBbUYcPVU2WlabdJdE+1a8qEQ+Yt88fOlB0ou4P6+G9EWuMmCDOaRLJEFcaY
         IlzoISQcdqtYhMlNaaVc1rXQEzgVO2rcP3vML+oPnbV/nbbCxdoEIK8Z34qCFwj6hHMn
         1BzSfh6Ee4rtO87P19CSXFH9MVoKeiDBqY6vIppmFrZf67j6aVelBNxICNlEuQOfbBQf
         0YTpHK/MKlX3Yu8HPnxldo+92Y1ASqp/uFtqoDGNqOQFlvBKnCMF4sUIT4UmXg5kedXq
         RWfeOVv18X/uV3ac8XpAMJEXICV01hFfe/n5693iQwlp5ND4+DWKhizOesgcA5ZLi1YI
         6JMA==
X-Received: by 10.152.10.35 with SMTP id f3mr2023lab.6.1404513749051;
        Fri, 04 Jul 2014 15:42:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.42 with SMTP id s10ls187519lae.74.gmail; Fri, 04 Jul
 2014 15:42:27 -0700 (PDT)
X-Received: by 10.112.1.70 with SMTP id 6mr2334lbk.16.1404513747913;
        Fri, 04 Jul 2014 15:42:27 -0700 (PDT)
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com [2a00:1450:400c:c05::22c])
        by gmr-mx.google.com with ESMTPS id gc5si1434023wic.1.2014.07.04.15.42.27
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 15:42:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22c as permitted sender) client-ip=2a00:1450:400c:c05::22c;
Received: by mail-wi0-f172.google.com with SMTP id hi2so13538263wib.5
        for <msysgit@googlegroups.com>; Fri, 04 Jul 2014 15:42:27 -0700 (PDT)
X-Received: by 10.180.126.9 with SMTP id mu9mr19540486wib.69.1404513747839;
        Fri, 04 Jul 2014 15:42:27 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cz4sm83965700wib.23.2014.07.04.15.42.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 15:42:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B72DAA.5050007@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22c
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252905>

'git status' segfaults if a directory is longer than PATH_MAX, because
processing .gitignore files in prep_exclude() writes past the end of a
PATH_MAX-bounded buffer.

Remove the limitation by using strbuf instead.

Note: this fix just 'abuses' strbuf as string allocator, len is always 0.
prep_exclude() can probably be simplified using more strbuf APIs.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 35 +++++++++++++++++++----------------
 dir.h |  4 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/dir.c b/dir.c
index e65888d..8d4d83c 100644
--- a/dir.c
+++ b/dir.c
@@ -798,7 +798,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	 * path being checked. */
 	while ((stk = dir->exclude_stack) != NULL) {
 		if (stk->baselen <= baselen &&
-		    !strncmp(dir->basebuf, base, stk->baselen))
+		    !strncmp(dir->base.buf, base, stk->baselen))
 			break;
 		el = &group->el[dir->exclude_stack->exclude_ix];
 		dir->exclude_stack = stk->prev;
@@ -833,48 +833,50 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		stk->baselen = cp - base;
 		stk->exclude_ix = group->nr;
 		el = add_exclude_list(dir, EXC_DIRS, NULL);
-		memcpy(dir->basebuf + current, base + current,
+		strbuf_grow(&dir->base, stk->baselen);
+		memcpy(dir->base.buf + current, base + current,
 		       stk->baselen - current);
 
 		/* Abort if the directory is excluded */
 		if (stk->baselen) {
 			int dt = DT_DIR;
-			dir->basebuf[stk->baselen - 1] = 0;
+			dir->base.buf[stk->baselen - 1] = 0;
 			dir->exclude = last_exclude_matching_from_lists(dir,
-				dir->basebuf, stk->baselen - 1,
-				dir->basebuf + current, &dt);
-			dir->basebuf[stk->baselen - 1] = '/';
+				dir->base.buf, stk->baselen - 1,
+				dir->base.buf + current, &dt);
+			dir->base.buf[stk->baselen - 1] = '/';
 			if (dir->exclude &&
 			    dir->exclude->flags & EXC_FLAG_NEGATIVE)
 				dir->exclude = NULL;
 			if (dir->exclude) {
-				dir->basebuf[stk->baselen] = 0;
+				dir->base.buf[stk->baselen] = 0;
 				dir->exclude_stack = stk;
 				return;
 			}
 		}
 
-		/* Try to read per-directory file unless path is too long */
-		if (dir->exclude_per_dir &&
-		    stk->baselen + strlen(dir->exclude_per_dir) < PATH_MAX) {
-			strcpy(dir->basebuf + stk->baselen,
+		/* Try to read per-directory file */
+		if (dir->exclude_per_dir) {
+			strbuf_grow(&dir->base, stk->baselen +
+				    strlen(dir->exclude_per_dir));
+			strcpy(dir->base.buf + stk->baselen,
 					dir->exclude_per_dir);
 			/*
-			 * dir->basebuf gets reused by the traversal, but we
+			 * dir->base gets reused by the traversal, but we
 			 * need fname to remain unchanged to ensure the src
 			 * member of each struct exclude correctly
 			 * back-references its source file.  Other invocations
 			 * of add_exclude_list provide stable strings, so we
 			 * strdup() and free() here in the caller.
 			 */
-			el->src = strdup(dir->basebuf);
-			add_excludes_from_file_to_list(dir->basebuf,
-					dir->basebuf, stk->baselen, el, 1);
+			el->src = strdup(dir->base.buf);
+			add_excludes_from_file_to_list(dir->base.buf,
+					dir->base.buf, stk->baselen, el, 1);
 		}
 		dir->exclude_stack = stk;
 		current = stk->baselen;
 	}
-	dir->basebuf[baselen] = '\0';
+	dir->base.buf[baselen] = '\0';
 }
 
 /*
@@ -1671,4 +1673,5 @@ void clear_directory(struct dir_struct *dir)
 		free(stk);
 		stk = prev;
 	}
+	strbuf_release(&dir->base);
 }
diff --git a/dir.h b/dir.h
index 55e5345..e870fb6 100644
--- a/dir.h
+++ b/dir.h
@@ -111,13 +111,13 @@ struct dir_struct {
 	 * per-directory exclude lists.
 	 *
 	 * exclude_stack points to the top of the exclude_stack, and
-	 * basebuf contains the full path to the current
+	 * base contains the full path to the current
 	 * (sub)directory in the traversal. Exclude points to the
 	 * matching exclude struct if the directory is excluded.
 	 */
 	struct exclude_stack *exclude_stack;
 	struct exclude *exclude;
-	char basebuf[PATH_MAX];
+	struct strbuf base;
 };
 
 /*
-- 
1.9.4.msysgit.0.5.g1471ac1

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
