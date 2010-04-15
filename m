From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Add .depend directories to .gitignore
Date: Thu, 15 Apr 2010 02:35:20 -0500
Message-ID: <20100415073519.GA13492@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 09:35:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Jbi-0006Pi-5l
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 09:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368Ab0DOHfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 03:35:20 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:65152 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364Ab0DOHfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 03:35:16 -0400
Received: by pzk42 with SMTP id 42so858452pzk.4
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=8apLgu9NkyxFD53pUsh8hIs0TBACcxh6VCUQy2OMNic=;
        b=cGO70mLHCvbjSoz23wjU2dBJcDTRmy71dl9mVI8B1+LHKisU28t4ImY/RQBHk1sVlh
         4Ryhm0cdBaw4suutXFYo8U2v8EkH9hSWF8yH7UV8iXig+qirkhfgZko1FiZxhyQNL3ka
         dsAxf/woHAWcpWJf0pIDsU4cVfN29rmhlYMfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=evutmoPu51lMFWsCHu1Vx1qx4Jcl2IokILaC/r0q44TRvEJiaHxhqb8L1DpG4Knu4k
         ycsx4lPpx1pSY7zVDiq/jZryIW10mF3eueAvjHWR0WFPFfX88fzw/FqeTfDaPnaBGjwT
         IrzADpRKU9GI8ApNOPcHXioJ2SPnwSSYZoYJ0=
Received: by 10.114.237.21 with SMTP id k21mr2314377wah.141.1271316915253;
        Thu, 15 Apr 2010 00:35:15 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm811046iwn.8.2010.04.15.00.35.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 00:35:14 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144958>

The makefile snippets that would land in these directories are already
being ignored.  Ignore the directories instead so they don=E2=80=99t sh=
ow up
in =E2=80=98git clean -n=E2=80=99 output.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 .gitignore |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 4c24152..561401b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -178,7 +178,7 @@
 *.exe
 *.[aos]
 *.py[co]
-*.o.d
+.depend/
 *+
 /config.mak
 /autom4te.cache
--=20
1.7.1.rc1
