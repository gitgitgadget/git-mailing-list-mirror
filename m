From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 11] autoconf: Rename ./configure output file to config.mak.autogen
Date: Fri, 30 Jun 2006 14:41:01 +0200
Message-ID: <200606301441.01327.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606301437.52590.jnareb@gmail.com> <200606301439.40584.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 30 14:41:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwIIq-0008Vn-Om
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 14:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWF3Mky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 08:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWF3Mky
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 08:40:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7798 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932577AbWF3Mkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 08:40:53 -0400
Received: by nf-out-0910.google.com with SMTP id c2so238826nfe
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 05:40:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E1v39D9KD4KW8D1uz/rUWIYtKOxd3qpF4YmtVY4aFxrLrV6zatf8mTeGyRaT65M0vdLXMmYIEK9RzTgPqJ8BBZqBOCMPIqiRWsRPhBPw8VE5j5lF5hRZYF1BitadNzk+BU6CCi9PkwBqiXNuJZpMUGZkbp5LRInRb1bLDs2X3+E=
Received: by 10.49.41.10 with SMTP id t10mr256497nfj;
        Fri, 30 Jun 2006 05:40:52 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id r33sm1543941nfc.2006.06.30.05.40.51;
        Fri, 30 Jun 2006 05:40:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606301439.40584.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22986>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Choose the name you are more comfortable with

 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index ef310ee..f01fc17 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,7 +6,7 @@ AC_INIT([git], [1.4.0], [git@vger.kernel
 
 AC_CONFIG_SRCDIR([git.c])
 
-config_file=config.mak.auto
+config_file=config.mak.autogen
 config_append=config.mak.append
 config_in=config.mak.in
 
-- 
1.4.0
