From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Sun, 30 Oct 2005 15:01:38 -0800
Message-ID: <7vzmoqlict.fsf@assigned-by-dhcp.cox.net>
References: <43652934.8000308@zytor.com> <436548F3.1030507@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:02:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWMBy-0001wl-5w
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 00:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVJ3XBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 18:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVJ3XBl
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 18:01:41 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:40101 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932395AbVJ3XBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 18:01:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030230051.QKXF24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Oct 2005 18:00:51 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <436548F3.1030507@michonline.com> (Ryan Anderson's message of
	"Sun, 30 Oct 2005 17:28:03 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10840>

Ryan Anderson <ryan@michonline.com> writes:

>> git-svnimport.perl:require v5.8.0; # for shell-safe open("-|",LIST)
>> 
>> ... which RPM thinks means that you need a Perl module called v5.8.0
>> which doesn't, of course, exist.  This is arguably an rpmbuild bug, but
>> it nevertheless breaks at the moment.
>
> If you change that to the traditional statement of "require 5.008;",
> does it fix things up?

Ah, I like that better.  Let me try that.
