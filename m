From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 01:02:48 +0200
Message-ID: <20070520230248.GI25462@steel.home>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org> <20070520205444.GC25462@steel.home> <20070520214026.GL5412@admingilde.org> <20070520222410.GF25462@steel.home> <20070520225521.GP5412@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 01:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuQS-0003M2-L8
	for gcvg-git@gmane.org; Mon, 21 May 2007 01:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928AbXETXCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 19:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757956AbXETXCv
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 19:02:51 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:46164 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757928AbXETXCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 19:02:51 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (mrclete mo20) (RZmta 6.5)
	with ESMTP id 8042c8j4KMQsWp ; Mon, 21 May 2007 01:02:49 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id F3533277BD;
	Mon, 21 May 2007 01:02:48 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CF4C3D195; Mon, 21 May 2007 01:02:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520225521.GP5412@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47947>

Martin Waitz, Mon, May 21, 2007 00:55:22 +0200:
> hoi :)
> 
> On Mon, May 21, 2007 at 12:24:10AM +0200, Alex Riesen wrote:
> > But it is not a merge. It is a checkout. Being another operation it
> > may even be disallow merges of subprojects. Just plainly tell user
> > that this checkout is not possible because there are changes in
> > subprojects and in the pointer to this subproject in the upper level
> > superproject, and that the user should think about committing in
> > subproject first.
> 
> If the user did commit and then you do a supermodule checkout -m you
> will get a merge.
> 

Only if the user continue to use the last branch (or the detached
head) the subproject was on. He don't have to, he can even return to
the commit which does not conflict, unless he have to complicate
things.
