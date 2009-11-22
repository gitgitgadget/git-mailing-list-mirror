From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 3/4] apply: Use the term "working tree" consistently
Date: Sun, 22 Nov 2009 17:20:21 +0100
Message-ID: <4B0964C5.7040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 17:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCFAt-0001wb-FU
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 17:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbZKVQUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 11:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbZKVQUS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 11:20:18 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:6768 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571AbZKVQUR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 11:20:17 -0500
Received: by ey-out-2122.google.com with SMTP id 4so811275eyf.19
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=gj+ajhVgalt++tGdIYmvGP7S9KxKpXc/+ha5ApjITRk=;
        b=rVymgerfesfa5k8U8FGZWJEHwIHTb8WR3FH5d60d7FYjmpUd+Zx5Irlw9dhWrSAbqa
         5+6BcQZ62zNmbShCg6Edhflz59XcKvncGYxF0YN6fQ64h0CCClKTWzTt1YxiBkCL7Hxh
         ARhHm3HtGLpEeyLgDCKm6FR2lzo7erMYtxUIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=qNKtO+RQ7TNVBZkdBmcvgMmuYU7RETWjP2zszuJm3LoZAHk8V+9PO/JXDzA3EfyM8i
         XTRYaqyWLLf8sLtCIQeJrzBRFutxYh8ExvRflzBzMM+tsJJkG2K1lRuQSJFiKPOJRT2U
         tcvICaIYrVmD8Q0nkAzoguPuqY0/7v0F7lKw4=
Received: by 10.213.1.27 with SMTP id 27mr2541274ebd.7.1258906822638;
        Sun, 22 Nov 2009 08:20:22 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 24sm834894eyx.30.2009.11.22.08.20.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 08:20:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133441>

The documentation for 'git apply' uses both the terms
"work tree" and "working tree". Since the glossary uses
the term "working tree", change all occurrences of
"work tree" to "working tree".

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/git-apply.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 6857a68..8349373 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -21,7 +21,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Reads supplied 'diff' output and applies it on a git index file
-and a work tree.
+and a working tree.
=20
 'git-apply' can also be used outside a git repository as long
 as no options that require a git repository are given
@@ -52,7 +52,7 @@ OPTIONS
=20
 --check::
 	Instead of applying the patch, see if the patch is
-	applicable to the current work tree and/or the index
+	applicable to the current working tree and/or the index
 	file and detects errors.  Turns off "apply".
=20
 --index::
@@ -60,7 +60,7 @@ OPTIONS
 	(which is the default when none of the options that
 	disables it is in effect), make sure the patch is
 	applicable to what the current index file records.  If
-	the file to be patched in the work tree is not
+	the file to be patched in the working tree is not
 	up-to-date, it is flagged as an error.  This flag also
 	causes the index file to be updated.
=20
--=20
1.6.5.3.298.g39add
