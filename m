From: Petr Baudis <pasky@suse.cz>
Subject: [Terminology] Push vs. upload?
Date: Tue, 20 Sep 2005 02:11:36 +0200
Message-ID: <20050920001136.GK18320@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 20 02:12:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVjY-0005Ag-Qw
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbVITALi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbVITALi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:11:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10891 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932723AbVITALi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:11:38 -0400
Received: (qmail 12286 invoked by uid 2001); 20 Sep 2005 02:11:36 +0200
To: junkio@cox.net, git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8930>

  Hello,

  I've realized today that I "forgot" to rename cg-push to cg-upload, so
I impulsively did so right away, but now I'm seeing that the core git
still has git-push and no git-upload. This is confusing and appears to
be quite inconsistent - push should be the opposite of pull, but pull is
defined as fetch+merge, while push does just the anti-fetch ("upload")
part. Yes, it does the subset protection, but git-fetch with remotes/
seems to by default do the superset protection as well.

  How should we call it, then?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
