From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 22:41:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806132239490.6439@racer>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>  <20080611213648.GA13362@glandium.org>  <alpine.DEB.1.00.0806112242370.1783@racer>  <20080611230344.GD19474@sigill.intra.peff.net> 
 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>  <loom.20080612T042942-698@post.gmane.org>  <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>  <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>  <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> 
 <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1742235697-1213393309=:6439"
Cc: Eric Raible <raible@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:44:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7H4I-00022t-V1
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 23:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbYFMVn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 17:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbYFMVn3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 17:43:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:43397 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752392AbYFMVn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 17:43:28 -0400
Received: (qmail invoked by alias); 13 Jun 2008 21:43:25 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 13 Jun 2008 23:43:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18C6mpUwGMCbk3rAtAmAx7eTvP0apfs7tVSMXxsRF
	jXi5F8xGiSuItA
X-X-Sender: gene099@racer
In-Reply-To: <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84944>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1742235697-1213393309=:6439
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 13 Jun 2008, Wincent Colaiuta wrote:

> El 13/6/2008, a las 6:52, Johannes Schindelin escribió:
> 
> >If you need something from the stash a day after stashing it, you have 
> >a serious problem with understanding what branches are for.
> 
> While this may be true for codebases which move forward quickly, what 
> about one which is basically finished and tends not to get touched in a 
> long time. A situation arises, you stash something, the phone rings, and 
> for whatever reason the stash gets forgotten and you don't revisit the 
> project at all for days, weeks, months. It wouldn't be nice to 
> eventually come back and discover that your in-progress work had been 
> "garbage" collected for you.

You cannot be serious about not wanting to lose the changes when you keep 
them in _one_ _single_ repository anyway.

And you cannot be serious about not wanting to lose the changes when you 
forget about them, for months, even.

So you are making my point for me.

Thanks,
Dscho

--8323329-1742235697-1213393309=:6439--
