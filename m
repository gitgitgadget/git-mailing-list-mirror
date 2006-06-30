From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 10] autoconf: Write how to use ./configure generated file in git build process
Date: Fri, 30 Jun 2006 14:39:40 +0200
Message-ID: <200606301439.40584.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606300232.34472.jnareb@gmail.com> <200606301437.52590.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 30 14:40:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwIHX-0008Ih-Mv
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 14:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWF3Mjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 08:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWF3Mjd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 08:39:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:42354 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932564AbWF3Mjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 08:39:32 -0400
Received: by nf-out-0910.google.com with SMTP id c2so238601nfe
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 05:39:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jJ+P7OG9aslSYZklVHlbUVFeyCbnQ9EkFyQcAuJttcCiK5Qk+zH2Wk2KnDnOl8FmTsaYy+rT/Av7riIIMNXjAYUrKeo64tu58Z7ByAC3amtlTr4XAFZfk2pt+iQ32+E+BHoqANy1rUjtiAbKS2ZRpKdxteaPJduiXC3Aceev0l0=
Received: by 10.48.246.6 with SMTP id t6mr256386nfh;
        Fri, 30 Jun 2006 05:39:31 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id b1sm54725nfe.2006.06.30.05.39.30;
        Fri, 30 Jun 2006 05:39:31 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606301437.52590.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22985>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Probably there is better way to do this.

 configure.ac |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index e387f5b..ef310ee 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,3 +54,9 @@ AC_CONFIG_FILES(["${config_file}":"${con
 AC_OUTPUT
 
 rm -f "${config_append}"
+
+cat <<_ACEOF
+
+Add '-include ${config_file}' to your config.mak, 
+or rename ${config_file} to config.mak
+_ACEOF
-- 
1.4.0
