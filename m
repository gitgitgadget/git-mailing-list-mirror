From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] glossary-content.txt: rephrase magic signature part
Date: Fri,  6 Dec 2013 14:30:47 +0700
Message-ID: <1386315049-19097-2-git-send-email-pclouds@gmail.com>
References: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 08:26:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vopnm-0005E8-Fc
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 08:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab3LFH0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Dec 2013 02:26:14 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:62265 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3LFH0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 02:26:12 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so574979pbc.12
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 23:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uHo1+yi4YnthtylNeW6SB3cktCM+uAXiulIjy4XzGN4=;
        b=FyHnySLYf7Nr39rlnGkwiU161QcF3Hl9pK6FrZuTw4kL/nevaCYWZ+bxSSxkaUTjNg
         KLVmUW/8jKsASTkKZ4rrnyRBVRUOlxW6oxLpckWuNaqkVfGPbF8oPcGTKXHnoACgRpsC
         gO6SMyu0euxKellV2zij7AMPYcUWo63dWxXt4v7HigJppclZ5nXMi/QdasBuZV0MQf8f
         uSn65L6Fcyk8bdjfuEjzco1xewlk2JWPiiXz94hg30JTH24s4aWYMwEBmxJrzfPtqJfj
         w6POzZ6dPcBN0D5HvDAm8H9v30hC+4J4ly5v4ekdANYZTJVCWWWLnn/WLePmcd+rO0IZ
         BCHQ==
X-Received: by 10.68.197.73 with SMTP id is9mr2388717pbc.75.1386314771750;
        Thu, 05 Dec 2013 23:26:11 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id jn12sm108214381pbd.37.2013.12.05.23.26.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 23:26:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Dec 2013 14:30:56 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238926>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/glossary-content.txt | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index aa1c888..b7e7ab5 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -323,24 +323,26 @@ including Documentation/chapter_1/figure_1.jpg.
 A pathspec that begins with a colon `:` has special meaning.  In the
 short form, the leading colon `:` is followed by zero or more "magic
 signature" letters (which optionally is terminated by another colon `:=
`),
-and the remainder is the pattern to match against the path. The option=
al
-colon that terminates the "magic signature" can be omitted if the patt=
ern
-begins with a character that cannot be a "magic signature" and is not =
a
-colon.
+and the remainder is the pattern to match against the path.
+The "magic signature" consists of ASCII symbols that are neither
+alphanumeric, glob, regex special charaters nor colon.
+The optional colon that terminates the "magic signature" can be
+omitted if the pattern begins with a character that does not belong to
+"magic signature" symbol set and is not a colon.
 +
 In the long form, the leading colon `:` is followed by a open
 parenthesis `(`, a comma-separated list of zero or more "magic words",
 and a close parentheses `)`, and the remainder is the pattern to match
 against the path.
 +
-The "magic signature" consists of an ASCII symbol that is not
-alphanumeric.
+A pathspec with only a colon means "there is no pathspec". This form
+should not be combined with other pathspec.
 +
 --
-top `/`;;
-	The magic word `top` (mnemonic: `/`) makes the pattern match
-	from the root of the working tree, even when you are running
-	the command from inside a subdirectory.
+top;;
+	The magic word `top` (magic signature: `/`) makes the pattern
+	match from the root of the working tree, even when you are
+	running the command from inside a subdirectory.
=20
 literal;;
 	Wildcards in the pattern such as `*` or `?` are treated
@@ -378,13 +380,6 @@ full pathname may have special meaning:
 +
 Glob magic is incompatible with literal magic.
 --
-+
-Currently only the slash `/` is recognized as the "magic signature",
-but it is envisioned that we will support more types of magic in later
-versions of Git.
-+
-A pathspec with only a colon means "there is no pathspec". This form
-should not be combined with other pathspec.
=20
 [[def_parent]]parent::
 	A <<def_commit_object,commit object>> contains a (possibly empty) lis=
t
--=20
1.8.5.1.25.g8667982
