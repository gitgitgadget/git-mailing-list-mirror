From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 12] Revert "autoconf: Write how to use ./configure generated file in git build process"
Date: Fri, 30 Jun 2006 17:08:18 +0200
Message-ID: <200606301708.19521.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606301439.40584.jnareb@gmail.com> <200606301441.01327.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 30 17:08:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwKbQ-0007c5-9W
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 17:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWF3PIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 11:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWF3PIM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 11:08:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:4159 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932618AbWF3PIM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 11:08:12 -0400
Received: by nf-out-0910.google.com with SMTP id d4so268601nfe
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 08:08:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RkAV3SCby/HBNi48WWO0sG6rjoR88hvlgHVphDHikXhj0M8z0+V6xFhORojLYxlwIuWaP+zCfSJpKKxi/1LGvzEwO6QTesR3Y9AgHcNn625+5MpKhJb7RIhLnyaaPQB/kDPxRFdlnHLm43W8gBb5T3Mwvz9bsbvQtoFVSqJInvU=
Received: by 10.48.240.10 with SMTP id n10mr396039nfh;
        Fri, 30 Jun 2006 08:08:11 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id y23sm1686607nfb.2006.06.30.08.08.10;
        Fri, 30 Jun 2006 08:08:10 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606301441.01327.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22991>

This reverts 6015ccba6c0439b0b615615aacefaf463c546ba4 commit.

To be replaced by better solution, idea by Andreas Ericsson
---
Or just not apply [PATCH 10] (and this patch)

 configure.ac |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index f01fc17..1ead656 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,9 +54,3 @@ AC_CONFIG_FILES(["${config_file}":"${con
 AC_OUTPUT
 
 rm -f "${config_append}"
-
-cat <<_ACEOF
-
-Add '-include ${config_file}' to your config.mak, 
-or rename ${config_file} to config.mak
-_ACEOF
-- 
1.4.0
