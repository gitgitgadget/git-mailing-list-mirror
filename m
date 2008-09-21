From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gitattributes documentation: link to gitignore for glob format
Date: Sun, 21 Sep 2008 20:23:28 +0700
Message-ID: <1222003408-12118-1-git-send-email-pclouds@gmail.com>
References: <C4AD5305-CDD8-418D-95C8-C738A86E78E1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 15:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhOwJ-0002CA-U9
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 15:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYIUNXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 09:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbYIUNXk
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 09:23:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:27705 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYIUNXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 09:23:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1193099wfd.4
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MwjypgadTygZqlLxDeiVmARUNSq4zU7qRnHPsT1Xw8s=;
        b=KLDrWgXZ9NT1c2zXMHJniZEVXEfwFjONo5fc6GjnatISVIpP0maLUNFUvVbD29oPtL
         2b3XvBRz18n9MWXhouPWgiQkYZqazxZGumA7kvzYrfIjd7I6wf8UdWsc4ju6+lZugpto
         BzaIhScZyoFclt44fIB107DF8SifilLfWqcGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=E/arj+TJ2j8LnR/vEQVg7fKLY3auqdrZfnSg9NVDHlSzpW/UxzXfmzJLuYL7t0Xv2S
         RN05PvFpmKcKn5i7NgtfckAmzxbzNY3KrZNSBaYwFBgw+3nMeuA20XNETtQ3fXZEjIyp
         v6L7U8nUGB08utkpB9ILou7fmpQBt3tIEgyPs=
Received: by 10.142.229.5 with SMTP id b5mr926520wfh.50.1222003419247;
        Sun, 21 Sep 2008 06:23:39 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 30sm5670406wff.18.2008.09.21.06.23.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 06:23:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Sep 2008 20:23:28 +0700
X-Mailer: git-send-email 1.6.0.2.427.g8dbf1
In-Reply-To: <C4AD5305-CDD8-418D-95C8-C738A86E78E1@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96395>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On 9/21/08, Wincent Colaiuta <win@wincent.com> wrote:
 >  Did you actually proofread this before sending it?

 I did, but obviously I should have been more serious on
 English classes.

 Documentation/gitattributes.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 9a75257..708a9b5 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -21,7 +21,9 @@ Each line in `gitattributes` file is of form:
 	glob	attr1 attr2 ...
=20
 That is, a glob pattern followed by an attributes list,
-separated by whitespaces.  When the glob pattern matches the
+separated by whitespace. The glob pattern format is the same as
+the one used by `gitignore` files. Please refer to linkgit:gitignore[5=
]
+for more information. When the glob pattern matches the
 path in question, the attributes listed on the line are given to
 the path.
=20
--=20
1.6.0.2.427.g8dbf1
