From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 0/2] Remove foreign SCMs
Date: Thu,  8 May 2014 20:33:21 -0500
Message-ID: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:44:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZrG-0006QD-Gs
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbaEIBoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:44:14 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:61569 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbaEIBoN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:44:13 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so4089730obc.11
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Hcl/fkusYsg+jxeoghQ5T0Fe4XJKLSQxVpUB8fm2k+Y=;
        b=EGrD5QTxiBXzHo/j5KxUPdgGeB1HlTr5Z0Wbxri/qMSh8/AX32K1BCFiwKapyDFBTx
         3j5xPmUuHwKPlmRCzVqxduvZfAAQ9IyvGf9tQdomLr4XmX2gSv8wjqKp1LVAIAIhB1zU
         F7OHAKEe2q4AiYu/23RGldLlaxall28zlk0yOdfnLhAY/jCHYrAUjayHaxKvMXNIZqua
         ARWFwJgL58uQftk7yBmNTQX2XkFVjkl9Kb1t5ddOUuX4v9BGcHc3PEzIfdg4OMUMlxH2
         4f6kfmcjDhFkBijaqsy4s40BTMrcJj3nxmwMzkJ/w7awIOIn4J/jdqpD2d8ot2c8G+TD
         sn1w==
X-Received: by 10.60.141.9 with SMTP id rk9mr9641293oeb.12.1399599853541;
        Thu, 08 May 2014 18:44:13 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm10909042oec.0.2014.05.08.18.44.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:44:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248491>

Both `git archimport` and `git quiltimport` haven't really been maintained, and
they don't even have tests.

There are tools in the contrib/ area that do have tests and are actively
maintained, and they don't gradauate to the core.

Let's not have double standards and remove these unused tools.


Felipe Contreras (2):
  Remove 'git archimport'
  Remove 'git quiltimport'

 .gitignore                        |    2 -
 Documentation/git-archimport.txt  |  112 ----
 Documentation/git-quiltimport.txt |   54 --
 Makefile                          |    2 -
 command-list.txt                  |    2 -
 git-archimport.perl               | 1134 -------------------------------------
 git-quiltimport.sh                |  139 -----
 git.spec.in                       |   10 +-
 8 files changed, 3 insertions(+), 1452 deletions(-)
 delete mode 100644 Documentation/git-archimport.txt
 delete mode 100644 Documentation/git-quiltimport.txt
 delete mode 100755 git-archimport.perl
 delete mode 100755 git-quiltimport.sh

-- 
1.9.2+fc1.27.gbce2056
