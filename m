From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] Documentation: fix missing text for rev-parse --verify
Date: Tue, 22 Jul 2014 23:38:11 +0000
Message-ID: <1406072291-99812-1-git-send-email-sandals@crustytoothpaste.net>
References: <20140721233554.GC5616@vauxhall.crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 01:38:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9jdY-00082Y-SR
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 01:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757032AbaGVXiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 19:38:21 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49033 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215AbaGVXiU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jul 2014 19:38:20 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 98D6A2808E;
	Tue, 22 Jul 2014 23:38:19 +0000 (UTC)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <20140721233554.GC5616@vauxhall.crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254051>

The caret (^) is used as a markup symbol in AsciiDoc.  Due to the
inability of AsciiDoc to parse a line containing an unmatched caret, it
omitted the line from the output, resulting in the man page missing the
end of a sentence.  The rest of the documentation uses backticks
whenever a caret is encountered in running text, so do the same here.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-rev-parse.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 9bd76a5..074030f 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -102,7 +102,7 @@ eval "set -- $(git rev-parse --sq --prefix "$prefix" "$@")"
 +
 If you want to make sure that the output actually names an object in
 your object database and/or can be used as a specific type of object
-you require, you can add "^{type}" peeling operator to the parameter.
+you require, you can add "`^{type}`" peeling operator to the parameter.
 For example, `git rev-parse "$VAR^{commit}"` will make sure `$VAR`
 names an existing object that is a commit-ish (i.e. a commit, or an
 annotated tag that points at a commit).  To make sure that `$VAR`
-- 
2.0.1
