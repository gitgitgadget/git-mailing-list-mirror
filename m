From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Mon, 13 Oct 2008 19:57:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810131956360.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081013140938.GM4856@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:52:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRae-0004Rw-6f
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbYJMRvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYJMRvI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:51:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:34174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752231AbYJMRvG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:51:06 -0400
Received: (qmail invoked by alias); 13 Oct 2008 17:51:02 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 13 Oct 2008 19:51:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dgKdYnYBduI1bIO3S/A/Uroo6Gwr58ffWf6FQv4
	18kBEdq6xhyeLh
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081013140938.GM4856@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98133>

Hi,

On Mon, 13 Oct 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > 	Strangely, some more tests refused to pass this time, because they 
> > 	did not use --update-head-ok; this was fixed, too.
> 
> Not strange, --update-head-ok was busted and the tests took advantage of 
> it.  :-\

Heh.  My "this time" was meant as "since the first revision of the patch".  
I really tested the first revision, promise!  And those tests did not fail 
back then.  Or I am even stupider than I am prepared to admit.

Ciao,
Dscho
