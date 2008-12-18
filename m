From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: force focus to main window
Date: Thu, 18 Dec 2008 04:14:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812180413240.14632@racer>
References: <4948E771.4050705@viscovery.net> <18761.29020.237388.687560@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 04:16:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD9NP-00027t-Ol
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 04:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbYLRDPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 22:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYLRDPW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 22:15:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:56144 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751487AbYLRDPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 22:15:21 -0500
Received: (qmail invoked by alias); 18 Dec 2008 03:15:19 -0000
Received: from pD9EB2D4F.dip0.t-ipconnect.de (EHLO noname) [217.235.45.79]
  by mail.gmx.net (mp067) with SMTP; 18 Dec 2008 04:15:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18I0G4uEj4IBDc1J8NeYZCsSp6rlBHGbcJcOcEaGM
	tYSHZQHRFW5ldu
X-X-Sender: gene099@racer
In-Reply-To: <18761.29020.237388.687560@cargo.ozlabs.ibm.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103424>

Hi,

On Thu, 18 Dec 2008, Paul Mackerras wrote:

> Johannes Sixt writes:
> 
> > On msysGit, the focus is first on the (Tk) console.  This console is 
> > then hidden, but keeps the focus.  Work around that by forcing the 
> > focus onto the gitk window.
> 
> Hmmm, I don't like doing focus -force unconditionally on all platforms.  
> I hate it when applications decide they know best and override what the 
> window manager decides.

>From my previous experience with my patches to gitk, I did not expect 
otherwise.  That is why I did not even bother with this one.

> At least put a if {[tk windowingsystem] eq "win32"} in there. (msysGit 
> is a windows thing, isn't it?)

Yeah, because on other platforms, when you start gitk, you don't want it 
to take focus.  Yeah, right.

Ciao,
Dscho
