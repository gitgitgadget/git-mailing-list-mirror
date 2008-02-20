From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: [PATCH] Clarified the meaning of git-add -u in the documentation
Date: Thu, 21 Feb 2008 00:29:39 +0200
Message-ID: <20080220222939.GA28724@localdomain>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 20 23:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxSa-0003V1-J5
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbYBTWaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbYBTWaF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:30:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:8048 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYBTWaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:30:00 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2298340fga.17
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 14:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        bh=38FFPJyKf1Ve5X2FeCZG3RIbnYyOukIOsvHpzmqvxkU=;
        b=LtmYuuu2dkO6/MA/CijFN2NGKpl1QAEt6V+mMeR2XmQi4YEUsJDSjNBKkcmacIV7Qk+F/Uxq8Xvb0vM7QyfZbpw3KwI2SL6erXNapgzEJaDmlUhLiPLS5UqpZDwyPEFO9o+u92nPrTjTo30/NV2Po+MxMWZ3eJqvXl/eubg52yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=GUEl8PkY00uOFpcmv+BML7Nu7QV92HVUMw5D5RMv/ZKDjclaOmxjEr/wNCD4wLh4xbMmOj72HZSSMcHHI9L7uKuxNILoCTih35+rF6i2UocVR15rAqud4jlGyTF+3Eg5NBDTr0gEp5ZHlcTXr2d1WP8JSUAS0lwVNKVJVaAOeJA=
Received: by 10.86.68.20 with SMTP id q20mr8738074fga.59.1203546599452;
        Wed, 20 Feb 2008 14:29:59 -0800 (PST)
Received: from shadow ( [217.30.191.90])
        by mx.google.com with ESMTPS id d4sm11561955fga.2.2008.02.20.14.29.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Feb 2008 14:29:58 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74555>

The git-add documentation did not state clearly that the -u switch
updates only the tracked files that are in the current directory and
its subdirectories.

Signed-off-by: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
---
 Documentation/git-add.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9d2ac86..4779909 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -74,8 +74,8 @@ OPTIONS
 	Update only files that git already knows about. This is similar
 	to what "git commit -a" does in preparation for making a commit,
 	except that the update is limited to paths specified on the
-	command line. If no paths are specified, all tracked files are
-	updated.
+	command line. If no paths are specified, all tracked files in the
+	current directory and its subdirectories are updated.
 
 \--refresh::
 	Don't add the file(s), but only refresh their stat()
-- 
1.5.4.2
