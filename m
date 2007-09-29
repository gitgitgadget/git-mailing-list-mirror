From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stashing untracked files
Date: Sat, 29 Sep 2007 22:51:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709292248400.28395@racer.site>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site>
 <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Neil Macneale <mac4-git@theory.org>, git <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sat Sep 29 23:52:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbkF0-0001Ar-AW
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 23:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbXI2Vwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 17:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754229AbXI2Vwn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 17:52:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:52901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754135AbXI2Vwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 17:52:42 -0400
Received: (qmail invoked by alias); 29 Sep 2007 21:52:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp016) with SMTP; 29 Sep 2007 23:52:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nRcUn3H3nrRDdI1CI1Daem61sbTKqBJPjoGELb2
	A2EvoOEtxAZVwF
X-X-Sender: gene099@racer.site
In-Reply-To: <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59496>

Hi,

On Sat, 29 Sep 2007, Benoit SIGOURE wrote:

> On Sep 29, 2007, at 11:03 PM, Johannes Schindelin wrote:
> 
> > Instead this is what you _should_ do:
> > 
> > git add <the files that you care about>
> > git stash
> 
> You could stash untracked files that are not ignored (I personally 
> ignore *.o, *.a and the like).

And what if you happen to forget to ignore that?  Or if you happen to 
have an strace log in some file (which you did not ignore either)?

Thanks, but I think the semantics of git stash is pretty well defined.  
And it means that you stash away _tracked_ content that was not yet 
committed.

I mean, you can have your desired behaviour with

$ git add .
$ git stash

but if we were to fulfil your wish and change the default behaviour, there 
is no way back to the current behaviour (which I happen to find pretty 
sane).

Ciao,
Dscho
