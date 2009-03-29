From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Sun, 29 Mar 2009 11:50:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903291149460.10279@pacific.mpi-cbg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <3e8340490903282241u355ce5b3u1a6ff23b27f4ec12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnre4-0004Yu-Nl
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 11:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbZC2JsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 05:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbZC2JsE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:48:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:54923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752496AbZC2JsD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 05:48:03 -0400
Received: (qmail invoked by alias); 29 Mar 2009 09:47:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 29 Mar 2009 11:47:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wE8QzhWDwJxj0EQFXMUQM0zidqqm4LolAyzHgZw
	/nrKGIkk0HAeGU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3e8340490903282241u355ce5b3u1a6ff23b27f4ec12@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115009>

Hi,

On Sun, 29 Mar 2009, Bryan Donlan wrote:

> On Fri, Mar 27, 2009 at 3:21 AM, Ulrich Windl
> <ulrich.windl@rz.uni-regensburg.de> wrote:
> 
> > 3) "git undo": If possible undo the effects of the last command.
> 
> You can roll back the state of most local references by using the git 
> reflog (see git reflog --help for more information). This covers most 
> situations - but note that it only works to roll back to a committed 
> state, and won't save any uncommitted data at all.

Which is why you should commit early and often, and certainly before doing 
something bigger.

Ciao,
Dscho
