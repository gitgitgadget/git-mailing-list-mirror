From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: slurping in guilt, was Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Tue, 25 Mar 2008 10:50:20 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803251048320.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com> <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr> <47E81037.5030808@keyaccess.nl> <7vlk47ua3v.fsf@gitster.siamese.dyndns.org> <20080324235534.GE32221@josefsipek.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:51:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je5o9-0000Gj-MP
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 10:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbYCYJuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 05:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYCYJuY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 05:50:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:34794 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752491AbYCYJuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 05:50:24 -0400
Received: (qmail invoked by alias); 25 Mar 2008 09:50:21 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp026) with SMTP; 25 Mar 2008 10:50:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+6bh9IOJ+AU6HB3bZfB45kSR5IOL0JLco18h2vS
	jFeOGucqtghjt9
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080324235534.GE32221@josefsipek.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78165>

Hi,

[cutting down the Cc: list to the most-likely-interested parties]

On Mon, 24 Mar 2008, Josef Sipek wrote:

> On Mon, Mar 24, 2008 at 01:43:00PM -0700, Junio C Hamano wrote:
>
> > Not my mumbling, but I am quite open to slurp in guilt as a 
> > subdirectory in git.git at some point in the future just like we 
> > bundle git-gui and gitk if asked by the maintainer.
>
> That'd be great!  Is there anything special you want me to do?  Well, I 
> want to finish up a merge I've been working on first.

Would it not be more appropriate to slurp it in as a subproject?  But then 
the same grace period as for git-gui and gitk would apply, since we still 
expect some users not to have a submodule capable git...

Ciao,
Dscho
