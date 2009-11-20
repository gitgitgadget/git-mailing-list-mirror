From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Fri, 20 Nov 2009 11:36:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911201135230.4985@pacific.mpi-cbg.de>
References: <1258681154-2167-1-git-send-email-johan@herland.net> <7vk4xl5y3z.fsf@alter.siamese.dyndns.org> <20091120192800.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 11:32:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBQn9-0001M6-3u
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbZKTKcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbZKTKcS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:32:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:41598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751263AbZKTKcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:32:17 -0500
Received: (qmail invoked by alias); 20 Nov 2009 10:32:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 20 Nov 2009 11:32:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Xsyx7DSZXN56O8qKKQm3AZsV8uCIG1AGMMdNSBB
	/yGjZstqUTdGA4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091120192800.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133327>

Hi,

On Fri, 20 Nov 2009, Nanako Shiraishi wrote:

> Quoting Junio C Hamano <gitster@pobox.com>
> 
> > So here is what I did tonight.
> >
> > Step 0.  Apply as you specified on top of 'next'
> >
> >     $ git checkout next^0
> >     $ git am -s your-10-patches
> >     $ M=$(git describe)
> >
> > Step 1.  Rebase back to the bottom of the old series
> >
> >     $ git checkout next...jh/notes
> 
> What do three-dots mean in this command?

Maybe it means "go back to the bottom of the old series"? ;-)  IIUC it is 
the equivalent of

	$ git checkout $(git merge-base next jh/notes)

Hth,
Dscho
