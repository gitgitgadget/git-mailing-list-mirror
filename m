From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Sun, 30 Oct 2005 21:44:51 -0800
Message-ID: <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
References: <43652934.8000308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 06:53:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWSTy-0000qh-Ak
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 06:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVJaFox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 00:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVJaFox
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 00:44:53 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29571 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751391AbVJaFox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 00:44:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031054435.YTCL16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 00:44:35 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43652934.8000308@zytor.com> (H. Peter Anvin's message of "Sun,
	30 Oct 2005 12:12:36 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10851>

"H. Peter Anvin" <hpa@zytor.com> writes:

> git-svnimport.perl:require v5.8.0; # for shell-safe open("-|",LIST)
>
> ... which RPM thinks means that you need a Perl module called v5.8.0 
> which doesn't, of course, exist.  This is arguably an rpmbuild bug, but 
> it nevertheless breaks at the moment.

I took Ryan's suggestion and pushed 0.99.9a out.  Does it make
RHEL4 happy?
