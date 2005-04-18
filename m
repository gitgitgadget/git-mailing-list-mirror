From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Mon, 18 Apr 2005 20:47:50 +0200
Message-ID: <20050418184750.GD5554@pasky.ji.cz>
References: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org> <12c511ca050416152452a4c620@mail.gmail.com> <200504181841.j3IIfgP31258@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 20:44:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNbDy-0003sF-9U
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 20:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVDRSr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 14:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVDRSr5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 14:47:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58027 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262141AbVDRSrz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 14:47:55 -0400
Received: (qmail 11973 invoked by uid 2001); 18 Apr 2005 18:47:50 -0000
To: tony.luck@intel.com
Content-Disposition: inline
In-Reply-To: <200504181841.j3IIfgP31258@unix-os.sc.intel.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 08:41:42PM CEST, I got a letter
where tony.luck@intel.com told me that...
> >Not a patch ... it is a whole file.  I called it "git-wget", but it might
> >also want to be called "git-pulltop".
> 
> It's been pointed out to me that I based this script on a pre-historic version
> of ls-tree from sometime last week.  Modern versions print the mode with %06o
> so there is a leading 0 on the mode for a directory.  Just change
> 
> 		if [ $mode = 40000 ]
> 
> to
> 
> 		if [ $mode = 040000 ]
> 
> to fix it.

...and this is precisely why ls-tree actually outputs those "blob" and
"tree" tags. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
