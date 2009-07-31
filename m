From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: External Diff Tool
Date: Fri, 31 Jul 2009 12:18:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907311217290.4503@intel-tinevez-2-302>
References: <4A70AE1F.7070004@idmcomp.com> <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com> <4A71F2F1.4060605@idmcomp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Eric Stegemoller <estegemoller@idmcomp.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 12:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWpC0-00087v-8w
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZGaKSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbZGaKSS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:18:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:43027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752052AbZGaKSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 06:18:17 -0400
Received: (qmail invoked by alias); 31 Jul 2009 10:18:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 31 Jul 2009 12:18:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LyMhk578LuB8oAkzaQ1cavY73nvKg2muU5WbvWN
	+tdHvo07tpSugm
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A71F2F1.4060605@idmcomp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124538>

Hi,

On Thu, 30 Jul 2009, Eric Stegemoller wrote:

> Bert Wesarg wrote:
> > On Wed, Jul 29, 2009 at 22:16, Eric Stegemoller<estegemoller@idmcomp.com>
> > wrote:
> >   
> > > Hello,
> > >
> > >  git config --global diff.tool TestTool
> > >  git config --global difftool.TestTool.cmd ""c:/TestTool/test.exe"
> > >  "$LOCAL"
> > >     
> > Try with quoting the " inside the config value:
> >
> >   git config --global difftool.TestTool.cmd "\"c:/TestTool/test.exe\"
> > \"$LOCAL\" \"$REMOTE\""
> >   Bert
> >   
> Thanks, but this did not solve it. Interestingly, I have captured the 
> command line that is sent out by GIT and it is calling the correct 
> program but not adding anything to the command line. So, nothing is 
> there. Seeing this I have been experimenting around with the parameters 
> and I still it is calling the correct program but sending a blank 
> command line. Any suggestions on how to pursue this?

First thing I'd do is to call it with GIT_TRACE=1.  If that does not help, 
I would modify the source to see what is happening.

I see that you're on Windows, and I could imagine this to be a 
Windows-specific problem.

Ciao,
Dscho
