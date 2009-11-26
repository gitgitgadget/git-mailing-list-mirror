From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] gitworkflows: Consistently back-quote git commands
Date: Thu, 26 Nov 2009 22:49:50 +0100
Message-ID: <4B0EF7FE.3000507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 22:49:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmDu-0001mO-3p
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 22:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZKZVtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 16:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbZKZVtr
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 16:49:47 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:48305 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbZKZVtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 16:49:46 -0500
Received: by ey-out-2122.google.com with SMTP id 4so303383eyf.19
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=F8PlJXDnffO3t5D5WpG9n3chJx5yrqUQkbM9TTmBuEc=;
        b=ZcUeyEwsAb1YExAknt8Ky258RvXhu/60KZZ/EJBI40APcRHgrxVbvyKtqFzTxM/v1j
         i/mjG/sYAaeEU/bnGgnsLLTTgddotIoZk9eMXe6Rs4/8v888nZ6uoud0p/2xCaxPv4SL
         KSDx98qnq8fGae00ZlCjcx2ma6H1TPcbyn1L8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=FT5e/lH14GObv8f7pW8IYNils1LCw/tCzjBDCxeqPAQxbo8wCv5mD7QOWlv3GbvHrG
         dB7rOi1cqLwf+I1SCDrMU2Z2fWDXVT0OumCdf7W/noPaJjsC0A5z7t00VZ2/5tm+6KGA
         Q4iLIIXxsSInKyc+N/hXI35gf6QUA04OBx2z4=
Received: by 10.213.23.88 with SMTP id q24mr2923161ebb.13.1259272191531;
        Thu, 26 Nov 2009 13:49:51 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 15sm571978ewy.4.2009.11.26.13.49.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 13:49:51 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133837>

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/gitworkflows.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflow=
s.txt
index 91c0eea..065441d 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -229,7 +229,7 @@ To verify that 'master' is indeed a superset of 'ma=
int', use git log:
 .Verify 'master' is a superset of 'maint'
 [caption=3D"Recipe: "]
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-git log master..maint
+`git log master..maint`
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 This command should not list any commits.  Otherwise, check out
--=20
1.6.6.rc0.15.g4fa80
