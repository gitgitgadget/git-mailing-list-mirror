From: Maaartin <grajcar1@seznam.cz>
Subject: Getting rid of "mode change" on cygwin
Date: Fri, 24 Sep 2010 18:57:59 +0000 (UTC)
Message-ID: <loom.20100924T205622-57@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 20:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzDTM-0002GA-Fj
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 20:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472Ab0IXS6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 14:58:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:47968 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab0IXS6J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 14:58:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OzDTD-00029U-VL
	for git@vger.kernel.org; Fri, 24 Sep 2010 20:58:08 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 20:58:07 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 20:58:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.61)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157035>

I just switched from svn to git and in my first git commit all files get status 
modified with

mode change 100644 => 100755

I don't care about the file mode much, the 755 mode makes no sense but is 
probably some cygwin magic, as it may be hard to emulate the perms, so it simply 
considers all files as executables. I can't change the mode, since chmod a-x 
does nothing at all. Actually, I don't care about the perms at all, I'd be happy 
if git would show "no change" for unchanged files.
