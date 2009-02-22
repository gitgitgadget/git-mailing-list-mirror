From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH] Use explicit bundle name in UIText to aid IDE integration
Date: Sun, 22 Feb 2009 11:20:43 +0100
Message-ID: <1235298043-18813-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 11:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbBRu-0004J7-6Y
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 11:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbZBVKTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 05:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbZBVKTH
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 05:19:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:11898 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172AbZBVKTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 05:19:05 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2329081fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 02:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8rbrz7oBZJCitu9tEA5BuOq+SZ2nzLkxMCD8QIG/dGY=;
        b=MCx2U1vM515DE3fMpIKfxHpcb3rdy88HkI71fgjxinGFCQ/1fLlkuxYitICcK+/G8z
         tHxp+rT4IX+mFZ0RZV42XURa9lv87uVrEz0GZnjQHqYkOkHCtevp8bNmDW+v89W7tK2l
         FAmx3RaDgVB8QTQVcEqYRnuzaOeA+QwIgZjUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=l+rrDDhdpNodLXh8USe6h7fE0q4cDAPrzWzKBTVsy9SJK5373+fLRI9vLCeVNmqQ67
         iYKr7cueS2e/mb/2srN5Hx3yF4h4NzN74DPiFEOhN69Q0XmXrRp0cpBbGCoKOL/GSHHB
         5H5tdEuzET3yDHswPbjCPSGHB1KbqZ8k8gj3o=
Received: by 10.86.95.8 with SMTP id s8mr2198696fgb.16.1235297943813;
        Sun, 22 Feb 2009 02:19:03 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l12sm7102268fgb.51.2009.02.22.02.19.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 02:19:03 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id BAC98468001; Sun, 22 Feb 2009 11:20:43 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110993>

When the bundle name is specified as a raw string Eclipse will pick up
the location of the uitext.properties file and display the actual strin=
g
value when hovering over UIText declarations. It also allows direct
navigation to the uitext.properties string from a declaration.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/=
org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index bd64ca1..0740f09 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -1022,7 +1022,6 @@
 	public static String DecoratorPreferencesPage_iconsShowAssumeValid;
=20
 	static {
-		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
-				UIText.class);
+		initializeMessages("org.spearce.egit.ui.uitext", UIText.class);
 	}
 }
--=20
1.6.1.2.309.g2ea3
