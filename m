From: =?utf-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>
Subject: [PATCH] added a test frame for git-svn-externals.sh
Date: Fri, 29 Aug 2008 03:02:59 +0300
Message-ID: <1219968179-14156-3-git-send-email-eddy.petrisor@gmail.com>
References: <60381eeb0808281702q3dc7543enff2b35ebbcc80d08@mail.gmail.com>
 <1219968179-14156-1-git-send-email-eddy.petrisor@gmail.com>
 <1219968179-14156-2-git-send-email-eddy.petrisor@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eddy Petrisor <eddy@epetrisor.dsd.ro>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 02:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrTK-0003cd-Oj
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYH2ADJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:03:09 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbYH2ADI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:03:08 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:29494 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbYH2ADG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:03:06 -0400
Received: by fk-out-0910.google.com with SMTP id 18so408964fkq.5
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 17:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0OucO+tgnoW5JsBwMPxA+SoNgn58Tgg8+xtmpkm7oZ0=;
        b=pEe84Yi+uJf/OjZbgISD73afxohIYy3hygPf9387P4YmT6Aj6GM/FTRIRIe8qZ8Ko/
         Mqx6imJ4Rov0hCHLRloq1oM+VTH601QJBfN8h05kCFL8ZncAQb32DQ90hrVRZkyVxTOS
         cmNVMlhca7xtVB9aFAfUZ/2S3BgL1iMcHA1sU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VyhDgCf3aLthvPQg7PkQJb+jMIrscZq/ygRAYoy6NUh44EKFST+fZ256co2jl3pWcm
         QooJBuB/PntKrgjLrBzNJiTOFNqWxRZLcwiUyShWs6HP2YmD9WRYyySYSKOB9hCm8JP9
         GCQoUiQiFUqpi1mBNKGN0i/EvFhWHPWi457Xw=
Received: by 10.181.4.17 with SMTP id g17mr2925033bki.67.1219968185582;
        Thu, 28 Aug 2008 17:03:05 -0700 (PDT)
Received: from eddy.petrisor@gmail.com ( [78.97.158.176])
        by mx.google.com with ESMTPS id 28sm1371160fkx.1.2008.08.28.17.03.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Aug 2008 17:03:04 -0700 (PDT)
Received: by eddy.petrisor@gmail.com (sSMTP sendmail emulation); Fri, 29 Aug 2008 03:03:07 +0300
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219968179-14156-2-git-send-email-eddy.petrisor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94223>

=46rom: Eddy Petrisor <eddy@epetrisor.dsd.ro>

---
 t/t9130-git-svn-externals-fetch.sh |   76 ++++++++++++++++++++++++++++=
++++++++
 t/t9130/clean.dump                 |   74 ++++++++++++++++++++++++++++=
+++++++
 2 files changed, 150 insertions(+), 0 deletions(-)
 create mode 100755 t/t9130-git-svn-externals-fetch.sh
 create mode 100644 t/t9130/clean.dump

diff --git a/t/t9130-git-svn-externals-fetch.sh b/t/t9130-git-svn-exter=
nals-fetch.sh
new file mode 100755
index 0000000..70335ad
--- /dev/null
+++ b/t/t9130-git-svn-externals-fetch.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Eddy Petri=C8=99or
+
+
+test_description=3D'git svn properties pulls and updates externals'
+. ./lib-git-svn.sh
+
+test_expect_success 'load repository with base directory' '
+	svnadmin load -q "$rawsvnrepo" < ../t9130/clean.dump
+	'
+
+test_expect_success 'checkout the simple repo' '
+	mkdir -p gitrepo &&
+	(
+		cd gitrepo &&
+		git svn init "$svnrepo/trunk" &&
+		git svn fetch &&
+		cd ..
+	)
+	'
+
+test_expect_success 'add an external in the repo' '
+	svn checkout "$svnrepo/trunk" work.svn &&
+	(
+		cd work.svn &&
+		svn propset svn:externals "external $(echo $svnrepo|sed "s#\ #%20#")=
/external" . &&
+		svn commit -m "added external directory to repo" &&
+		svn update &&
+		cd .. &&
+		rm -fr work.svn
+	)
+	'
+
+test_expect_success 'git svn fetch the property changes and fetch exte=
rnals' '
+	cd gitrepo &&
+	git svn rebase &&
+	git svn show-externals | grep -q "^/external" &&
+	git svn-externals &&
+	cd ..
+	'
+
+test_expect_success 'create an external pinned to a version' '
+	svn checkout "$svnrepo/trunk" work.svn &&
+	(
+		cd work.svn &&
+		svn propset svn:externals "external -r2 $(echo $svnrepo|sed "s#\ #%2=
0#")/external" . &&
+		svn commit -m "pin the external to -r2" &&
+		svn update &&
+		cd .. &&
+		rm -fr work.svn
+	) &&
+	svn checkout "$svnrepo/external" ext.svn &&
+	(
+		cd ext.svn &&
+		echo "0" > externalfile &&
+		svn commit -m "mark the bad floating revision for the external" &&
+		cd .. &&
+		rm -fr ext.svn
+	)
+	'
+
+test_expect_failure 'refresh revisioned externals in git' '
+	cd gitrepo &&
+	git config --list >> /tmp/test &&
+	git svn rebase &&
+	git svn-externals &&
+	grep 1 external/externalfile &&
+	cd ..
+	'
+
+#TODO: add test_expect_success for a URI change for the external
+
+
+
+test_done
diff --git a/t/t9130/clean.dump b/t/t9130/clean.dump
new file mode 100644
index 0000000..9e26b66
--- /dev/null
+++ b/t/t9130/clean.dump
@@ -0,0 +1,74 @@
+SVN-fs-dump-format-version: 2
+
+UUID: 13066bdd-4590-4b1e-8a3f-4379dfa77d1b
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2008-07-10T11:26:12.351202Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 125
+Content-length: 125
+
+K 7
+svn:log
+V 26
+bare structure of the repo
+K 10
+svn:author
+V 4
+eddy
+K 8
+svn:date
+V 27
+2008-07-10T11:31:04.711302Z
+PROPS-END
+
+Node-path: external
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: external/externalfile
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 2
+Text-content-md5: b026324c6904b2a9cb4b88d6d61c81d1
+Content-length: 12
+
+PROPS-END
+1
+
+
+Node-path: trunk
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: trunk/dummyfile
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 1
+Text-content-md5: 68b329da9893e34099c7d8ad5cb9c940
+Content-length: 11
+
+PROPS-END
+
+
+
--=20
1.5.6.3
