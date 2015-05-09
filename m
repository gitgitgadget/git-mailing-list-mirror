From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v5 5/6] new-command.txt: mention the common command groups
Date: Sat,  9 May 2015 19:17:35 +0200
Message-ID: <1431191856-10949-6-git-send-email-sebastien.guimmara@gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 19:18:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yr8Ot-0000h3-EU
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 19:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbbEIRSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 May 2015 13:18:51 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:32842 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbEIRSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 13:18:50 -0400
Received: by wief7 with SMTP id f7so56941973wie.0
        for <git@vger.kernel.org>; Sat, 09 May 2015 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HlAWZRSiEtRVCQXTA+NrELirRT/rSfFFqvMYrPddCM8=;
        b=O0J9bAuXngGC9Kaq10FqeeYgIZbXjA57hcZdixTWjBd++15vDE/wlce6R5cC6W46dC
         VmYm+3XabNHWRqeCVVfLCLi/HTdMJkNyJgYxYom8m+/4wRulnicWFx7wPg4wUWIGOq2q
         raYT4hXMyy/Ole0uLDiRk4hRYZRXdYrV9EkUd8S0tpHp/vVCIbaSvJCO0C7JqtmODZTb
         hCpL78jjLJkc9lvwx+VEks7XdtOxtzyY9djp34is3wdfrYWzuA0l4N78kQEvKOS4TopL
         Kt5j5uyMM30fTSAdQXR5DXXLCk6ivFNcl5xdyiqUTKjhaVFRVlbo5a+LIPtxbVtZ/PDX
         ORxw==
X-Received: by 10.180.84.201 with SMTP id b9mr6032857wiz.28.1431191929536;
        Sat, 09 May 2015 10:18:49 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fo7sm4710675wic.1.2015.05.09.10.18.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 May 2015 10:18:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268706>

In the 6. step, add information about the common group commands
found in command-list.txt.

Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Documentation/howto/new-command.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/=
new-command.txt
index d7de5a3..e7b0cc2 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
 that categorizes commands by type, so they can be listed in appropriat=
e
 subsections in the documentation's summary command list.  Add an entry
 for yours.  To understand the categories, look at git-commands.txt
-in the main directory.
+in the main directory. If the new command is part of the typical Git
+workflow and you believe it's common enough to be mentioned in
+'git help', map this command to a common group in the column [common]
=20
 7. Give the maintainer one paragraph to include in the RelNotes file
 to describe the new feature; a good place to do so is in the cover
--=20
2.4.0
