From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 16:16:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161616150.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47130B25.4010304@viscovery.net> <20071015231242.GR27899@spearce.org>
 <471455ED.8070408@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhoAY-0008M5-T2
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbXJPPRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 11:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759120AbXJPPRG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:17:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:60556 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758886AbXJPPRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 11:17:05 -0400
Received: (qmail invoked by alias); 16 Oct 2007 15:17:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 16 Oct 2007 17:17:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Q1xISJTEQq1F5FYwrPudCcpp81sia+a4Y1zR9+F
	7AD5nSLpdDSqhc
X-X-Sender: gene099@racer.site
In-Reply-To: <471455ED.8070408@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61191>

Hi,

On Tue, 16 Oct 2007, Johannes Sixt wrote:

> Shawn O. Pearce schrieb:
> > Johannes Sixt <j.sixt@viscovery.net> wrote:
> > > Unfortunately, "Fetch" does not yet work[*] from within git-gui, so you
> > > have to fall back to git-fetch on the command line.
> > > 
> > > [*] Note the distinction between "not available" and "does not work".
> > 
> > What's broken?  Is this that Git protocol dump showing up in
> > git-gui's console window thing?
> > 
> > Are you using the C based fetch that is in git.git's next branch,
> > or the shell script based one that is in master?  Which Tcl/Tk
> > version are you using to run git-gui?
> 
> It's the scripted fetch that does not work. The symptom is that the output of
> at least one of the commands (upload-pack, I think, because what I see is
> wire protocol) goes to a newly spawned console instead of wherever it was
> redirected to.
> 
> I didn't bother reporting since builtin-fetch is on the way (which will
> hopefully make this a moot point) and our team here is comfortable with
> calling git fetch on the command line.

Note that Issue 57 on msysgit.googlecode.com talks exactly about the same 
issue.

Ciao,
Dscho
