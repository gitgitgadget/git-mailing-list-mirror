From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8] autoconf: ./configure script outputs to config.mac.auto
Date: Fri, 30 Jun 2006 02:32:33 +0200
Message-ID: <200606300232.34472.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606291947.50980.jnareb@gmail.com> <200606300211.21922.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 30 02:32:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw6w0-0003QI-IG
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 02:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWF3Aca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 20:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWF3Aca
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 20:32:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6130 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751338AbWF3Ac2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 20:32:28 -0400
Received: by nf-out-0910.google.com with SMTP id m19so38347nfc
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 17:32:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ol9ThfkF7PStpQtSBxKUdC3/sjssGa/nHnmeO3MKBHYndEsFfu66VYPz8B91mlSSn0LW2ezBWcZLTopSZowY4AtkmaeazYrO3Qs7eszd3WXRVXRRO8YvQi5ywupnn6CGf/arFKhlUy5RKCXdLEC/lCEzggLuNcGacRYp3qBUYKs=
Received: by 10.48.233.18 with SMTP id f18mr175028nfh;
        Thu, 29 Jun 2006 17:32:27 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id v20sm1007789nfc.2006.06.29.17.32.27;
        Thu, 29 Jun 2006 17:32:27 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606300211.21922.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22937>

---
So now to actually use ./configure output you either have to add
  -include config.mak.auto
to Makefile before including config.mak, link config.mak.auto to config.mak, 
or rename (move) config.mak.auto to config.mak after done with ./configure

 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 58ec57a..799bc87 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,7 +6,7 @@ AC_INIT([git], [1.4.0], [git@vger.kernel
 
 AC_CONFIG_SRCDIR([git.c])
 
-config_file=config.mak
+config_file=config.mak.auto
 config_append=config.mak.append
 config_in=config.mak.in
 
-- 
1.4.0
