From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] git-fetch.txt: document fetch output
Date: Fri,  3 Jun 2016 18:08:41 +0700
Message-ID: <20160603110843.15434-2-pclouds@gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 13:09:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8myY-0006aD-LR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbcFCLJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 07:09:09 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33289 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487AbcFCLJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 07:09:04 -0400
Received: by mail-pa0-f68.google.com with SMTP id di3so5780138pab.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AxzmhQvHDb8HIO/vBDEiNvHwnTAXMjmlBUMNbTXE3tM=;
        b=hPziqDOx3Qbj8GOGPchllp8WLZG3D1gUkmT3KEfA2szccRBtascro2PB9awLTBK6+8
         1AOuwLNn507AwbZX+0YPmzAYf8cpJGJOET3PJsZtWkHF4lDw+fkAYDgfb0MXpRIcZcSB
         LLe2lBBhiYP3+6vE5O5l5v74hqzn+/3NFLc/DxKxSIcfDHoEjNKTQPhGIYERvuVJAhXs
         GS9C/C1QdF7/5nUP4HcTvbQlXVXp9v/UQ2i2gocwm6AMLmTE/eCK/HVBBU8MPHQpK6Tj
         8+X5BBfapXSQdgNMR8Ck9XH1jEYNKwsXkcMPOgOh3qbsUOjj5IMMxTHAaUNWd5a7a165
         wBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AxzmhQvHDb8HIO/vBDEiNvHwnTAXMjmlBUMNbTXE3tM=;
        b=P6y9B4lyvB+KNWubiQUkcY9ztdsGjsOr17GTJf3AamXUQRdDMTIkBycwwRa8XJGnOm
         eCZL//NbhsuBVlNCU/R8O1fEX0AUAXNv4PAo2iT6177ddQlHH8PwjCv4iWYILBPFJH+Y
         QrtmiUoa1OBcQ/MOjGBTHEw+M32z/umVKseBpwj547Sbmihda1DY2FTYpNet0naDQWS9
         a2/ZCp6MKjT5zP98xZL5uEWLmAkFE/UW76YRtmtm7r2bQmSQ6Inru7XHoRkvi+BPsH1H
         qSDHcLoo+Knvvqcsk96ghrluk+9McZ1U66R9/ViZlz6uyiJNHmKxLfEJmHg14Yb/4/hA
         xaGA==
X-Gm-Message-State: ALyK8tJ5As/EoDBn7ONQWGleLlzzs3CZIiwpya3rCantVduro/9QIWyVeERWdlf7eP5aGg==
X-Received: by 10.66.168.42 with SMTP id zt10mr4657004pab.132.1464952138951;
        Fri, 03 Jun 2016 04:08:58 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id to9sm5157760pab.27.2016.06.03.04.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 04:08:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 18:08:53 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603110843.15434-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296298>

This documents the ref update status of fetch. The structure of this
output is defined in [1]. The ouput content is refined a bit in [2]
[3] [4].

This patch is a copy from git-push.txt, modified a bit because the
flag '-' means different things in push (delete) and fetch (tag
update). We probably should unify the documents at some point in
future.

PS. For code archaeologists, the discussion mentioned in [1] is
probably [5].

[1] 165f390 (git-fetch: more terse fetch output - 2007-11-03)
[2] 6315472 (fetch: report local storage errors ... - 2008-06-26)
[3] f360d84 (builtin-fetch: add --prune option - 2009-11-10)
[4] 0997ada (fetch: describe new refs based on where... - 2012-04-16)
[5] http://thread.gmane.org/gmane.comp.version-control.git/61657
---
 Documentation/git-fetch.txt | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index efe56e0..18e733c 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -99,6 +99,52 @@ The latter use of the `remote.<repository>.fetch` values can be
 overridden by giving the `--refmap=<refspec>` parameter(s) on the
 command line.
 
+OUTPUT
+------
+
+The output of "git fetch" depends on the transport method used; this
+section describes the output when pushing over the Git protocol
+(either locally or via ssh).
+
+The status of the push is output in tabular form, with each line
+representing the status of a single ref. Each line is of the form:
+
+-------------------------------
+ <flag> <summary> <from> -> <to> (<reason>)
+-------------------------------
+
+The status of up-to-date refs is shown only if --verbose option is
+used.
+
+flag::
+	A single character indicating the status of the ref:
+(space);; for a successfully fetched fast-forward;
+`+`;; for a successful forced update;
+`x`;; for a successfully deleted ref;
+`-`;; for a successful tag update;
+`*`;; for a successfully fetched new ref;
+`!`;; for a ref that was rejected or failed to update; and
+`=`;; for a ref that was up to date and did not need fetching.
+
+summary::
+	For a successfully fetched ref, the summary shows the old and new
+	values of the ref in a form suitable for using as an argument to
+	`git log` (this is `<old>..<new>` in most cases, and
+	`<old>...<new>` for forced non-fast-forward updates).
+
+from::
+	The name of the remote ref being fetched from, minus its
+	`refs/<type>/` prefix. In the case of deletion, the name of
+	the remote ref is "(none)".
+
+to::
+	The name of the local ref being updated, minus its
+	`refs/<type>/` prefix.
+
+reason::
+	A human-readable explanation. In the case of successfully fetched
+	refs, no explanation is needed. For a failed ref, the reason for
+	failure is described.
 
 EXAMPLES
 --------
-- 
2.8.2.524.g6ff3d78
