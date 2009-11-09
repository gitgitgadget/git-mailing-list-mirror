From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/24] check-ref-format: update usage string
Date: Mon,  9 Nov 2009 09:04:47 -0600
Message-ID: <1257779104-23884-7-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Vfm-000393-7S
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbZKIOzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZKIOzT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:19 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbZKIOzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:16 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Hk33AuY3brjgJYdkxB9RytoDpQOzezJRpl0jHkkxNFU=;
        b=SnDASrYdHe4kECCHPeLB1gv2o3U7Goarim1rbQ6eX+Q7GiUOpMmY5ThrMGcbTp2ab9
         pec0aMH5SrouxyRK4xfP06JAsFEH4COtpI5iWQWfCGuNkIem3MOxUGE27G+j7BtkM/If
         06Hs/jxR/9L6r1P2/Vb6IZ8XedQ8zf3qIcMi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AohBEqjSHTkdgb86FEvz8XBCMBnbZxc205ASQ1H7AFBd38aj0mR/sJVtBvdU0v1ysy
         +qf1jaSjhqDj0mD+5ORiU3FDIZ9Zrqt7//fSwYYPdE9NO/I3vVXpIeyTDIReWF9yDIl3
         a8a8mhck+e2X1Dbl0/jdqUosIIAsFMMwRaphI=
Received: by 10.216.93.14 with SMTP id k14mr2476323wef.152.1257778521393;
        Mon, 09 Nov 2009 06:55:21 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:20 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132482>

'git check-ref-format' has learned --branch and --print options
since the usage string was last updated.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-check-ref-format.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index e3e7bdf..513f134 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -7,6 +7,10 @@
 #include "builtin.h"
 #include "strbuf.h"
 
+static const char builtin_check_ref_format_usage[] =
+"git check-ref-format [--print] <refname>\n"
+"   or: git check-ref-format --branch <branchname-shorthand>";
+
 /*
  * Replace each run of adjacent slashes in src with a single slash,
  * and write the result to dst.
@@ -49,6 +53,6 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 		exit(0);
 	}
 	if (argc != 2)
-		usage("git check-ref-format refname");
+		usage(builtin_check_ref_format_usage);
 	return !!check_ref_format(argv[1]);
 }
-- 
1.6.5.2
