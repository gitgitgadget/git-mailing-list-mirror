From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Mon, 12 Nov 2007 17:30:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121727130.4362@racer.site>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ird7z-0001Cb-EJ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758487AbXKLRa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758602AbXKLRa1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:30:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:59877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758487AbXKLRa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:30:26 -0500
Received: (qmail invoked by alias); 12 Nov 2007 17:30:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 12 Nov 2007 18:30:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9qAJGT5X9uGwt9yAxmy5pjbUhYuSz6n3ZcxT0qW
	9R5FOsPudEi5d0
X-X-Sender: gene099@racer.site
In-Reply-To: <18232.35893.243300.179076@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64671>

Hi,

On Mon, 12 Nov 2007, Bill Lear wrote:

> We have an administrator create a new bare repo for us, and we populate 
> it by pushing into it.  It wold be nice if the administrator could 
> create a bare repo and we could clone from it, and push to it to 
> populate it, instead of cloning the bare repo from another repo that has 
> already been (partly) populated.

I don't see what is soooo hard with using git-remote in the repo you are 
pushing from.  It's just a "git remote add origin <url>", and you can even 
use this to push right afterwards: "git push --all origin".

Besides, if you really want to work together, chances are that you do 
_not_ want to start with <n> independent initial commits.  So you need to 
populate the repository before starting _anyway_.

Why are easy solutions so unattractive?

Ciao,
Dscho
