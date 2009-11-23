From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH 0/2] Add support for IPv6 on MinGW
Date: Tue, 24 Nov 2009 00:54:13 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810048-171740207-1259016857=:14228"
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 23:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NChnc-0000HY-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 23:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250AbZKWWyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113AbZKWWyM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 17:54:12 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:57229 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbZKWWyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 17:54:12 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi2.inet.fi (8.5.014)
        id 4A77692A044958D2; Tue, 24 Nov 2009 00:54:17 +0200
X-X-Sender: martin@cone.home.martin.st
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133538>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810048-171740207-1259016857=:14228
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

This is a short patch series that adds support for IPv6 on MinGW. These 
patches have been in use in msysgit for a few months (but the code was 
accidentally removed recently in a merge). For consistency, it would be 
good to add them upstream, too.

Martin Storsjö (2):
  Refactor winsock initialization into a separate function
  Enable support for IPv6 on MinGW

 Makefile       |    1 -
 compat/mingw.c |  184 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 compat/mingw.h |   13 ++++
 3 files changed, 193 insertions(+), 5 deletions(-)

---1463810048-171740207-1259016857=:14228--
