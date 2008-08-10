From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Fix typo in comments of longest_ancestor_length()
Date: Sun, 10 Aug 2008 22:26:23 +0700
Message-ID: <20080810152623.GA22259@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 17:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSCpV-0007w4-9y
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 17:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbYHJP0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 11:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbYHJP0f
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 11:26:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:35078 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbYHJP0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 11:26:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1854059rvb.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=4JmsKKcCI5f8YWuuipKWU5zMt3yVjPZQXbO4yE9CDKY=;
        b=sR5XLxOVQRI1iSiN5gRHY7wfndAcVUpXmkFl8q0OtHROrrtyhYR8cKAW5vCz/vb265
         fHFxIpJ+9qg00+tUg2M/JOZQ1R60ONObdfR42deFmWXq4bR7/5RIeNvw4Fwkx8F2oBai
         aHIt8tt5vZPBY7MZQkJIqFLA1wk9Ja7D5ya+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=vIJ+srA3V25VJmUadL3xkYcfBCbvGPcvrWlKn15Z+iRAB/PqqJbBOw2zy7cGefJveI
         Ookhgw3gsQduqj6JaJzHxgcJanyx2VLv8fhGHRCf8Wdy3F3WniaI24llXSND/Vzr7Tg0
         KkKrvI2rHTEVo3K/t/0BYk1G/lZo9RRbbUmWA=
Received: by 10.114.109.1 with SMTP id h1mr2907424wac.35.1218381994205;
        Sun, 10 Aug 2008 08:26:34 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.7.85])
        by mx.google.com with ESMTPS id z20sm6068945pod.11.2008.08.10.08.26.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Aug 2008 08:26:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 10 Aug 2008 22:26:23 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91846>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Not really important but it might confuse new comers.

 path.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index 9df447b..76e8872 100644
--- a/path.c
+++ b/path.c
@@ -365,7 +365,7 @@ int normalize_absolute_path(char *buf, const char *=
path)
  * path =3D Canonical absolute path
  * prefix_list =3D Colon-separated list of absolute paths
  *
- * Determines, for each path in parent_list, whether the "prefix" real=
ly
+ * Determines, for each path in prefix_list, whether the "prefix" real=
ly
  * is an ancestor directory of path.  Returns the length of the longes=
t
  * ancestor directory, excluding any trailing slashes, or -1 if no pre=
fix
  * is an ancestor.  (Note that this means 0 is returned if prefix_list=
 is
--=20
1.5.5.GIT
