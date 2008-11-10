From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 20:51:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com> <20081110191134.GA3329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:45:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzchk-0003mM-SE
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbYKJTob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYKJTob
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:44:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:58390 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751158AbYKJToa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:44:30 -0500
Received: (qmail invoked by alias); 10 Nov 2008 19:44:21 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 10 Nov 2008 20:44:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1L7kkuL21u+N3MzL0tASwC2OsDt2IXlAAo/+yl7
	/u80YmcJzt3Qxc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081110191134.GA3329@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100551>

Hi,

On Mon, 10 Nov 2008, Jeff King wrote:

> On Mon, Nov 10, 2008 at 12:37:20PM -0500, Thomas Harning wrote:
> 
> > Just wondering, has there been any looking into whether the git-notes 
> > concept can track rebases?
> 
> Not that I know of, but then again, I'm not sure exactly what you mean 
> by "track rebases".

I guess he means that you could have something like this

	rebased from <SHA-1>

in the notes for any given commit, so that _if_ you have the commit, e.g. 
gitk could show that connection (maybe dashed in the graphical history 
display, and as a "Rebased from:" link).

Ciao,
Dscho
