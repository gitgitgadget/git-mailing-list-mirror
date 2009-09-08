From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Add more instructions about how to install git.
Date: Tue,  8 Sep 2009 01:11:26 -0400
Message-ID: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 07:13:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkt0q-0004lS-Oc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 07:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbZIHFMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 01:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbZIHFMx
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 01:12:53 -0400
Received: from mail-qy0-f181.google.com ([209.85.221.181]:41954 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbZIHFMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 01:12:53 -0400
Received: by qyk11 with SMTP id 11so2504153qyk.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jJphB+tDpJ3H/2mxDgNIfAYvHIayAjvl5mIZhLjrawI=;
        b=x4LAbKmnJkeweTqO37ofMSnubTM7pV+df4DtqKWpqZ4HidJ9juUcF/IV3eZTo98RlF
         dC8L6g5d2S3F7LvkdoEZ2Yf+aLP7/PXTmc1tQGZbQ5HmgtTS+wSbWQ5djQd+2151za/F
         F5kC5IcOY/ASq3FWF6iUYymqB834hPXuWC24w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kqqupbAaIw7aLtKnveFFW80evAIFI5HFrMXHDjLR6AwTGBJhTjn/9UzGU+0bHLuyTv
         2QuC7v1vPFCJPpcPaOOtyePJgTJZRKLb4WiXM1/rkmfzdvFmv0XzfNW5gZ4wLVe+Mb1r
         XntI8nc/WuaTiwt1RIoqjC9dGYxDW5/HOAPD8=
Received: by 10.224.6.10 with SMTP id 10mr9590543qax.60.1252386775490;
        Mon, 07 Sep 2009 22:12:55 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 2sm205qwi.17.2009.09.07.22.12.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 22:12:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127968>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 INSTALL |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/INSTALL b/INSTALL
index ae7f750..67abfc7 100644
--- a/INSTALL
+++ b/INSTALL
@@ -1,6 +1,15 @@
 
 		Git installation
 
+To install git follow these 4 steps inside your git directory:
+$ autoconf      # Generates the configure file from configure.ac
+$ ./configure   # Configures everything needed to build git
+$ make all      # Compiles git based in the Makefile
+$ make install  # Installs git in your own ~/bin directory
+
+If you don't have autoconf installed, you can do this by:
+$ sudo apt-get install autoconf
+
 Normally you can just do "make" followed by "make install", and that
 will install the git programs in your own ~/bin/ directory.  If you want
 to do a global install, you can do
-- 
1.6.0.4
