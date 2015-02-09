From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/8] reflog: fix documentation
Date: Mon,  9 Feb 2015 10:12:40 +0100
Message-ID: <1423473164-6011-5-git-send-email-mhagger@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:13:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkOx-0007f9-7B
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbbBIJNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:13:00 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:60676 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932494AbbBIJM7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:12:59 -0500
X-AuditID: 12074412-f79e46d0000036b4-84-54d87a1934ad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.C9.14004.91A78D45; Mon,  9 Feb 2015 04:12:57 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQa026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:12:56 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqCtZdSPE4NsbK4uuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZk28sZylYwVuxdJFpA+Mq7i5GDg4JAROJvQ3JXYycQKaYxIV769m6
	GLk4hAQuM0qcvNwM5Zxgkuhb/48ZpIpNQFdiUU8zE4gtIqAmMbHtEAuIzSywmkli6102EFtY
	QE9iyZvdYPUsAqoS61ZtZQexeQWcJY6/+cUEsU1O4vzxn2A1nAIuEu/OzQHrFQKqmT15H/ME
	Rt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MUJCTGgH4/qTcocYBTgY
	lXh4L3y+HiLEmlhWXJl7iFGSg0lJlHdB4o0QIb6k/JTKjMTijPii0pzU4kOMEhzMSiK83zOA
	crwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErxclUCNgkWp6akVaZk5
	JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aC4iC8GRgZIigdo79cKkL3FBYm5QFGI1lOMilLivN9A
	EgIgiYzSPLixsMTxilEc6EthXk6Q7TzApAPX/QpoMBPQ4IICsMEliQgpqQZG5j6Z6wdZvTQv
	zOk8cnrVwYt3v9ywv+3ZkWejcL1VRF/+fcbJsk0/8qXmpzif2JiZ9/vUEUv3oBfmS1Z83f2F
	tfWswY7HGhkbkh90C37iuLyKwaz+S2HClvvff/59vz494sQz69OxulJv63NEt178 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263547>

Update the "git reflog" usage documentation in the manpage and the
command help to match the current reality.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-reflog.txt | 6 ++++--
 builtin/reflog.c             | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 70791b9..b410ee6 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,9 +17,11 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog expire' [--dry-run] [--stale-fix] [--verbose]
+'git reflog expire' [--dry-run] [--verbose]
+	[--rewrite] [--updateref] [--stale-fix]
 	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
-'git reflog delete' ref@\{specifier\}...
+'git reflog delete' [--dry-run] [--verbose]
+	[--rewrite] [--updateref] ref@\{specifier\}...
 'git reflog' ['show'] [log-options] [<ref>]
 
 Reflog is a mechanism to record when the tip of branches are
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 49c64f9..d89a6dd 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,7 +13,7 @@
  */
 
 static const char reflog_expire_usage[] =
-"git reflog expire [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
+"git reflog expire [--verbose] [--dry-run] [--rewrite] [--updateref] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
 static const char reflog_delete_usage[] =
 "git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
 
-- 
2.1.4
