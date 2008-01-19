From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Why very small repository has 2.7M size
Date: Sat, 19 Jan 2008 11:57:49 +0100
Message-ID: <4791D7AD.1060106@gmx.ch>
References: <46dff0320801190143h471e6d70ve5bf114335e1534@mail.gmail.com> <46dff0320801190148y5a00c83m4825f4066547ddc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 11:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGBPI-0006VY-0I
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 11:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbYASK5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 05:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYASK5y
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 05:57:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:56066 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753234AbYASK5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 05:57:53 -0500
Received: (qmail invoked by alias); 19 Jan 2008 10:57:51 -0000
Received: from 130-1.78-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.78.1.130]
  by mail.gmx.net (mp019) with SMTP; 19 Jan 2008 11:57:51 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/5q6QSmir5K4rqEDY9HcXge+2euzkIt+suWL4HdB
	+9dSDrxauj1l5F
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
In-Reply-To: <46dff0320801190148y5a00c83m4825f4066547ddc2@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71098>

Ping Yin wrote:
> -rw-r--r-- 1 yinping yinping   26 2008-01-19 17:33 .gitignore
> -rwxr-xr-x 1 yinping yinping  131 2008-01-19 17:44 Makefile.common
> [...]
> Counting objects: 87, done.
> [...]
> 4046b84344038d63b655b56f6e619888dd424e4e Add Makefile.common using commonmake
> 8bbd7d4649ac1df1b29414b2ec469f532a77f222 Init empty repository, ignore
> *.o, *.d, *~, *.swp, CVS, .svn

You sure have a lot of objects for only having two commits and two
files.  Maybe some of the objects are loose ones?  Try running
'git gc --prune' to see if that removes them.  But be aware that
this deletes them all, you might want to check first if the loose
objects are something you wanted to keep (with 'git fsck' and 'git
show').

jlh
