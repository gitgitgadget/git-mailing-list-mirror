From: Jim Radford <radford@blackbean.org>
Subject: Re: parsecvs tool now creates git repositories
Date: Thu, 6 Apr 2006 11:15:02 -0700
Message-ID: <20060406181502.GA15741@blackbean.org>
References: <20060405174247.GA29758@blackbean.org> <1144262498.2303.231.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 20:15:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRZ0u-0006Fv-GE
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 20:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWDFSPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 14:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWDFSPT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 14:15:19 -0400
Received: from cpe-67-49-92-118.socal.res.rr.com ([67.49.92.118]:54658 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S932216AbWDFSPR
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 14:15:17 -0400
Received: from home.blackbean.org (localhost.localdomain [127.0.0.1])
	by mail.blackbean.org (8.13.6/8.13.4) with ESMTP id k36IF4Nk015794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Apr 2006 11:15:04 -0700
Received: (from jim@localhost)
	by home.blackbean.org (8.13.6/8.13.6/Submit) id k36IF2BB015790;
	Thu, 6 Apr 2006 11:15:02 -0700
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1144305392.2303.240.camel@neko.keithp.com>
User-Agent: Mutt/1.4.2.1i
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on home.blackbean.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18477>

Hi Keith,

Here's one more build patch.  For some reason the Fedora lex doesn't
want a space after the -o.

Almost all of the errors I was seeing in the last version were fixed
with your "branches that don't get merged back to the trunk" fix.

Thanks,
-Jim

diff --git a/Makefile b/Makefile
index 4ca6ffd..137ed34 100644
--- a/Makefile
+++ b/Makefile
@@ -4,7 +4,7 @@ GCC_WARNINGS3=-Wnested-externs -fno-stri
 GCC_WARNINGS=$(GCC_WARNINGS1) $(GCC_WARNINGS2) $(GCC_WARNINGS3)
 CFLAGS=-O0 -g $(GCC_WARNINGS)
 YFLAGS=-d -l
-LFLAGS=-l -o lex.c
+LFLAGS=-l -olex.c

 SRCS=gram.y lex.l cvs.h parsecvs.c cvsutil.c \
        revlist.c atom.c revcvs.c git.c gitutil.c
