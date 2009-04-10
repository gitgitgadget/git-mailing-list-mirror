From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] gittutorial: Add global color.ui
Date: Fri, 10 Apr 2009 14:16:22 +0200
Message-ID: <20090410141622.10e40448@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 14:19:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsFh4-0002kr-Mm
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 14:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935986AbZDJMQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 08:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763554AbZDJMQa
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 08:16:30 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47401 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936005AbZDJMQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 08:16:29 -0400
Received: by fxm2 with SMTP id 2so1021698fxm.37
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 05:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=P81za9mYADx83OMZQpHff0uLSjvsQwz8scd8GQ4dtSM=;
        b=wQi9KiUzHmBc08zcne+HfZkqBrRRVwPvOl5KHQM/MvB6zXDpi0xDNYWdlUO+U0MQRq
         jrSLq6KUhTtJJGXg4ZcY4DXRBLksxz5PfKl+651GSdMLGeL0LRn5eVZ73l42qgAWLwcd
         cn03WK88DHBTW3L7iUYLPLbfJN4kyt04ckXhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=Fv1bGyglabjxQD/WSYAsClU2THGg75m3wjcivMZAP74JQ7Vx6gkNuNyZQFjVSLhmY6
         2Wdaa7rHe7ia2INMmYBhfzIovUyNV9kKIY8XC3yPf+ov3F4Ym2gqdgpnpWKbALrVmMOx
         3xEPqCLh3hJszDFPEMbztVTbaYglkaLqINpo4=
Received: by 10.103.225.11 with SMTP id c11mr1816987mur.24.1239365785807;
        Fri, 10 Apr 2009 05:16:25 -0700 (PDT)
Received: from paolo-desktop (host245-74-dynamic.4-87-r.retail.telecomitalia.it [87.4.74.245])
        by mx.google.com with ESMTPS id y6sm2929771mug.27.2009.04.10.05.16.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Apr 2009 05:16:25 -0700 (PDT)
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116255>

I consider color.ui so important that I think it deserves to be mentioned in the gittutorial document.
Patch is against pu.

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 Documentation/gittutorial.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index c5d5596..6748fda 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -44,6 +44,14 @@ $ git config --global user.name "Your Name Comes Here"
 $ git config --global user.email you@yourdomain.example.com
 ------------------------------------------------
 
+This will make prettier the output of certain commands such as `git diff`
+and `git branch`:
+
+------------------------------------------------
+$ git config --global color.ui auto
+------------------------------------------------
+
+
 
 Importing a new project
 -----------------------
-- 
1.6.2.2.485.ge37347
