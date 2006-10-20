From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 14:48:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610201444030.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <ehaapb$5t7$3@sea.gmane.org> <Pine.LNX.4.63.0610201335420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <200610201403.53664.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 14:48:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gatnd-00021Y-3d
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 14:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWJTMsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWJTMs3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 08:48:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:60345 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030196AbWJTMs3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 08:48:29 -0400
Received: (qmail invoked by alias); 20 Oct 2006 12:48:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 20 Oct 2006 14:48:25 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610201403.53664.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29459>

Hi,

On Fri, 20 Oct 2006, Jakub Narebski wrote:

> > But it does not change a thing. Since v0.99~653, we do not have any 
> > collision check, even if compiled with COLLISION_CHECK.
> 
> So why it is left in Makefile? Does defining this change a thing
> or not (in which case this section should be removed)?

It does not. The relevant parts in the code read like this:

sha1_filc.c:1442
                /* FIXME!!! Collision check here ? */

sha1_file.c:1541
                /*
                 * FIXME!!! We might do collision checking here, but we'd
                 * need to uncompress the old file and check it. Later.
                 */

It was hoped that the people who actually care would implement that 
functionality. (Note that in an earlier version, the check was 
implemented, but would have to be different these days: pack files did not 
exist then).

Ciao,
Dscho
