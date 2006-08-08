From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/4] autoconf: Add forgotten NO_OPENSSL=@NO_OPENSSL@ to config.mak.in
Date: Wed, 9 Aug 2006 01:42:27 +0200
Message-ID: <200608090142.28266.jnareb@gmail.com>
References: <200608081834.09271.jnareb@gmail.com> <200608081839.07112.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 09 01:42:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAbDq-0003nJ-Gv
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 01:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWHHXm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 19:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWHHXm1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 19:42:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:10159 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030336AbWHHXm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 19:42:26 -0400
Received: by nf-out-0910.google.com with SMTP id a4so11737nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 16:42:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h7mnJmztMYAope3fBXGV4OXui2OKeNI+dM0wJe45QJNOcPu1DZAgiwTjgl7+oJWc2A22mg5U/AQcPpxm2QC332T9RBnxmg/x+O+rRlVgMOkxEj50DgYG3VeXndtjKbQP85v3FTVdDh6cjnlstIR95iV/D8RqOW4BPoiZFe45x8A=
Received: by 10.48.48.15 with SMTP id v15mr835615nfv;
        Tue, 08 Aug 2006 16:42:16 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id p43sm290236nfa.2006.08.08.16.42.15;
        Tue, 08 Aug 2006 16:42:16 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608081839.07112.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25100>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Or just correct previous patch, instead.

 config.mak.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 99b13a7..369e611 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -24,6 +24,7 @@ export srcdir VPATH
 
 NO_PYTHON=@NO_PYTHON@
 NEEDS_SSL_WITH_CRYPTO=@NEEDS_SSL_WITH_CRYPTO@
+NO_OPENSSL=@NO_OPENSSL@
 NO_CURL=@NO_CURL@
 NO_EXPAT=@NO_EXPAT@
 NEEDS_LIBICONV=@NEEDS_LIBICONV@
-- 
1.4.1.1
