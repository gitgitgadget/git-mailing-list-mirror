From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 15:25:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org>
 <20070321051406.GW96806@codelabs.ru> <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070321115004.GB14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Mar 21 15:25:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU1kw-0002TA-9y
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 15:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbXCUOZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 10:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbXCUOZf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 10:25:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:35684 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752850AbXCUOZe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 10:25:34 -0400
Received: (qmail invoked by alias); 21 Mar 2007 14:25:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 21 Mar 2007 15:25:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Txi9RoPWT/raLzPXtwFM6Ag16qj1MKPISMiyhu8
	zbSaXNyXmy17VU
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070321115004.GB14837@codelabs.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42789>

Hi,

On Wed, 21 Mar 2007, Eygene Ryabinkin wrote:

> Wed, Mar 21, 2007 at 12:16:40PM +0100, Johannes Schindelin wrote:
> > > Will try to implement. But still, NO_GUI should ban the GUI tools from 
> > > being built and installed, because user can have the Tcl/Tk available, 
> > > but have no intention to use the git GUI. Am I right?
> > 
> > I am not quite certain if I agree. With a similar reasoning, you could 
> > introduce a flag to prevent pull-request from being installed, and 
> > git-tag, or other rarely used functions. Is it so bad to have gitk and 
> > git-gui installed?
> 
> I am happening to develop on some machines on which I have no
> X-Windows or any GUI providers at all, so I prefer not to have the
> Tcl/Tk dependency at all.

My point (and I think it's the same point as Jakub's) is that NO_GUI is a 
misnomer. It should be NO_TCL, since the only reason you state to skip 
installation of these parts is that they depend on X11, which is not 
installed on the machine.

If you don't do something, it is often interesting to state why: if you 
don't install something to prevent a dependency you don't want to have, it 
is different from saying that you do not want to have a GUI, _even if_ the 
dependency is there already.

Conclusion: I am in favour of NO_TCL, but not of NO_GUI.

Ciao,
Dscho
