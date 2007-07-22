From: Xudong Guan <xudong.guan@gmail.com>
Subject: [PATCH] Initial Chinese translation
Date: Sun, 22 Jul 2007 01:08:56 +0100
Message-ID: <11850629362012-git-send-email-xudong.guan@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Xudong Guan <xudong.guan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 02:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICP0k-00073F-2H
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 02:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbXGVAJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 20:09:04 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbXGVAJE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 20:09:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:33886 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbXGVAJB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 20:09:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so877745ugf
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 17:09:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dZkzAl5/0YcZNZH6KlagjszWoHS40rkhb45CN8cBdDQZVKttY4q/DkI2+BEGIon/Edrnq6e13ilzHImRfqmONTljnXrbp3cmNtNSPu15HB/X7syhfQSQNNyBjLWwuVpyV4zIhkaWedW8yhnaTXC8GQeA1Y6JYu8O+AV3fEVy/0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a8Gj0FgyBIjD//T14MLKoSc1V5mS/GpwhEvdmcdx2xwyK+5+zlWWNjHf83rnpMWa15CopN1LZPq8vVivH+OeCjk5yI4C3B4YVeUsUHB6xKvnfwYR+uvrdv3p3nOs5HbKpZC5Op97ucv7sgMFNNzI1glhqxYZJKeY1p/CBAQy5LU=
Received: by 10.67.93.7 with SMTP id v7mr3072201ugl.1185062940056;
        Sat, 21 Jul 2007 17:09:00 -0700 (PDT)
Received: from localhost ( [87.196.148.154])
        by mx.google.com with ESMTPS id z37sm9010458ikz.2007.07.21.17.08.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Jul 2007 17:08:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.0.rc3.81.g8188e
In-Reply-To: 7vr6n2upwv.fsf@assigned-by-dhcp.cox.net
References: 7vr6n2upwv.fsf@assigned-by-dhcp.cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53199>

Simplified Chinese, in UTF-8 encoding.

Signed-off-by: Xudong Guan <xudong.guan@gmail.com>
---
 po/zh.po |  250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 250 insertions(+), 0 deletions(-)
 create mode 100644 po/zh.po

