From: Kris Shannon <kris.shannon@gmail.com>
Subject: [PATCH] Fixup Documentation Makefile for cg-%.txt
Date: Fri, 19 Aug 2005 17:40:11 +1000
Message-ID: <bf38a9f05081900406dda6bec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 09:42:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E61UU-0004Ym-BA
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 09:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVHSHkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 03:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVHSHkP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 03:40:15 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:50425 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932577AbVHSHkN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 03:40:13 -0400
Received: by wproxy.gmail.com with SMTP id i2so555831wra
        for <git@vger.kernel.org>; Fri, 19 Aug 2005 00:40:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C4446WwXE3GZfbSvdnz5HnpU7md9kLnskz5CbFQlkur5ownT4auymhoLkt0RvIAlGVjzc5GlJLf5wo6L7a6OnY1g/CedIegySrNt/IP+KI9Vl6dKj8ojG8PV/M4m0X2pNc/BNBnfMtU9kxpeh7B/qfIM/szR4pcjdtKZfsJllF0=
Received: by 10.54.42.24 with SMTP id p24mr1724009wrp;
        Fri, 19 Aug 2005 00:40:11 -0700 (PDT)
Received: by 10.54.28.72 with HTTP; Fri, 19 Aug 2005 00:40:11 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The syntax for .PRECIOUS in a makefile requires
an implicit target to match exactly:
	%.txt does not cover all *.txt

Signed-off-by: Kris Shannon <kris.shannon@gmail.com>
---

Documentation/Makefile |    2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -52,7 +52,7 @@
 clean:
 	rm -f *.xml *.html *.1 *.7 cg-*.txt cogito.txt
 
-.PRECIOUS: %.txt
+.PRECIOUS: cg-%.txt
 
 introduction.html: ../README
 	asciidoc -b xhtml11 -d article -f asciidoc.conf -o $@ $<
