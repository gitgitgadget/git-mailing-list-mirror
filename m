From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/6] cache_tree_find(): fix comment formatting
Date: Wed,  5 Mar 2014 18:26:27 +0100
Message-ID: <1394040390-7954-4-git-send-email-mhagger@alum.mit.edu>
References: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:34:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLFhv-0006Bu-NY
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbaCEReM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:34:12 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52516 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753240AbaCEReL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 12:34:11 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2014 12:34:11 EST
X-AuditID: 12074412-f79d46d000002e58-48-53175e53521e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.2B.11864.35E57135; Wed,  5 Mar 2014 12:26:43 -0500 (EST)
Received: from michael.fritz.box (p57A24002.dip0.t-ipconnect.de [87.162.64.2])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s25HQY7C022625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Mar 2014 12:26:42 -0500
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBscJx5sMOOpnMXsG9vYLLqudDNZ
	NPReYba4vWI+swOLx9/3H5g82qaZeVy8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfG6wdPmQvm
	sVYsvb2fqYGxnaWLkZNDQsBE4u+9fawQtpjEhXvr2boYuTiEBC4zSrztns0E4Rxlkpi8dT4b
	SBWbgK7Eop5mJhBbREBNYmLbIbBJzAJpEg+2XAGzhQUcJfZfewNWwyKgKvFyyVxGEJtXwFli
	7bzzjBDb5CSm/F7ADmJzCrhINC7tAKrnAFrmLLFoP/MERt4FjAyrGOUSc0pzdXMTM3OKU5N1
	i5MT8/JSi3TN9HIzS/RSU0o3MUKCR2gH4/qTcocYBTgYlXh4N/iJBwuxJpYVV+YeYpTkYFIS
	5b0aDRTiS8pPqcxILM6ILyrNSS0+xCjBwawkwhsQCZTjTUmsrEotyodJSXOwKInz/lys7ick
	kJ5YkpqdmlqQWgSTleHgUJLgVYgFahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgH
	RUZ8MTA2QFI8QHtFQNp5iwsSc4GiEK2nGBWlxHkVQRICIImM0jy4sbCU8IpRHOhLYYgqHmA6
	get+BTSYCWhwNB/Y4JJEhJRUA+PuCUpsrEvfcHTU7gpl1P16ssx/gYvIjeouKVM7Jpenjit+
	udgpGZQsjTm0afOjK0v3b1L9yLsvqmqa5IV1c27c1pt8xLUqyX7SY5XNHBeYFbXbNZjm1rvw
	92yXmb6pUS/ptvfSM7IxmQ9DXuz57rf8We7jA791y55Lf7JfJZWqO6Wqdvmvl9xK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243452>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index d00f4ef..408ee57 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -555,8 +555,9 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 		struct cache_tree_sub *sub;
 
 		slash = strchrnul(path, '/');
-		/* between path and slash is the name of the
-		 * subtree to look for.
+		/*
+		 * Between path and slash is the name of the subtree
+		 * to look for.
 		 */
 		sub = find_subtree(it, path, slash - path, 0);
 		if (!sub)
-- 
1.9.0
