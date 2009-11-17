From: Yaroslav Halchenko <debian@onerussian.com>
Subject: git-svn of both trunk and tags while having no access to the
 'parent' of those
Date: Mon, 16 Nov 2009 21:59:45 -0500
Message-ID: <20091117025945.GE17964@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 04:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAEeI-0006r1-81
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 04:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbZKQDWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 22:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbZKQDWW
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 22:22:22 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:35714 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbZKQDWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 22:22:21 -0500
X-Greylist: delayed 1359 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2009 22:22:21 EST
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NAEID-0000JJ-Vo
	for git@vger.kernel.org; Mon, 16 Nov 2009 21:59:46 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NAEID-0000JG-Q5
	for git@vger.kernel.org; Mon, 16 Nov 2009 21:59:45 -0500
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133054>

Dear Git People,

I've ran into a situation here:

there is a repository with trunk and releases (analog to tags there)
available for public, but the rest of directories and their parent is
not available without authentication... ie I can access

http://domain.com/svnrepo/trunk
http://domain.com/svnrepo/releases
but not
http://domain.com/svnrepo/

Whenever I use git-svn (1.6.5 in Debian):

git svn clone --prefix=upstream-svn/ -T trunk -t releases http://domain.com/svnrepo svnrepo.gitsvn

it asks for authentication... I guess, now I can only clone trunk and
releases separately? or may be there is some way to avoid the
problem, ie avoid looking 'into root'?

Thanks in advance!
-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
