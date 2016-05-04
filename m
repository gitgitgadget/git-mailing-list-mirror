From: larsxschneider@gmail.com
Subject: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed,  4 May 2016 10:38:35 +0200
Message-ID: <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
 <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 10:38:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsKX-0006fz-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735AbcEDIip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:38:45 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36941 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757720AbcEDIil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:38:41 -0400
Received: by mail-wm0-f44.google.com with SMTP id a17so80363068wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qURnA9YK6xzYWyxeTK+lhXP52g+QFD6jU25C3ceo4k0=;
        b=jjnENYMP3PyqAJcGpQpYTa6e1tkDUhgbOWW+ou0CXRVPDDRcCFxGTmS99rmcoJxKfh
         5JRo4fFGZPzXWid1G440iMY92OwZdrNytOzz80VCgC1zBUF15a8NGpRW0VvOINbBFLIt
         J2Ceip4tvys+QD98kl87OrDuDIbWDNBQAq9idmPmbM8Es+4FG28oAOM+PPqlycEnh1LO
         o8anPXnr6ocyB3fmqRtT+uFrb6y0qBroiQWrwfGZx3DXCRIh7pTpNtUMvnxslaFrwTzu
         Nc1SSEjpgpJN6wyzNzdmkk/YDOLVmjlGUf9GXFfXNR72rhjVtqtrsdxCFZq8+vKgE6QU
         cPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qURnA9YK6xzYWyxeTK+lhXP52g+QFD6jU25C3ceo4k0=;
        b=FrAxHoy0t95BpBOv/GixXYrjF8tyhgI0nD2zXqReqX+b1aDqVXUd/FIzuC7U3JOlqt
         /ZlhDxVaFwfJzlx5yw71O019uY7sYZUT58ePce3QpskmBfSZacTfpqE+9nqv6Xz2ukyB
         Z7GNyGPOwGdqsR1zkQDolIaRjMew2P4kQdKewi1ypXpr3/aNlwFpDD5EPWkx0hhJRiJz
         Y5wD0f3ElQt4n9E0tqKAjnh5BALZ6h1G+26NkM8eGmnyQUkNLbljirkd9sNCJQQzPtdc
         X7ZDloo2yRPkOhKMqqQjWMZczw9jVcdZvbQcszjOLoFVX0JQ3wpYqTwXprpXUt/4o7BA
         Qihw==
X-Gm-Message-State: AOPr4FUTjEOzDmHy6shWwZ1I7NU5iLXG0ms5f29qs5cIklphFNBNSYELIg/Ts0qIDE/CeQ==
X-Received: by 10.28.16.136 with SMTP id 130mr7982515wmq.23.1462351120230;
        Wed, 04 May 2016 01:38:40 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB740E.dip0.t-ipconnect.de. [93.219.116.14])
        by smtp.gmail.com with ESMTPSA id d23sm2983014wmd.1.2016.05.04.01.38.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 04 May 2016 01:38:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293521>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/config.txt            | 4 ++--
 Documentation/git-check-ignore.txt  | 2 +-
 Documentation/git-filter-branch.txt | 4 ++--
 Documentation/git-for-each-ref.txt  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c7bbe98..5683400 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1494,7 +1494,7 @@ gui.diffContext::
 	made by the linkgit:git-gui[1]. The default is "5".
 
 gui.displayUntracked::
-	Determines if linkgit::git-gui[1] shows untracked files
+	Determines if linkgit:git-gui[1] shows untracked files
 	in the file list. The default is "true".
 
 gui.encoding::
@@ -1665,7 +1665,7 @@ http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
-	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
+	the Netscape/Mozilla cookie file format (see `curl(1)`).
 	NOTE that the file specified with http.cookieFile is only used as
 	input unless http.saveCookies is set.
 
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index e94367a..9a85998 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -112,7 +112,7 @@ EXIT STATUS
 SEE ALSO
 --------
 linkgit:gitignore[5]
-linkgit:gitconfig[5]
+linkgit:git-config[5]
 linkgit:git-ls-files[1]
 
 GIT
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 73fd9e8..6538cb1 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -205,8 +205,8 @@ to other tags will be rewritten to point to the underlying commit.
 Remap to ancestor
 ~~~~~~~~~~~~~~~~~
 
-By using linkgit:rev-list[1] arguments, e.g., path limiters, you can limit the
-set of revisions which get rewritten. However, positive refs on the command
+By using linkgit:git-rev-list[1] arguments, e.g., path limiters, you can limit
+the set of revisions which get rewritten. However, positive refs on the command
 line are distinguished: we don't let them be excluded by such limiters. For
 this purpose, they are instead rewritten to point at the nearest ancestor that
 was not excluded.
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c52578b..d9d406d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -179,7 +179,7 @@ returns an empty string instead.
 
 As a special case for the date-type fields, you may specify a format for
 the date by adding `:` followed by date format name (see the
-values the `--date` option to linkgit::git-rev-list[1] takes).
+values the `--date` option to linkgit:git-rev-list[1] takes).
 
 
 EXAMPLES
-- 
2.5.1
