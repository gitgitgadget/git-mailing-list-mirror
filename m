From: Johan Herland <johan@herland.net>
Subject: Encoding problem with web version of the user manual
Date: Tue, 10 Jul 2007 14:49:01 +0200
Message-ID: <200707101449.01667.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 14:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8F9h-00061B-Cp
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 14:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbXGJMtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 08:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbXGJMtK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 08:49:10 -0400
Received: from sam.opera.com ([213.236.208.81]:47455 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbXGJMtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 08:49:08 -0400
Received: from pc166.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l6ACn10r022834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 12:49:06 GMT
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.90.1/3620/Tue Jul 10 01:30:39 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52061>

The current online version of the user manual at 
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html seems to 
have some encoding problems. The document itself is in ISO-8859-1, and it 
even states so in a meta-tag. However, the server says "Content-Type: 
text/html; charset=UTF-8" (which takes precedence, according to the spec). 
The end result is that the document looks like crap in most/all browsers 
(I've tested with Konqueror, Opera and Firefox). Not sure if any other 
documents are affected. The git manual page at 
http://www.kernel.org/pub/software/scm/git/docs/git.html (and other git 
manual pages) works correctly, since it's actually in UTF-8 format, and the 
HTTP header is therefore correct.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
