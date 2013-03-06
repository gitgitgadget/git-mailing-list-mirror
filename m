From: Greg Price <price@MIT.EDU>
Subject: [PATCH] add: Clarify documentation of -A and -u
Date: Wed, 6 Mar 2013 02:26:10 -0500
Message-ID: <20130306072610.GB15534@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 08:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD8kJ-0003wr-RL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 08:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab3CFH0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 02:26:14 -0500
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:48470 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752509Ab3CFH0O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 02:26:14 -0500
X-AuditID: 12074423-b7f5b6d000007e03-66-5136ef959ebb
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 06.7C.32259.59FE6315; Wed,  6 Mar 2013 02:26:13 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id r267QChC022190;
	Wed, 6 Mar 2013 02:26:12 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r267QARj019206;
	Wed, 6 Mar 2013 02:26:11 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixCmqrTv1vVmgwZLZ8hZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFJdNSmpOZllqkb5dAlfG1DXHWQsmCVUcnX2HtYHxDF8XIyeHhICJxIW3
	H5ghbDGJC/fWs3UxcnEICexjlLjWup0FwtnAKLH80HN2COcTo0T3xqVgLSwCKhILLixlBLHZ
	BBQkfsxfBxYXERCXeHt8JjuIzSygJtG+aQoriC0sYCHxZMkrsDivgLXElwttULagxMmZT1gg
	6rUkbvx7ydTFyAFkS0ss/8cBEhYFWnVtfzvbBEb+WUg6ZiHpmIXQsYCReRWjbEpulW5uYmZO
	cWqybnFyYl5eapGumV5uZoleakrpJkZQKLK7KO9g/HNQ6RCjAAejEg/vDG2zQCHWxLLiytxD
	jJIcTEqivN9eAYX4kvJTKjMSizPii0pzUosPMUpwMCuJ8HKdAcrxpiRWVqUW5cOkpDlYlMR5
	r6Xc9BcSSE8sSc1OTS1ILYLJynBwKEnwVr0DahQsSk1PrUjLzClBSDNxcIIM5wEaPh+khre4
	IDG3ODMdIn+KUZfjyN9nLxiFWPLy81KlxHnTQYoEQIoySvPg5sBSyCtGcaC3hHkzQKp4gOkH
	btIroCVMQEs8Qk1AlpQkIqSkGhiLX5goeRr8+r492pvbYnaOa5v6GrO6FXrPf1hFH301w3Dh
	ClWflab7AutuL+9OOWMZMvW5vkqM4r17q4P310m6tZcZ7hWRfau19O1N27aUgx/vZtdnaddX
	JP0X17opurt62d2WFen/wjLdmqdOzHsv6Zi83MXtZsGD9PzcWdq58cIiq6efDFNi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217500>

The documentation of '-A' is very confusing for someone who doesn't
already know what it does.  In particular, it describes the option's
meaning by reference to that of '-u', but it's no more similar to the
latter than it is to the default behavior.  Describe it directly (and
in a way that uses the word 'all'), and then describe the contrast
separately.

Signed-off-by: Greg Price <price@mit.edu>
---
 Documentation/git-add.txt | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 388a225..f89d920 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -105,7 +105,9 @@ apply to the index. See EDITING PATCHES below.
 	will never stage new files, but that it will stage modified
 	new contents of tracked files and that it will remove files
 	from the index if the corresponding files in the working tree
-	have been removed.
+	have been removed.  By contrast `-A` will add new files as
+	well as updating and removing existing ones, and the default
+	behavior will add new files and will not remove existing ones.
 +
 If no <pathspec> is given, the current version of Git defaults to
 "."; in other words, update all tracked files in the current directory
@@ -114,10 +116,17 @@ of Git, hence the form without <pathspec> should not be used.
 
 -A::
 --all::
-	Like `-u`, but match <pathspec> against files in the
-	working tree in addition to the index. That means that it
-	will find new files as well as staging modified content and
-	removing files that are no longer in the working tree.
+	Update the index regarding all files that match <pathspec>,
+	either in the index or the working tree.  That is, remove
+	files that are only in the index, add files that are only in
+	the working tree, and update files that differ between the
+	two.  By contrast `-u` only removes and updates, and the
+	default behavior only adds and updates.
++
+If no <pathspec> is given, the current version of Git defaults to
+"."; in other words, update all tracked files in the current directory
+and its subdirectories. This default will change in a future version
+of Git, hence the form without <pathspec> should not be used.
 
 -N::
 --intent-to-add::
-- 
1.7.11.3
