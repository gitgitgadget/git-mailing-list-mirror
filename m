From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 22:13:52 +0200
Message-ID: <20080710201352.GA3717@blimp.local>
References: <20080710075327.GD24819@artemis.madism.org> <7vy749pxbe.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807101212000.12484@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH2Y1-0007eQ-NE
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 22:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYGJUOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 16:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbYGJUOP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 16:14:15 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:34719 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYGJUOP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 16:14:15 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jO9V
Received: from tigra.home (Fa95a.f.strato-dslnet.de [195.4.169.90])
	by post.webmailer.de (fruni mo57) (RZmta 16.47)
	with ESMTP id w03723k6AJDWyL ; Thu, 10 Jul 2008 22:14:08 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C78B3277BD;
	Thu, 10 Jul 2008 22:14:07 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id D93A436D18; Thu, 10 Jul 2008 22:13:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807101212000.12484@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88006>

Nicolas Pitre, Thu, Jul 10, 2008 18:21:09 +0200:
> On Thu, 10 Jul 2008, Junio C Hamano wrote:
> >  (2) exploding memory use, suspected to be due to malloc pool
> >      fragmentation under multithreading.
...
> > but I do not
> > recall the latter issue has been addressed.
> 
> Well, for "standard" repositories such as the Linux kernel, things 
> always worked just fine.  And commit eac12e2d is apparently helping a 
> lot with the remaining odd cases.  And if someone has problems due to 
> this then a simple 'git config --global pack.threads 1' would restore 
> the non threaded behavior.

Have you ever seen what happens to Windows XP on memory shortage?
It freezes *hard*. Not a good behaviour for _default_ settings.

And if someone has no problems with memory, then a simple "git config
pack.threads 100" would restore the threaded behaviour for a
repository which supposedly will never grow up.
