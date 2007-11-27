From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Tue, 27 Nov 2007 15:10:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271510090.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org>
 <Pine.LNX.4.64.0711230050270.27959@racer.site>
 <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com>
 <Pine.LNX.4.64.0711230149430.27959@racer.site> <20071123205958.GC14735@spearce.org>
 <20071125170019.GB25800@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0711261647400.27959@racer.site>
 <20071127101614.GB26072@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0711271123360.27959@racer.site>
 <20071127145103.GA30020@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 16:11:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix25b-0002kL-DM
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbXK0PKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 10:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbXK0PKs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:10:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:35877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755354AbXK0PKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:10:47 -0500
Received: (qmail invoked by alias); 27 Nov 2007 15:10:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 27 Nov 2007 16:10:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PbdxJmHXPpV35thMW2qADnewgnUDF09g5dioHT2
	6a01Rnn82+sonm
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127145103.GA30020@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66224>

Hi,

On Tue, 27 Nov 2007, Karl Hasselstr?m wrote:

> On 2007-11-27 11:25:47 +0000, Johannes Schindelin wrote:
> 
> > Ah, so you would like something like "git --interactive"? This is 
> > indeed a completely different scope than the fast-export thingie,
> 
> Yes. Or rather, I _think_ that's what I want. The only numbers I have is 
> that StGit makes a number of trivial git calls that right now take on 
> the order of 10 ms apiece, so the first step in this direction would be 
> to build a simple prototype just to see what kind of speed-up one could 
> expect (both in the git calls, and in StGit overall).

I'd rather see you using libgit-thin's Python binding.

Ciao,
Dscho
