From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/14] completion: update 'git reset' new stage options
Date: Mon, 14 Oct 2013 17:29:15 -0500
Message-ID: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 00:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqjn-0006uM-25
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab3JNWfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:35:39 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:46742 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848Ab3JNWfi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:35:38 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so5296829obc.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=V2KH7oer/ihLfsPstCXI2OuuhBMmCAvIzRVCaM3Gbxw=;
        b=QkxN3c94EbGxLs/OcEpONzahAGN59J4BPtrBEyQ5GBXd6a9ztfpkNLamxBhnnHxQ1T
         54sbn1puTQMsDle6qIVizaxW01pOWvnjtksox2KyDd5vsRkxD1VJj/VwwzgU7aXHLeBo
         EpPCQEPWWtOJ5z2h/0LLYkeWEHaSxyCP2I1zKmAe38bKOLeFuiv2hffwLmN+B6Nlg8B2
         WwhVDi6v5MoRUnHHpQiCHSe2HfTn/Bum1KKX2NfuS3cK1C60wi6P6LtljN/BzCDNhNRw
         BbbMYUPZGAKR8bmxWOR8ZKZFgt3O5wvSt9/pLEP1iFPXbaLCydNIVYVSgVoKkHBXsKI0
         0kNA==
X-Received: by 10.60.42.203 with SMTP id q11mr2729623oel.54.1381790138156;
        Mon, 14 Oct 2013 15:35:38 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm6055908obo.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:35:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236127>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1dde51f..082f207 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2231,7 +2231,8 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+		__gitcomp "--merge --mixed --hard --soft --patch --keep --merge
+			--stage --no-stage --work --no-work"
 		return
 		;;
 	esac
-- 
1.8.4-fc
