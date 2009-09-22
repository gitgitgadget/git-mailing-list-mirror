From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Update usage string of git-request-pull to match with the version of man help.
Date: Tue, 22 Sep 2009 16:52:19 -0400
Message-ID: <1253652739-13531-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 22:52:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqCLn-0000PA-Iw
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 22:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZIVUwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 16:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbZIVUwa
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 16:52:30 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:31244 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZIVUw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 16:52:29 -0400
Received: by qw-out-2122.google.com with SMTP id 5so46226qwd.37
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=38/I4U7+q7OJSyPEyawpDMKHze6Ostoj2KI4uBJdP7I=;
        b=oE6ifYmYPX7YYY0yHx8t9AbXcQR9l43zCTqYtg1WG6+mrSqW8YgMh16k+3EwKeezEd
         OAkr+53+8mvxto/2iBLvH0J9AvTlwBuDEEFrK7jCGLsyC56P3AwOJvWRlds+nM6d9V1b
         Yq5yOSA+9NP7hL8ZytBBq2ZEqQBsXD+oibeTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PAQpeID0RHogDx2XrjJ32I16cSX+7LOE8abbrtkN1Pg2r6cucHW01nzVz+A4nrrZye
         kR4lU99XVDjqS1yg7A36hFHj8Fkc8xHfYfsayZE0ttKjnIDnmYPPwgSG6C2qMUrp3w5C
         sicLC92wvMaYCW25LhS+i5UXTFR7moEvgMsAU=
Received: by 10.224.82.202 with SMTP id c10mr1252315qal.173.1253652752999;
        Tue, 22 Sep 2009 13:52:32 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 7sm114186qwb.24.2009.09.22.13.52.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Sep 2009 13:52:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.38.gddf44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128958>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 git-request-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 630cedd..727c69e 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -8,7 +8,7 @@ USAGE='<start> <url> [<end>]'
 LONG_USAGE='Summarizes the changes between two commits to the standard output,
 and includes the given URL in the generated summary.'
 SUBDIRECTORY_OK='Yes'
-OPTIONS_SPEC='git request-pull [options] start url [end]
+OPTIONS_SPEC='git request-pull [-p] <start> <url> [<end>]
 --
 p    show patch text as well
 '
-- 
1.6.5.rc1.38.gddf44.dirty
