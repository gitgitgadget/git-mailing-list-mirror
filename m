From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] git config: improve documentation
Date: Tue, 24 Feb 2009 23:59:04 +0200
Message-ID: <1235512745-26814-3-git-send-email-felipe.contreras@gmail.com>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
 <1235512745-26814-2-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 23:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc5L0-0004k8-UZ
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 23:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760501AbZBXV7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760413AbZBXV7a
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:59:30 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:14161 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760283AbZBXV72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:59:28 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1847053fkf.5
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8SuDdKlI2sEou2qY7vQUrq2u9FzJ2VUBr1Wp3/MKnPg=;
        b=r3tjvnin7/r2D8g01MASKjrJr8EkYgQOqRI39S4GGf/n105qNSnCj4T9OM29afwmnm
         mnS+X3eoYxT9qKlIUo2dKrRRKBPtzDGThwg9u29rMhbVDZA8HYwPABvvfz8WZBb+/87V
         Xp09iWSJw/XtclIao3r8sD3lfKKh8Bd4GulcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r/UA+H+ILF/2SrHLZo5INPDd3H1dYta9YTupmFSxkYFErNc7uMNiu4MbsxjomaG7C8
         zyVjlSy/ItCJSiZJcRcDoGFq3XlCi31BopWF6NB8GOo5IofWo3iB/1xEtxnmXt7VWQsr
         FOqOfL7xlJ3TAh3FpHTVCZ3zFm7zGizoIvLXk=
Received: by 10.223.107.9 with SMTP id z9mr172013fao.1.1235512765467;
        Tue, 24 Feb 2009 13:59:25 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id p17sm11328441fka.30.2009.02.24.13.59.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 13:59:25 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235512745-26814-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111352>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-config.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 19a8917..b284611 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -68,7 +68,8 @@ OPTIONS
 
 --add::
 	Adds a new line to the option without altering any existing
-	values.  This is the same as providing '^$' as the value_regex.
+	values.  This is the same as providing '^$' as the value_regex
+	in `--replace-all`.
 
 --get::
 	Get the value for a given key (optionally filtered by a regex
@@ -150,7 +151,7 @@ See also <<FILES>>.
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
 
---get-color name default::
+--get-color name [default]::
 
 	Find the color configured for `name` (e.g. `color.diff.new`) and
 	output it as the ANSI color escape sequence to the standard
-- 
1.6.1.3
