From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Fri, 11 May 2007 20:25:57 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705112025.58095.ismail@pardus.org.tr>
References: <200705081349.34964.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mcKRGfYC1M6r2ov"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 19:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmYqm-0006LC-GW
	for gcvg-git@gmane.org; Fri, 11 May 2007 19:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbXEKRYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 13:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758056AbXEKRYK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 13:24:10 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:35585 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754492AbXEKRYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 13:24:09 -0400
Received: from southpark.local (unknown [88.233.178.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id EFE0E5FAF2E5
	for <git@vger.kernel.org>; Fri, 11 May 2007 20:24:00 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200705081349.34964.ismail@pardus.org.tr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46968>

--Boundary-00=_mcKRGfYC1M6r2ov
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 08 May 2007 13:49:31 you wrote:
> Hi,
>
> According to FHS standard default man page path is $prefix/share/man [0] ,
> attached patch fixes this for GIT.
>
> [0] http://www.pathname.com/fhs/pub/fhs-2.3.html#USRSHAREMANMANUALPAGES
>
> Signed-off-by: Ismail Donmez <ismail@pardus.org.tr>

ACK? NAK? Do we care about this? :)

Patch attached again for convenience.

Regards,
ismail

-- 
Perfect is the enemy of good

--Boundary-00=_mcKRGfYC1M6r2ov
Content-Type: text/x-diff;
  charset="utf-8";
  name="mandir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mandir.patch"

--- Documentation/Makefile	2007-02-26 21:20:28.000000000 +0200
+++ Documentation/Makefile	2007-02-28 01:18:07.672166995 +0200
@@ -26,7 +26,7 @@
 
 prefix?=$(HOME)
 bindir?=$(prefix)/bin
-mandir?=$(prefix)/man
+mandir?=$(prefix)/share/man
 man1dir=$(mandir)/man1
 man7dir=$(mandir)/man7
 # DESTDIR=

--Boundary-00=_mcKRGfYC1M6r2ov--
