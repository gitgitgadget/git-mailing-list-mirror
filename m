From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8] autoconf: It is --without-python, not --no-python
Date: Wed, 9 Aug 2006 02:19:22 +0200
Message-ID: <200608090219.22769.jnareb@gmail.com>
References: <200608081834.09271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 09 02:19:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAbn1-0001Qb-Bs
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 02:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWHIATM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 20:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWHIATM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 20:19:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:32093 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030366AbWHIATL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 20:19:11 -0400
Received: by nf-out-0910.google.com with SMTP id a4so21000nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 17:19:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LzJUx83rn2bBy5W9v3T82Lndu+dxdrTuuedX3TmC/AxHCDoyteladeb3kk9jVku702MBz8sJ4VAz9vmYkKsHoIr7vpaIXUYlENLfK50Cf4LlFaYq7kuRq0cFMxvgtcrICbUIwfl3VvW/kf5Z6OvMG11DuvB4I3AyEnIZp4qMCG0=
Received: by 10.49.8.10 with SMTP id l10mr981772nfi;
        Tue, 08 Aug 2006 17:19:10 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id k23sm1439868nfc.2006.08.08.17.19.09;
        Tue, 08 Aug 2006 17:19:10 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608081834.09271.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25104>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index ae56462..e890131 100644
--- a/configure.ac
+++ b/configure.ac
@@ -78,7 +78,7 @@ #
 # Define NO_PYTHON if you want to lose all benefits of the recursive merge.
 # Define PYTHON_PATH to provide path to Python.
 AC_ARG_WITH(python,[AS_HELP_STRING([--with-python=PATH], [provide PATH to python])
-AS_HELP_STRING([--no-python], [don't use python scripts])],
+AS_HELP_STRING([--without-python], [don't use python scripts])],
  [if test "$withval" = "no"; then \
     NO_PYTHON=YesPlease; \
   elif test "$withval" = "yes"; then \
-- 
1.4.1.1
