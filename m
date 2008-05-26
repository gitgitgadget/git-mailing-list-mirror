From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Mon, 26 May 2008 12:00:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261200330.30431@racer>
References: <20080524043118.GA23118@laptop>  <m3ve142jkc.fsf@localhost.localdomain>  <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com>  <200805241259.13132.jnareb@gmail.com> <483A7B1F.1050608@op5.se>  <alpine.DEB.1.00.0805261113050.30431@racer>
 <fcaeb9bf0805260357t2bce7753vab5331bb21d98e4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 13:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0aSR-0002av-QK
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 13:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbYEZLAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 07:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYEZLAr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 07:00:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:43919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753857AbYEZLAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 07:00:47 -0400
Received: (qmail invoked by alias); 26 May 2008 11:00:45 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp011) with SMTP; 26 May 2008 13:00:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/mdEEoC2/pZ4lrpa5EOg5beik7yk0bbBIEJ3R5N
	mY5DiZ8ZV0gRTI
X-X-Sender: gene099@racer
In-Reply-To: <fcaeb9bf0805260357t2bce7753vab5331bb21d98e4b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82919>

Hi,

On Mon, 26 May 2008, Nguyen Thai Ngoc Duy wrote:

> On Mon, May 26, 2008 at 5:16 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Besides, it would be a kludge at best to work _twice_ to find out the
> > search terms, once in the external grep, and a second time in the coloring
> > code.  So I think it should not be done.
> 
> I think if it's GNU grep, just passing it --color, it will grep and
> colorize search terms in one turn.

And what tells you that the called grep is GNU grep?

Ciao,
Dscho
