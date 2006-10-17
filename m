From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 12:45:33 +0200
Message-ID: <1161081933.26677.35.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	 <45345AEF.6070107@utoronto.ca>
	 <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
	 <Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 12:45:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZmS8-00022o-9i
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbWJQKpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161218AbWJQKpl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:45:41 -0400
Received: from elephant.oekohosting.ch ([80.74.144.79]:7826 "EHLO
	elephant.oekohosting.ch") by vger.kernel.org with ESMTP
	id S1161234AbWJQKpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 06:45:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id AB2D962C147;
	Tue, 17 Oct 2006 12:45:34 +0200 (CEST)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22040-01; Tue, 17 Oct 2006 12:45:31 +0200 (CEST)
Received: from [192.168.1.7] (133.50.76.83.cust.bluewin.ch [83.76.50.133])
	by elephant.oekohosting.ch (Postfix) with ESMTP id DC67662C074;
	Tue, 17 Oct 2006 12:45:29 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.8.1 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29054>

Hi,

On Tue, 2006-10-17 at 12:30 +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 17 Oct 2006, Sean wrote:
> 
> > On Tue, 17 Oct 2006 00:24:15 -0400
> > Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> > 
> > > - - you can have working trees on local systems while having the
> > >   repository on a remote system.  This makes it easy to work on one
> > >   logical branch from multiple locations, without getting out of sync.
> > 
> > That is a very nice feature.  Git would be improved if it could
> > support that mode of operation as well.
> 
> It would also make things slow as hell. How do you deal with something 
> like annotate in such a setup?

You'd probably have to do all processing server-side (git log, blame,
merges... like in subversion, where you can merge and rename/move files
remotely, IIRC). Of course, all the things which make git really useful
for me (gitk, git log with all its arguments etc.) would not be
available. Cheap checkouts would be made possible easily that way at the
cost of higher server load and an abstraction layer over network for
object access.

I don't know if that sounds reasonable at all.

	Matthias
