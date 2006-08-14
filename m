From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: 2 build issues
Date: Mon, 14 Aug 2006 12:11:56 -0700
Organization: YPO4
Message-ID: <20060814121156.84bc6e34.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 21:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GChoJ-0000ct-Dr
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 21:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWHNTJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 15:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWHNTJF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 15:09:05 -0400
Received: from xenotime.net ([66.160.160.81]:1511 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932301AbWHNTJD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 15:09:03 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <git@vger.kernel.org>; Mon, 14 Aug 2006 12:09:02 -0700
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25375>

xmlto -m callouts.xsl man git-add.xml
I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
compilation error: file /tmp/xmlto-xsl.l27115 line 4 element import
xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
make[1]: *** [git-add.1] Error 1
rm git-add.xml
make[1]: Leaving directory `/home/rddunlap/builds/git-snapshot-20060814/Documentation'
make: *** [doc] Error 2

~~~~~~~~~~~~~~ and ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

make -C templates install
make[1]: Entering directory `/home/rddunlap/builds/git-snapshot-20060814/templates'
: no custom templates yet
install -d -m755 '/usr/local/share/git-core/templates/'
(cd blt && tar cf - .) | \
(cd '/usr/local/share/git-core/templates/' && tar xf -)
tar: This does not look like a tar archive
tar: Skipping to next header
tar: Archive contains obsolescent base-64 headers
tar: Error exit delayed from previous errors
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/rddunlap/builds/git-snapshot-20060814/templates'
make: *** [install] Error 



Fixes?  suggestions?

Thanks,
---
~Randy
