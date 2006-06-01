From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Thu, 1 Jun 2006 12:23:18 -0700
Message-ID: <20060601192318.GC3329@kroah.com>
References: <7v1wut2p5z.fsf@assigned-by-dhcp.cox.net> <m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com> <7vsln8cwn6.fsf@assigned-by-dhcp.cox.net> <m1zmhg31cm.fsf@ebiederm.dsl.xmission.com> <7vy7x09qet.fsf@assigned-by-dhcp.cox.net> <m1ejyr38xx.fsf@ebiederm.dsl.xmission.com> <20060519235825.GA3289@kroah.com> <m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com> <20060520213257.GH24672@kroah.com> <m1fyj4qkm2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 21:38:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Flszg-0005dS-MZ
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 21:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWFATiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 15:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWFATiE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 15:38:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:27063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965280AbWFATiB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 15:38:01 -0400
Received: from [192.168.0.11] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k51JaGd14780;
	Thu, 1 Jun 2006 12:36:16 -0700
Received: from greg by press.kroah.org with local (masqmail 0.2.19) id
 1FlslK-0sQ-00; Thu, 01 Jun 2006 12:23:18 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m1fyj4qkm2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21122>

On Sat, May 20, 2006 at 06:36:53PM -0600, Eric W. Biederman wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Fri, May 19, 2006 at 08:42:38PM -0600, Eric W. Biederman wrote:
> >
> >> If it is one patch per file but with mbox headers, it is relatively
> >> simple to teach git-mailinfo to parse things in a slightly more intelligent
> >> way.  I played with that but I didn't have any patches that helped with.
> >
> > Hm, I'll try playing with that.
> >
> > If you want, just grab my quilt trees from kernel.org and play with
> > them, they should all be in mbox format for the individual patches (with
> > some exceptions as noted above, just kick me about them to get me to fix
> > them...)
> 
> So I just grabbed the gregkh-2.6 set of patches and with an unmodified
> git-mailinfo I only have problems with the following patches:
> 	gregkh/gkh-version.patch
> 	gregkh/sysfs-test.patch
> 	gregkh/gregkh-usb-minors.patch
> 	gregkh/gregkh-debugfs_example.patch
> 	gregkh/gpl_future-test.patch
> 	usb/usb-gotemp.patch
> 
> None of which actually have from headers.

Oops, sorry for the delay.  I've now fixed up these patches (the ones in
the gregkh/ directory are not ever going to be sent upstream, that's
why they were missing headers, same for the gotemp driver.)

thanks,

greg k-h
