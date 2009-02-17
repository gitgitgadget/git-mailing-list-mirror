From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 01/10] config: Codestyle cleanups.
Date: Tue, 17 Feb 2009 15:52:47 +0200
Message-ID: <1234878776-13250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 14:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPA-0001cz-A0
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbZBQNxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbZBQNxE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:04 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:39281 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZBQNxC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:02 -0500
Received: by ey-out-2122.google.com with SMTP id 25so368922eya.37
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 05:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xdDTY8tKE0QJDNph4dyi2d7ltuWN/pRriOlL8lTt2+Q=;
        b=bNZjqjC2Gh7H90uWkZ9bdpftTqZDq7aDk5hdft1bxg8tqhw6S1X5B/PwMtl4W5RYty
         xQ4GNY7vyH3357ie+bXBdmQjunQ7mqxpV6fNl2Bp43njP8ieK7/dBvkCVZPm2IR4wrbb
         6bTt6vgEO2J7PGHOpd1vBlhaJHK0h5bexC7+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=quIvqxjGNzKKNaM9dW/hjdgCjVM1hFW/ubQofX40kjgywPUcPKdUajfqHiy1rw24+8
         hXTv8F4XhHkw89VUesXMUbCKGV3ZsYwgE/gjeeZxKArfye2u8pKZWGop7hsb9zu6HB0q
         GCu3bA8+jViU4b0kORPLj78AYy/cRrz8yMRQ8=
Received: by 10.210.36.8 with SMTP id j8mr1714496ebj.120.1234878780588;
        Tue, 17 Feb 2009 05:53:00 -0800 (PST)
Received: from localhost (net-63.nrpn.net [192.89.6.63])
        by mx.google.com with ESMTPS id u14sm6717992gvf.31.2009.02.17.05.52.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 05:52:59 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110370>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-config.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 6937eaf..afc4393 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -27,7 +27,7 @@ static int show_all_config(const char *key_, const char *value_, void *cb)
 	return 0;
 }
 
-static int show_config(const char* key_, const char* value_, void *cb)
+static int show_config(const char *key_, const char *value_, void *cb)
 {
 	char value[256];
 	const char *vptr = value;
@@ -74,7 +74,7 @@ static int show_config(const char* key_, const char* value_, void *cb)
 	return 0;
 }
 
-static int get_value(const char* key_, const char* regex_)
+static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
 	char *tl;
@@ -284,7 +284,7 @@ static int get_colorbool(int argc, const char **argv)
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
-	char* value;
+	char *value;
 	const char *file = setup_git_directory_gently(&nongit);
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
-- 
1.6.1.3
