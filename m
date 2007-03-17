From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Sat, 17 Mar 2007 18:29:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703171054580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil>  <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> 
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <e5bfff550703161120o4571769eq18c13ae29ac79957@mail.gmail.com> 
 <e5bfff550703161138x5ab1fe3anf7b2aaab81bb77e4@mail.gmail.com> 
 <alpine.LFD.0.83.0703161454280.18328@xanadu.home> 
 <e5bfff550703161407u6afefae9u4a23cf1cb49125ce@mail.gmail.com> 
 <Pine.LNX.4.63.0703170014130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550703170004n3ab9075euf66a9e6dd56040d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 18:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSciy-0000Gk-GC
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 18:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbXCQR3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 13:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbXCQR3q
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 13:29:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:54866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752582AbXCQR3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 13:29:45 -0400
Received: (qmail invoked by alias); 17 Mar 2007 17:29:44 -0000
X-Provags-ID: V01U2FsdGVkX19CrbtvB5FCof52zF/VA2ipdRIWk/oG6TaET6ZrV4
	6YqlaGsWbSw0/o
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550703170004n3ab9075euf66a9e6dd56040d7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42443>

Hi,

On Sat, 17 Mar 2007, Marco Costalba wrote:

> On 3/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > The common solution for your problem _is_ to use threads.
> 
> I would say, the common solution to have non blocking libgit is to use 
> threads in the tool linked with libgit.

Yes, that's what I tried to say.

> > And you have to admit that _only_ viewers would need asynchronous 
> > access anyway. I doubt that other tools -- which could take their 
> > advantage of a libgit -- would need such an access.
> 
> Yes, and you have to admit ;-)  that viewers are the tools that mostly 
> will use libgit.

I hope that there are many more users. _And_ not all viewers want to do 
the display asynchronously. For example, statplot takes the time it takes.

Ciao,
Dscho
