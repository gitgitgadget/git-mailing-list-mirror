From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Tue, 22 May 2007 23:54:23 +0200
Message-ID: <20070522215423.GI30871@steel.home>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org> <20070520205444.GC25462@steel.home> <20070520214026.GL5412@admingilde.org> <20070520222410.GF25462@steel.home> <20070520225521.GP5412@admingilde.org> <20070520230248.GI25462@steel.home> <20070520231200.GR5412@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue May 22 23:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqcJt-0003uw-CK
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759676AbXEVVyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759712AbXEVVyf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:54:35 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:22556 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759676AbXEVVye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:54:34 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (mrclete mo26) (RZmta 6.5)
	with ESMTP id E042e9j4MIJNJU ; Tue, 22 May 2007 23:54:23 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7CD23277BD;
	Tue, 22 May 2007 23:54:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 54B5FD195; Tue, 22 May 2007 23:54:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520231200.GR5412@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48123>

Martin Waitz, Mon, May 21, 2007 01:12:01 +0200:
> On Mon, May 21, 2007 at 01:02:48AM +0200, Alex Riesen wrote:
> > > If the user did commit and then you do a supermodule checkout -m you
> > > will get a merge.
> > 
> > Only if the user continue to use the last branch (or the detached
> > head) the subproject was on. He don't have to, he can even return to
> > the commit which does not conflict, unless he have to complicate
> > things.
> 
> just curious:
> so you want to differenciate between a subproject HEAD which was
> set by the superproject and other ones?

No. Why do you think that I want to do that?
