From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/9] git-rev-parse.txt: clarify --git-dir
Date: Mon,  1 Nov 2010 13:26:26 +0700
Message-ID: <1288592794-24221-1-git-send-email-pclouds@gmail.com>
References: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 07:26:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCnqx-0001dB-NO
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 07:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab0KAG0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 02:26:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39991 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0KAG0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 02:26:38 -0400
Received: by gwj21 with SMTP id 21so2954107gwj.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=foF3UVkcoarFYpb/Qsluh07e3gWJJWYYQ6sm48WgjLE=;
        b=rppFkP7u4VYYjzlknktNOtIaLbfQ4iYgnbxGoqYCjZOvIwqmYle12gAUFr5bdA0VbI
         bIkcB1rJC51I/Vq7iwIj/1+zR66+NuOjS6mighT+2uHpqTAZQXJL3ZLygXD1TivMqDQl
         3sw3AG2tbMGImCRcsJV7OqKohJd0Az5lIEtbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=plVnjNTPLy+TKY/onuyou8Vo543KlyvcAi4h1FuV54TVYsNUjcDyWtZD0vRa8ej42X
         GsrvpYZEhLZunYh353SJrLdzYE+JEG4+LrpoXHEDJGhnmdpRab2rcE4HXWIltBinR6Sj
         AORDM0eopmvzmg4oZlDB+g55QBKxOsfgNOK/I=
Received: by 10.151.147.12 with SMTP id z12mr1104867ybn.258.1288592797433;
        Sun, 31 Oct 2010 23:26:37 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id i2sm4939493yha.31.2010.10.31.23.26.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 23:26:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 01 Nov 2010 13:26:36 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160458>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

The current behavior is often to print an absolute path rather than
a ../../etc string, but callers must be ready to accept a relative
path, too. The most common output is ".git" (from the toplevel of
an ordinary work tree).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2010/10/30 Sverre Rabbelier <srabbelier@gmail.com>:
 > Heya,
 >
 > 2010/10/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>:
 >> This helps break things some more. Eventually all repo setup logic
 >> should be centralized in setup_* functions. This helps push all the
 >> bugs back to setup_* functions.
 >
 > I don't know about this, do we really want to willingly break the te=
st
 > suite (and fixing it later)? Perhaps we can review this as-is and th=
en
 > squash the commits before they are merged to next so that there is n=
o
 > breakage? We could even attach the original commits as notes :).

 OK. Take 2. I think it is bisectable this time. This replaces
 35-42 (the fixing part, no need to resend 34 unchanged patches). More =
notes
 on each patch.

 Documentation/git-rev-parse.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 341ca90..a41f024 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -136,7 +136,12 @@ appending `/{asterisk}`.
 	directory (typically a sequence of "../", or an empty string).
=20
 --git-dir::
-	Show `$GIT_DIR` if defined else show the path to the .git directory.
+	Show `$GIT_DIR` if defined. Otherwise show the path to
+	the .git directory, relative to the current directory.
++
+If `$GIT_DIR` is not defined and the current directory
+is not detected to lie in a git repository or work tree
+print a message to stderr and exit with nonzero status.
=20
 --is-inside-git-dir::
 	When the current working directory is below the repository
--=20
1.7.3.2.210.g045198
