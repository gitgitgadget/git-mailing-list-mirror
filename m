From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/6] transport-helper: update refspec documentation
Date: Wed, 17 Apr 2013 19:05:20 -0500
Message-ID: <1366243524-18202-3-git-send-email-felipe.contreras@gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 02:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScND-0006vl-3u
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935405Ab3DRAGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:06:43 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:60483 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935285Ab3DRAGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:06:42 -0400
Received: by mail-yh0-f44.google.com with SMTP id m1so366852yhg.17
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fwd/qEtmFzDVUNd6wkaYZWi5nQkgQfZojSuz6rrJR5Q=;
        b=BWATsC184IsVeQqN5MO/uvw2Od9thEjOcre6As1Rlknc/dKwqRId8NwIH1XKUSp4QE
         8mqBbqfZBxi7FKALqNijvnCQemi6FDwvakMUazQsXNU1cN1wYHqVk0mpGSW2i4HAZJ/Z
         HnqQJwajje7Xnt+QIW+oJWn44xxNmyeNnuNIFffE5uMV8/EBZZjtQcWwegD9Y4J4I0q8
         KvHV+qPSAgPeXJeHCSuDPvnhHXZSiYrWzLkkBClnL58lPaIwcEXxXVIn3hpDnZOF+66j
         zSUhMDkBIxgk5n5bsVEnyRfHLiqvHG0aaAlMv//ONLurVuxDHeUeRP+7Ks4lD8vIuElI
         jU+Q==
X-Received: by 10.236.170.131 with SMTP id p3mr5802809yhl.143.1366243601530;
        Wed, 17 Apr 2013 17:06:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id h53sm13106603yhf.0.2013.04.17.17.06.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 17:06:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221589>

The refspec capability is not only used by 'import', also by 'export',
and it's recommend in both.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/gitremote-helpers.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 0c91aba..ba7240c 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -159,11 +159,11 @@ Miscellaneous capabilities
 	carried out.
 
 'refspec' <refspec>::
-	This modifies the 'import' capability, allowing the produced
-	fast-import stream to modify refs in a private namespace
-	instead of writing to refs/heads or refs/remotes directly.
-	It is recommended that all importers providing the 'import'
-	capability use this.
+	For remote helpers that implement 'import' or 'export', this capability
+	allows the refs to be constrained to a private namespace, instead of
+	writing to refs/heads or refs/remotes directly.
+	It is recommended that all importers providing the 'import' or 'export'
+	capabilities use this.
 +
 A helper advertising the capability
 `refspec refs/heads/*:refs/svn/origin/branches/*`
-- 
1.8.2.1.679.g509521a
