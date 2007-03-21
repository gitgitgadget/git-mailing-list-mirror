From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 17:40:08 +0300
Message-ID: <20070321144008.GE14837@codelabs.ru>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org> <20070321051406.GW96806@codelabs.ru> <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070321115004.GB14837@codelabs.ru> <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 21 15:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU1zD-0000Vd-9F
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 15:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbXCUOkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 10:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbXCUOkT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 10:40:19 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:63239 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbXCUOkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 10:40:17 -0400
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HU1z3-0004NX-00; Wed, 21 Mar 2007 17:40:13 +0300
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42791>

Johannes,

Wed, Mar 21, 2007 at 03:25:32PM +0100, Johannes Schindelin wrote:
> > I am happening to develop on some machines on which I have no
> > X-Windows or any GUI providers at all, so I prefer not to have the
> > Tcl/Tk dependency at all.
> 
> My point (and I think it's the same point as Jakub's) is that NO_GUI is a 
> misnomer. It should be NO_TCL, since the only reason you state to skip 
> installation of these parts is that they depend on X11, which is not 
> installed on the machine.

Can't speak for Jakub, but it seems to me that he just suggested
that the configure should look if the Tcl/Tk is available and refuse
to install the GUI tools if there is no Tcl/Tk. Though only Jakub
can tell for sure.

> If you don't do something, it is often interesting to state why: if you 
> don't install something to prevent a dependency you don't want to have, it 
> is different from saying that you do not want to have a GUI, _even if_ the 
> dependency is there already.

But I am saying that I do not want the GUI tools installed because
I do not need GUI at all. And if the GUI will be rewritten to the
Qt (oh, my, don't do that) I will still have no need of it.

> Conclusion: I am in favour of NO_TCL, but not of NO_GUI.

I am not against such renaming as long as the TCL will be used
for the GUI part of git. Should I file a patch for the NO_GUI ->
NO_TCL change? What do others think about the knob name?
-- 
Eygene
