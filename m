From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 0/5] gitweb: Support for arbitrary diffs
Date: Sun,  2 Sep 2007 16:46:03 +0200
Message-ID: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Sep 02 16:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRqii-0000tU-Hy
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 16:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbXIBOqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 10:46:13 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXIBOqN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 10:46:13 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:45566 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbXIBOqM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 10:46:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 954B67437390;
	Sun,  2 Sep 2007 16:46:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23jKepYXFiKt; Sun,  2 Sep 2007 16:46:09 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0A549680D6D1; Sun,  2 Sep 2007 16:46:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57329>

Resend of the complete patch serie (again next).

Patch 1-3 are unchanged.

Patch 4 now only generates the links, if they are enabled.
The header contains a new link to show/hide the links.
The state is remembered via a cookie across pages.

Patch 5 is the foundation for showing the base/diff links
in an other color.

mfg Martin K=F6gler
PS:
I develop the patches via StGit. If you think that I should publish the=
m
in a different way, please tell me.