diff --git a/po/zh.po b/po/zh.po
new file mode 100644
index 0000000..bea5e54
--- /dev/null
+++ b/po/zh.po
@@ -0,0 +1,250 @@
+# Translation of git-gui to Chinese
+# Copyright (C) 2007 Shawn Pearce
+# This file is distributed under the same license as the git-gui packa=
ge.
+# Xudong Guan <xudong.guan@gmail.com>, 2007.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2007-07-21 23:46+0100\n"
+"PO-Revision-Date: 2007-07-21 01:23-0700\n"
+"Last-Translator: Xudong Guan <xudong.guan@gmail.com>\n"
+"Language-Team: Chinese\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:1656
+msgid "Repository"
+msgstr "=E7=89=88=E6=9C=AC=E6=A0=91"
+
+#: git-gui.sh:1657
+msgid "Edit"
+msgstr "=E7=BC=96=E8=BE=91"
+
+#: git-gui.sh:1659
+msgid "Branch"
+msgstr "=E5=88=86=E6=94=AF"
+
+#: git-gui.sh:1662 git-gui.sh:1840
+msgid "Commit"
+msgstr "=E6=8F=90=E4=BA=A4"
+
+#: git-gui.sh:1665
+msgid "Merge"
+msgstr "=E5=90=88=E5=B9=B6"
+
+#: git-gui.sh:1666
+msgid "Fetch"
+msgstr "=E5=AF=BC=E5=85=A5"
+
+#: git-gui.sh:1667
+msgid "Push"
+msgstr "=E4=B8=8A=E4=BC=A0"
+
+#: git-gui.sh:1676
+msgid "Browse Current Branch's Files"
+msgstr "=E6=B5=8F=E8=A7=88=E5=BD=93=E5=89=8D=E5=88=86=E6=94=AF=E6=96=87=
=E4=BB=B6"
+
+#: git-gui.sh:1685
+msgid "Visualize Current Branch's History"
+msgstr "=E8=B0=83=E7=94=A8gitk=E6=98=BE=E7=A4=BA=E5=BD=93=E5=89=8D=E5=88=
=86=E6=94=AF"
+
+#: git-gui.sh:1689
+msgid "Visualize All Branch History"
+msgstr "=E8=B0=83=E7=94=A8gitk=E6=98=BE=E7=A4=BA=E6=89=80=E6=9C=89=E5=88=
=86=E6=94=AF"
+
+#: git-gui.sh:1694
+msgid "Database Statistics"
+msgstr "=E6=95=B0=E6=8D=AE=E5=BA=93=E7=BB=9F=E8=AE=A1=E6=95=B0=E6=8D=AE=
"
+
+#: git-gui.sh:1697
+msgid "Compress Database"
+msgstr "=E5=8E=8B=E7=BC=A9=E6=95=B0=E6=8D=AE=E5=BA=93"
+
+#: git-gui.sh:1700
+msgid "Verify Database"
+msgstr "=E9=AA=8C=E8=AF=81=E6=95=B0=E6=8D=AE=E5=BA=93"
+
+#: git-gui.sh:1707 git-gui.sh:1711 git-gui.sh:1715
+msgid "Create Desktop Icon"
+msgstr "=E5=88=9B=E5=BB=BA=E6=A1=8C=E9=9D=A2=E5=9B=BE=E6=A0=87"
+
+#: git-gui.sh:1720
+msgid "Quit"
+msgstr "=E9=80=80=E5=87=BA"
+
+#: git-gui.sh:1727
+msgid "Undo"
+msgstr "=E6=92=A4=E9=94=80"
+
+#: git-gui.sh:1730
+msgid "Redo"
+msgstr "=E9=87=8D=E5=81=9A"
+
+#: git-gui.sh:1734 git-gui.sh:2249
+msgid "Cut"
+msgstr "=E5=89=AA=E5=88=87"
+
+#: git-gui.sh:1737 git-gui.sh:2252 git-gui.sh:2323 git-gui.sh:2395
+msgid "Copy"
+msgstr "=E5=A4=8D=E5=88=B6"
+
+#: git-gui.sh:1740 git-gui.sh:2255
+msgid "Paste"
+msgstr "=E7=B2=98=E8=B4=B4"
+
+#: git-gui.sh:1743 git-gui.sh:2258
+msgid "Delete"
+msgstr "=E5=88=A0=E9=99=A4"
+
+#: git-gui.sh:1747 git-gui.sh:2262 git-gui.sh:2399
+msgid "Select All"
+msgstr "=E5=85=A8=E9=80=89"
+
+#: git-gui.sh:1756
+msgid "Create..."
+msgstr "=E6=96=B0=E5=BB=BA..."
+
+#: git-gui.sh:1762
+msgid "Checkout..."
+msgstr "=E5=88=87=E6=8D=A2..."
+
+#: git-gui.sh:1768
+msgid "Rename..."
+msgstr "=E6=94=B9=E5=90=8D..."
+
+#: git-gui.sh:1773 git-gui.sh:1871
+msgid "Delete..."
+msgstr "=E5=88=A0=E9=99=A4..."
+
+#: git-gui.sh:1778
+msgid "Reset..."
+msgstr "=E9=87=8D=E7=BD=AE=E6=89=80=E6=9C=89=E4=BF=AE=E5=8A=A8..."
+
+#: git-gui.sh:1790
+msgid "New Commit"
+msgstr "=E6=96=B0=E6=8F=90=E4=BA=A4"
+
+#: git-gui.sh:1798
+msgid "Amend Last Commit"
+msgstr "=E4=BF=AE=E8=AE=A2=E4=B8=8A=E6=AC=A1=E6=8F=90=E4=BA=A4"
+
+#: git-gui.sh:1807
+msgid "Rescan"
+msgstr "=E9=87=8D=E6=96=B0=E6=89=AB=E6=8F=8F"
+
+#: git-gui.sh:1813
+msgid "Add To Commit"
+msgstr "=E6=B7=BB=E5=8A=A0=E5=88=B0=E6=9C=AC=E6=AC=A1=E6=8F=90=E4=BA=A4=
"
+
+#: git-gui.sh:1818
+msgid "Add Existing To Commit"
+msgstr "=E6=B7=BB=E5=8A=A0=E9=BB=98=E8=AE=A4=E4=BF=AE=E6=94=B9=E6=96=87=
=E4=BB=B6"
+
+#: git-gui.sh:1824
+msgid "Unstage From Commit"
+msgstr "=E4=BB=8E=E6=9C=AC=E6=AC=A1=E6=8F=90=E4=BA=A4=E7=A7=BB=E9=99=A4=
"
+
+#: git-gui.sh:1829
+msgid "Revert Changes"
+msgstr "=E6=81=A2=E5=A4=8D=E4=BF=AE=E6=94=B9"
+
+#: git-gui.sh:1836 git-gui.sh:2273
+msgid "Sign Off"
+msgstr "=E7=AD=BE=E5=90=8D"
+
+#: git-gui.sh:1851
+msgid "Local Merge..."
+msgstr "=E6=9C=AC=E5=9C=B0=E5=90=88=E5=B9=B6..."
+
+#: git-gui.sh:1856
+msgid "Abort Merge..."
+msgstr "=E5=8F=96=E6=B6=88=E5=90=88=E5=B9=B6..."
+
+#: git-gui.sh:1868
+msgid "Push..."
+msgstr "=E4=B8=8A=E4=BC=A0..."
+
+#: git-gui.sh:1878
+msgid "Apple"
+msgstr "=E8=8B=B9=E6=9E=9C"
+
+#: git-gui.sh:1881 git-gui.sh:1928
+#, tcl-format
+msgid "About %s"
+msgstr "=E5=85=B3=E4=BA=8E%s"
+
+#: git-gui.sh:1883 git-gui.sh:1889 git-gui.sh:2441
+msgid "Options..."
+msgstr "=E9=80=89=E9=A1=B9..."
+
+#: git-gui.sh:1913
+msgid "Tools"
+msgstr "=E5=B7=A5=E5=85=B7"
+
+#: git-gui.sh:1915
+msgid "Migrate"
+msgstr "=E7=A7=BB=E6=A4=8D"
+
+#: git-gui.sh:1924
+msgid "Help"
+msgstr "=E5=B8=AE=E5=8A=A9"
+
+#: git-gui.sh:1965
+msgid "Online Documentation"
+msgstr "=E5=9C=A8=E7=BA=BF=E6=96=87=E6=A1=A3"
+
+#: git-gui.sh:2215
+msgid "Initial Commit Message:"
+msgstr "=E5=88=9D=E5=A7=8B=E6=8F=90=E4=BA=A4=E6=8F=8F=E8=BF=B0:"
+
+#: git-gui.sh:2216
+msgid "Amended Commit Message:"
+msgstr "=E4=BF=AE=E8=AE=A2=E6=8F=90=E4=BA=A4=E6=8F=8F=E8=BF=B0:"
+
+#: git-gui.sh:2217
+msgid "Amended Initial Commit Message:"
+msgstr "=E4=BF=AE=E8=AE=A2=E5=88=9D=E5=A7=8B=E6=8F=90=E4=BA=A4=E6=8F=8F=
=E8=BF=B0:"
+
+#: git-gui.sh:2218
+msgid "Amended Merge Commit Message:"
+msgstr "=E4=BF=AE=E8=AE=A2=E5=90=88=E5=B9=B6=E6=8F=90=E4=BA=A4=E6=8F=8F=
=E8=BF=B0:"
+
+#: git-gui.sh:2219
+msgid "Merge Commit Message:"
+msgstr "=E5=90=88=E5=B9=B6=E6=8F=90=E4=BA=A4=E6=8F=8F=E8=BF=B0:"
+
+#: git-gui.sh:2220
+msgid "Commit Message:"
+msgstr "=E6=8F=90=E4=BA=A4=E6=8F=8F=E8=BF=B0:"
+
+#: git-gui.sh:2265 git-gui.sh:2403
+msgid "Copy All"
+msgstr "=E5=85=A8=E9=83=A8=E5=A4=8D=E5=88=B6"
+
+#: git-gui.sh:2391
+msgid "Refresh"
+msgstr "=E5=88=B7=E6=96=B0"
+
+#: git-gui.sh:2412
+msgid "Apply/Reverse Hunk"
+msgstr ""
+
+#: git-gui.sh:2418
+msgid "Decrease Font Size"
+msgstr "=E7=BC=A9=E5=B0=8F=E5=AD=97=E4=BD=93"
+
+#: git-gui.sh:2422
+msgid "Increase Font Size"
+msgstr "=E6=94=BE=E5=A4=A7=E5=AD=97=E4=BD=93"
+
+#: git-gui.sh:2427
+msgid "Show Less Context"
+msgstr "=E6=98=BE=E7=A4=BA=E6=9B=B4=E5=A4=9Adiff=E4=B8=8A=E4=B8=8B=E6=96=
=87"
+
+#: git-gui.sh:2434
+msgid "Show More Context"
+msgstr "=E6=98=BE=E7=A4=BA=E6=9B=B4=E5=B0=91diff=E4=B8=8A=E4=B8=8B=E6=96=
=87"
--=20
1.5.0.rc3.81.g8188e
