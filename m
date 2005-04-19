From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 00:26:10 +0200
Message-ID: <20050419222609.GE9305@pasky.ji.cz>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <426583D5.2020308@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	Greg KH <gregkh@suse.de>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 00:22:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO16e-0005Lk-MN
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVDSW0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDSW0R
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:26:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61127 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261698AbVDSW0L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:26:11 -0400
Received: (qmail 32141 invoked by uid 2001); 19 Apr 2005 22:26:10 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <426583D5.2020308@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 12:19:01AM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> Linus Torvalds wrote:
> >
> >On Tue, 19 Apr 2005, Greg KH wrote:
> >
> >>Nice, it looks like the merge of this tree, and my usb tree worked just
> >>fine.
> >
> >
> >Yup, it all seems to work out.
> 
> [many files patched]
> patching file mm/mmap.c
> patching file net/bridge/br_sysfs_if.c
> patching file scripts/ver_linux
> ----------------------^^^^^^^^^
> Hey, that's my patch!  Last...and least.
> But perhaps a progress bar right about here might be
> a good thing for the terminally impatient.
> 
> real    3m54.909s
> user    0m14.835s
> sys     0m10.587s
> 
> 4 minutes might be long enough to cause some folks to lose hope.

I'm wondering if doing

if [ "$(show-diff)" ]; then
	git diff | git apply
else
	checkout-cache -f -a
fi

would actually buy us some time; or, how common is it for people to have
no local changes whatsoever, and whether relative slowdown of additional
show-diff to git diff would actually matter.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
