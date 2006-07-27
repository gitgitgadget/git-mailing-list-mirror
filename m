From: Robert Shearman <rob@codeweavers.com>
Subject: [PATCH 2/2] rebase: Make the fast-fowarding message more user-friendly
 by using branch names instead of SHA1 IDs.
Date: Thu, 27 Jul 2006 10:32:46 +0100
Organization: CodeWeavers
Message-ID: <44C8883E.5060602@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050402020604080609090704"
X-From: git-owner@vger.kernel.org Thu Jul 27 11:33:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G62F8-0002PL-Bo
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 11:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWG0JdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 05:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWG0JdT
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 05:33:19 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:33173 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932542AbWG0JdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 05:33:18 -0400
Received: from host86-139-253-196.range86-139.btcentralplus.com ([86.139.253.196] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G62F4-0005l3-1w
	for git@vger.kernel.org; Thu, 27 Jul 2006 04:33:18 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060725)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24273>

This is a multi-part message in MIME format.
--------------050402020604080609090704
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: Robert Shearman <rob@codeweavers.com>
---
  git-rebase.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

--------------050402020604080609090704
Content-Type: text/x-patch;
 name="3bd88862ba13448b574662ffda717b96ddab8e98.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3bd88862ba13448b574662ffda717b96ddab8e98.diff"

diff --git a/git-rebase.sh b/git-rebase.sh
index 5554541..1c23798 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -283,7 +283,7 @@ # If the $onto is a proper descendant of
 # we just fast forwarded.
 if test "$mb" = "$branch"
 then
-	echo >&2 "Fast-forwarded $branch to $newbase."
+	echo >&2 "Fast-forwarded $branch_name to $onto_name."
 	exit 0
 fi
 


--------------050402020604080609090704--
