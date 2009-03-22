From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/8] docbook: radical style change
Date: Sun, 22 Mar 2009 20:05:16 +0200
Message-ID: <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlS5e-0000xY-Lb
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 19:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbZCVSFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 14:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbZCVSFp
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 14:05:45 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64244 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264AbZCVSFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 14:05:44 -0400
Received: by fxm2 with SMTP id 2so1504733fxm.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0VnWJu2yUDbzl2VRJSqLiyjinvfpCQw0ljKuqvU6Ck0=;
        b=omL4xgRieTy87CjH/ohE59j+jBH7K99L8Jovcpzkuuf/fSBnR2xOYvAndgeyR0mZnq
         +ggsn5C373XLl7wDz/7C5y+XGDe1k3YICvyXdlQDO/OR/oIQkEslVLMJNOe54JUh/kou
         O7MHehLDdEGzcpHuqM/sgSBvxvByonMDDcqOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MUv44Ese4ZX/aV2ONNxm3iPu7cYBbYZfn2TG1sVD4yoV28jJXk4nKWnlbpvHkUEoH6
         PvFXZLFXskr/RA+m3/KIHVAe1/pNTci+0eTkfpR1YDZ8VOMt++sZ5JgCjQNJY0bgSjS6
         cRrQj0JOnss3XdslOAeOXvNdlLETCnn5ECe28=
Received: by 10.223.126.10 with SMTP id a10mr5269553fas.17.1237745141622;
        Sun, 22 Mar 2009 11:05:41 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id p9sm6235324fkb.21.2009.03.22.11.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 11:05:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.352.gae594
In-Reply-To: <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114159>

Use smaller 'sans-serial' font. Sans-Serial fonts are supposed to be
easier to read in screens. This format is similar to the one of
Wikipedia.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/docbook-xsl.css |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/docbook-xsl.css b/Documentation/docbook-xsl.css
index ce61402..b494987 100644
--- a/Documentation/docbook-xsl.css
+++ b/Documentation/docbook-xsl.css
@@ -15,7 +15,9 @@ body blockquote {
 
 html body {
   margin: 1em 5% 1em 5%;
-  line-height: 1.2;
+  line-height: 1em;
+  font-family: sans-serif;
+  font-size: small;
 }
 
 body div {
-- 
1.6.2.1.352.gae594
