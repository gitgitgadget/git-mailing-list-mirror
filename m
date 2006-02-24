From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: gitview: Fix DeprecationWarning
Date: Fri, 24 Feb 2006 14:02:32 +0530
Message-ID: <cc723f590602240032r631ea384haf788a95d3ab5c44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5459_19691802.1140769952095"
X-From: git-owner@vger.kernel.org Fri Feb 24 09:32:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCYNe-0004Pc-FZ
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 09:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWBXIch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 03:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWBXIcg
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 03:32:36 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:1322 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932099AbWBXIcg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 03:32:36 -0500
Received: by uproxy.gmail.com with SMTP id c2so107281ugf
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 00:32:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=LgYqj6xn3Hm26QSxgFD6aoinP9JOaT7ziDsEGI6zqKZ2LEJ244yPbC4TAa05SiTMy//6KtGzxgEb/IXDMoDpji7kzaLw6uBdTD0abFuQxPseZaK9uhhO4GKqRzq7Xaf7ejqMw81XyFU3Jq9/n+yKkG9suUN+XWSRNX2ia7qa1TU=
Received: by 10.67.91.8 with SMTP id t8mr720683ugl;
        Fri, 24 Feb 2006 00:32:32 -0800 (PST)
Received: by 10.66.254.7 with HTTP; Fri, 24 Feb 2006 00:32:32 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16687>

------=_Part_5459_19691802.1140769952095
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



------=_Part_5459_19691802.1140769952095
Content-Type: text/plain; name=0002-gitview-Fix-DeprecationWarning.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek28y9m0
Content-Disposition: attachment; filename="0002-gitview-Fix-DeprecationWarning.txt"

Subject: gitview: Fix  DeprecationWarning

DeprecationWarning: integer argument expected, got float

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

1d34275e275b7450721033bf261ea29219934982
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index b04df74..4a6b448 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -154,7 +154,7 @@ class CellRendererGraph(gtk.GenericCellR
 
 		cols = self.node[0]
 		for start, end, colour in self.in_lines + self.out_lines:
-			cols = max(cols, start, end)
+			cols = int(max(cols, start, end))
 
 		(column, colour, names) = self.node
 		names_len = 0
-- 
1.2.3.g2cf3-dirty


------=_Part_5459_19691802.1140769952095--
