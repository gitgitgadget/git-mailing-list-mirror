From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH] Documentation/git: add missing info about --git-dir command-line
 option
Date: Wed, 12 Dec 2012 18:04:47 +0100
Message-ID: <50C8B92F.8020408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 18:05:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TipkA-0000Jb-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab2LLRE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:04:57 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48194 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab2LLREz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:04:55 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so3676843wib.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 09:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=OydgyYlATA5GXjbuDnLHTH9m384PquNObCgH3V33qJk=;
        b=tRr4qYNVdco0wDxFosCdlguOfayunWshMWggP254UNfJTRoRNOshvBfbaFSIFAy1bq
         mj2UHzI6CAshVDKGQgdRrrBq2PsSOJBRFp+xAwjkoUmlgGCt+gxWhyTZvwqj1AcsJ+o/
         0/vGANqNXgtgbIsMlO4YLpKro4d4OR/KGMb2Ej1alEiGuTjnq7zaKo7R6BXhi9rhx4ii
         rQQrU8Zxl8lvOQYvuDMWj+ct2/TcxcBygg9cgd09f/FuRAczHfQ3hhZT59wE8BNZ+G7M
         1uwaVUCRlyCuRN2R+F4HUT6XgWz+Pd1C6ENLLY2XgGL5hREQACqP1bXrJp1RDmlRTUEZ
         VwzQ==
Received: by 10.194.118.229 with SMTP id kp5mr3215074wjb.2.1355331894555;
        Wed, 12 Dec 2012 09:04:54 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id bd7sm22051402wib.8.2012.12.12.09.04.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 09:04:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211365>

The Documentation/git.txt file, in the GIT_DIR environment variable
section, did not mentioned that this value can also be set using the
--git-dir command line option.
---
 Documentation/git.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e643683..60db292 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -650,6 +650,7 @@ git so take care if using Cogito etc.
 	If the 'GIT_DIR' environment variable is set then it
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
+	The '--git-dir' command-line option also sets this value.
  'GIT_WORK_TREE'::
 	Set the path to the working tree.  The value will not be
-- 
1.8.0.1.347.gf94c325.dirty
