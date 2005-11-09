From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Which packages/versions are needed to build documentation
Date: Wed, 9 Nov 2005 16:55:50 +0000
Message-ID: <200511091655.51093.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 09 18:01:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZtEq-00009I-8A
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 17:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVKIQzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 11:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVKIQzw
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 11:55:52 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:22912
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932094AbVKIQzw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 11:55:52 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EZtEl-0007SP-AA
	for git@vger.kernel.org; Wed, 09 Nov 2005 16:55:51 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11403>

I have just downloaded git-core-0.99f

On my debian unstable system I can build the documentation just fine

On my debian sarge system it fails almost immediately

alan@roo:Documentation$ make
asciidoc -b xhtml11 -d manpage -f asciidoc.conf git-add.txt
WARNING: non-standard xhtml11 backend
FAILED: incomplete configuration files
make: *** [git-add.html] Error 1
alan@roo:Documentation$        



I've patched up asciidoc as per instructions.

Searching for a package (dpkg -S xhtmll) that uses anything to do with xhtml11 
shows nothing on Sarge, and shows asciidoc (and some other things, like 
quanta and mozilla) on debian unstable.  I assume therefore its just a 
version issue of asciidoc, although I am confused because the note about 
patching asciidoc assumes you had 6.0.3 installed - which is what debian 
sarge has. 
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
