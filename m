From: Pavel Roskin <proski@gnu.org>
Subject: cg-clean, cg-status improvements
Date: Tue, 14 Feb 2006 10:28:19 -0500
Message-ID: <1139930899.1944.13.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Feb 14 16:36:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F926m-0003WL-1J
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 16:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWBNP2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 10:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWBNP2t
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 10:28:49 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:43692 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161085AbWBNP2s
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 10:28:48 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F926Y-0001rk-4W
	for git@vger.kernel.org; Tue, 14 Feb 2006 10:28:39 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F926F-000552-OP; Tue, 14 Feb 2006 10:28:19 -0500
To: Petr Baudis <pasky@ucw.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16135>

Hello, Petr!

Is cogito 0.17 going to require git 1.2.0?  If so, I'm ready to submit a
patch for cg-clean that would use the fixed functionality of git
regarding ignores when run in subdirectories (commit
701ca744e386c2429ca44072ea987bbb4bdac7ce).  I think cg-status can be
improved as well.

If cogito 0.17 is not going to require git 1.2.0, I'm ready to add a
temporary workaround for older versions of git.

The problem with cg-clean right now is that it removes contents of
untracked directories by default, which makes it pointless to keep the
directories.  I submitted a patch for that, but it it wasn't noticed.
Anyway, I can do it better now.

-- 
Regards,
Pavel Roskin
