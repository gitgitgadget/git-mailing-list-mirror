From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sun, 20 May 2007 22:22:01 +0200
Message-ID: <20070520202201.GY942MdfPADPa@greensroom.kotnet.org>
References: <11795163053812-git-send-email-skimo@liacs.nl>
 <11795163061588-git-send-email-skimo@liacs.nl>
 <20070518215312.GB10475@steel.home>
 <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
 <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
 <20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
 <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
 <20070520155407.GC27087@efreet.light.src>
 <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jan Hudec <bulb@ucw.cz>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 22:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hprv2-0003dD-2Z
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbXETUWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbXETUWF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:22:05 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:64720 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898AbXETUWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:22:03 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIC00GZKWKQVW@psmtp08.wxs.nl> for git@vger.kernel.org; Sun,
 20 May 2007 22:22:02 +0200 (MEST)
Received: (qmail 27461 invoked by uid 500); Sun, 20 May 2007 20:22:02 +0000
In-reply-to: <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47901>

On Sun, May 20, 2007 at 11:33:17AM -0700, Junio C Hamano wrote:
> Jan Hudec <bulb@ucw.cz> writes:
> >  - If you fetch from more than one location, you want to fetch subproject
> >    from location corresponding to where you fetch superproject from.
> 
> Not at all.  There is no reason to believe that the case that
> superproject and subproject come from related URLs is more
> common.  One of the reasons to do a separated project
> organization is to allow looser bindings of the project from
> project administrative viewpoint. The integrator may not
> necessarily have any control over what the subproject guys do,
> and more importantly, the subproject people do not even care nor
> be aware of the fact that their project is sometimes bound
> inside other peoples' superprojects.  Think of the embedded
> appliance vendor binding the kernel, libc and busybox in their
> superproject that holds them together with the build
> infrastructure. The kernel folks certainly do not particularly
> care about the vendor.

I think what Jan means is that if there are two (or more) copies
of the superproject then it is more likely that the subproject
commit can be found in the subproject repo "pointed to" (e.g.,
through my submodule.*.url) by the superproject repo you fetched from.

skimo
