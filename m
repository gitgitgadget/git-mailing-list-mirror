From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Append ampersand to Target of lnk files created
  by do_cygwin_shortcut.
Date: Mon, 9 Mar 2009 22:12:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903092211230.6358@intel-tinevez-2-302>
References: <530ac78e0903091022s2585231br9ef11d91851250f4@mail.gmail.com>  <alpine.DEB.1.00.0903092109360.6358@intel-tinevez-2-302> <530ac78e0903091357v248895ack63588ae6e5e6b57a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Phil Lawrence <prlawrence@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:43:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgnGK-0001ZF-12
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 22:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbZCIVmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 17:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZCIVmY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 17:42:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:41006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751569AbZCIVmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 17:42:23 -0400
Received: (qmail invoked by alias); 09 Mar 2009 21:12:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 09 Mar 2009 22:12:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+w1IQH1M+wIBdUNRxZHo918jwiobu9z4RWizUnul
	G+HaiRvTwGBPDx
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <530ac78e0903091357v248895ack63588ae6e5e6b57a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112747>

Hi,

On Mon, 9 Mar 2009, Phil Lawrence wrote:

> On Mon, Mar 9, 2009 at 3:13 PM, Johannes Schindelin wrote:
>
> > Now, with the technical stuff out of the way: are you not changing 
> > behavior?  It seems that Linux users expect an program called by a 
> > menu item to block the application until the program returns, so that 
> > an error can be caught.
> 
> The menu item in question is "Repository | Create Desktop Icon".  It
> does not launch a program, but rather creates a shortcut (.lnk file)
> on the Windows desktop.
> 
> The purpose of the created shortcut is to make it easy for a user to
> launch git-gui for a particular repo in the future.
> 
> > Maybe the expectation is different on Windows?  But then, we'd still like
> > to catch errors and warn the user about it, right?
> 
> I believe a windows user would expect to see git gui launch when they
> click the shortcut; they would not expect (nor want) to see a cmd
> window open and remain open in the background.
> 
> msysGit avoids opening a command window altogether when it's Git GUI
> shortcut is used.  Ideally git on cygwin would also have shortcuts
> that simply open the GUI, but as a first step I saw we could at least
> make the command window politely disappear.

Thank you!

Could you add those explanations to the commit message?

Thanks,
Dscho
