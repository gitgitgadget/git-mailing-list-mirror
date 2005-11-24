From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rename git-config-set to git-repo-config
Date: Thu, 24 Nov 2005 22:54:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de>
 <200511221831.03954.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
 <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
 <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1428261148-1132869241=:26485"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 22:54:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfP2t-0006Nr-4A
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 22:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbVKXVyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 16:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVKXVyE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 16:54:04 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:46238 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932663AbVKXVyC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 16:54:02 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3F3EC13FC83; Thu, 24 Nov 2005 22:54:01 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1618AB5309; Thu, 24 Nov 2005 22:54:01 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E7A50B52FB; Thu, 24 Nov 2005 22:54:00 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D76ED13FC83; Thu, 24 Nov 2005 22:54:00 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12717>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1428261148-1132869241=:26485
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 24 Nov 2005, Junio C Hamano wrote:

>  - Natively, they work only from the project toplevel.  Period.

How about changing *that*? Like, define a GIT_CWD_PREFIX, and checking in=
=20
the C parts?

After all, the biggest problem with the scripts in a subdirectory is that=
=20
they do not necessarily know which parameter means what, i.e. when to=20
prefix it and when not.

A small helper a l=E0 git_path() should do, right?

Ciao,
Dscho

---1148973799-1428261148-1132869241=:26485--
