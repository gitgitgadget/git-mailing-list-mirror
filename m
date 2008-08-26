From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git wrapper: execute git-shell when argv[1] is
 '-c'
Date: Tue, 26 Aug 2008 02:52:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808260249090.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <48B29B2A.6000802@gnu.org> <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com>
 <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252251450.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080825210345.GE14930@eagain.net> <alpine.DEB.1.00.0808260001390.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080825222002.GF14930@eagain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 02:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXmjl-0007bq-CF
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 02:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbYHZAre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 20:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYHZAre
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 20:47:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:50975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752835AbYHZAre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 20:47:34 -0400
Received: (qmail invoked by alias); 26 Aug 2008 00:47:31 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 26 Aug 2008 02:47:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UFKlJHkkUmPY5OmfVssxF1BS4eSKofAmNVhW6Qa
	jeuVJHNEPm/QPK
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080825222002.GF14930@eagain.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93698>

Hi,

On Tue, 26 Aug 2008, Tommi Virtanen wrote:

> On Tue, Aug 26, 2008 at 12:05:21AM +0200, Johannes Schindelin wrote:
> > I do disagree with you that it is a kludge though.  I think it makes 
> > complete sense to add this to Documentation/git.txt in addition to 
> > other documentation that is lacking from my patch, though:
> > 
> > -- snip --
> > -c <command>::
> > 	execute <command> in git-shell.
> > -- snap --
> 
> All I'm going to say is that that's not the way you build trustable 
> software. You take a minimal interface and restrict untrusted users to 
> that, you don't add a feature to the widest possible interface..

I do not get your point.

But then, I think I start not to care anymore, as I think your reasoning 
is bogus.  "widest possible interface", "trustable software", etc.  Sounds 
pretty buzzy-wordy to me.

Yeah, you would need to audit it.  Maybe you would even have to check for 
"*argv[0] == '-'" and set argv[0] to "git-shell" if so.  But buzz-wording 
just makes me go away and not listen anymore.

Whatever,
Dscho
