From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Remove gitweb/test/ directory
Date: Sat, 31 May 2008 20:28:18 +0200
Message-ID: <20080531182555.1646.47950.stgit@localhost.localdomain>
References: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 20:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2VpP-00005I-91
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 20:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbYEaS21 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 May 2008 14:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbYEaS21
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 14:28:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:25383 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbYEaS20 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 14:28:26 -0400
Received: by nf-out-0910.google.com with SMTP id d3so190400nfc.21
        for <git@vger.kernel.org>; Sat, 31 May 2008 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=yGT9GteNmNBywGqOJgU43O1fvJUdXxtfYNJZKT1LRQo=;
        b=ojDOhBAIDF1o/vkC9F6traAO4vY5G2INEC1B0rgIvhFuzHyPvz3Qm+9avCULvIk1RNdExuHtybTqrCZWYlYcXx1cNyju10YcmYM7l0gpHZQwm94NqrPEqAiwob9Wz1cMF//o8V8qkHepC+CvkyjJkWOFHypK958mA5bMz/e5NDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=j8Ogd/i9dGytkEk6L8+lrY+L0lavGF+4IPI0uYwyR++nVImW4YBhjLMrf55rSBkGeWXPJ1X/MdXL3OYXSVN4iwk4cK1oT5+4CcrrqLLr8AgtK8pB5FhpcbmLn1exqamS645lTFAb4l5Uylm8hBYk3EJYjoau2/NiXT+L9N4Fef8=
Received: by 10.210.68.17 with SMTP id q17mr2187236eba.31.1212258504672;
        Sat, 31 May 2008 11:28:24 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.204.14])
        by mx.google.com with ESMTPS id 31sm13354642nfu.9.2008.05.31.11.28.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 11:28:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4VISJlJ001691;
	Sat, 31 May 2008 20:28:19 +0200
In-Reply-To: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83399>

Testing if gitweb handles filenames with spaces, filenames with plus
sign ('+') which encodes spaces in CGI parameters (in URLs), and
filenames with Unicode characters should be handled by gitweb tests.

Those files are remainder of the time when gitweb was project on its
own, not a part of git (with its testsuite).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Sat, 31 May 2008 19:37:48 +0200, Steffen Prohaska wrote:
> On May 29, 2008, at 4:58 PM, Wincent Colaiuta wrote:
>
[...]
>> If the powers that be will accept a change that removes M=E4rchen I'=
ll =20
>> be more than happy to whip up a patch.
>=20
> Unicode normalization is tested in t/t0050-filesystem.sh, which
> reports on HFS+:
>=20
> *   still broken 8: rename (silent unicode normalization)
> *   still broken 9: merge (silent unicode normalization)
>=20
> I believe there is no value in keeping gitweb/test/M=E4rchen for the
> reason of testing HFS+, so I vote for removing it, unless there
> is another good reason for keeping it.

So here it is, the patch to remove offending file; well: the whole
gitweb/test/ directory.=20

 "gitweb/test/M\303\244rchen" |    2 --
 gitweb/test/file with spaces |    4 ----
 gitweb/test/file+plus+sign   |    6 ------
 3 files changed, 0 insertions(+), 12 deletions(-)
 delete mode 100644 gitweb/test/M=C3=A4rchen
 delete mode 100644 gitweb/test/file with spaces
 delete mode 100644 gitweb/test/file+plus+sign

diff --git "a/gitweb/test/M\303\244rchen" "b/gitweb/test/M\303\244rchen=
"
deleted file mode 100644
index 8f7a1d3..0000000
--- "a/gitweb/test/M\303\244rchen"
+++ /dev/null
@@ -1,2 +0,0 @@
-M=C3=A4rchen
-M=E4rchen
diff --git a/gitweb/test/file with spaces b/gitweb/test/file with space=
s
deleted file mode 100644
index f108543..0000000
--- a/gitweb/test/file with spaces=09
+++ /dev/null
@@ -1,4 +0,0 @@
-This
-filename
-contains
-spaces.
diff --git a/gitweb/test/file+plus+sign b/gitweb/test/file+plus+sign
deleted file mode 100644
index fd05278..0000000
--- a/gitweb/test/file+plus+sign
+++ /dev/null
@@ -1,6 +0,0 @@
-This
-filename
-contains
-+
-plus
-chars.
