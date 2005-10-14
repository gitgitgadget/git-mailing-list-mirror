From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: Fwd: debian packaging
Date: Fri, 14 Oct 2005 14:54:53 +0530
Message-ID: <cc723f590510140224r77a0dbcfwcc2301ae2cda2de0@mail.gmail.com>
References: <cc723f590510140218s76c9fca2me4ec39b03c77245f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17825_1193095.1129281893951"
X-From: git-owner@vger.kernel.org Fri Oct 14 11:26:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQLo9-0000YP-UC
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 11:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVJNJYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 05:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVJNJYz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 05:24:55 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:5366 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbVJNJYy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2005 05:24:54 -0400
Received: by xproxy.gmail.com with SMTP id i30so360720wxd
        for <git@vger.kernel.org>; Fri, 14 Oct 2005 02:24:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=XC1eXhCioM+F9xaP0cAaqVsD6e4/bFqQgrxgwyYrkPkAkLeju8XD5FlmHw9U/y8u0ViY4+nO6YJW1oEzvzmwEfOtY/Gl2aDDdekIU1Zsb6a84FxqT/KQjlCJ1lY6qkki7rbe7wTOcbt17J/Eed1HV1/XiEgWm6ROn/pAioRe/8w=
Received: by 10.70.75.15 with SMTP id x15mr1117107wxa;
        Fri, 14 Oct 2005 02:24:53 -0700 (PDT)
Received: by 10.70.27.2 with HTTP; Fri, 14 Oct 2005 02:24:53 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <cc723f590510140218s76c9fca2me4ec39b03c77245f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10105>

------=_Part_17825_1193095.1129281893951
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

---------- Forwarded message ----------
From: Aneesh Kumar <aneesh.kumar@gmail.com>
Date: Oct 14, 2005 2:48 PM
Subject: debian packaging
To: junkio@cox.net


Make it build with stable testing and unstable.

-aneesh

------=_Part_17825_1193095.1129281893951
Content-Type: text/plain; name=git.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="git.diff"

diff --git a/debian/control b/debian/control
index 5d75c32..2ae4ee9 100644
--- a/debian/control
+++ b/debian/control
@@ -2,7 +2,7 @@ Source: git-core
 Section: devel
 Priority: optional
 Maintainer: Junio C Hamano <junkio@cox.net>
-Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev, asciidoc (>= 6.0.3), xmlto, debhelper (>= 4.0.0), bc
+Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev|libcurl3-gnutls-dev|libcurl3-openssl-dev, asciidoc (>= 6.0.3), xmlto, debhelper (>= 4.0.0), bc
 Standards-Version: 3.6.1
 
 Package: git-core


------=_Part_17825_1193095.1129281893951--
