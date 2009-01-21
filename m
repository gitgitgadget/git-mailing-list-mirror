From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Newbie Query
Date: Wed, 21 Jan 2009 01:05:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210103100.19014@racer>
References: <20090120191952.GA25322@uts.thewillards.local> <3f4fd2640901201217x22262655w115cc2a25e32865e@mail.gmail.com> <49763D2B.1000607@morey-chaisemartin.com> <200901201534.16571.bss@iguanasuicide.net> <49764647.1080606@morey-chaisemartin.com>
 <20090120235125.GD17746@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQc6-0003nG-8R
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135AbZAUAFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756870AbZAUAFI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:05:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:51816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756792AbZAUAFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:05:07 -0500
Received: (qmail invoked by alias); 21 Jan 2009 00:05:05 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp048) with SMTP; 21 Jan 2009 01:05:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+R05QJBL+RL76N03eW6NM31eAPHGL04j2AOcQk9l
	1N6K88XuaIap8L
X-X-Sender: gene099@racer
In-Reply-To: <20090120235125.GD17746@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106543>

Hi,

On Tue, 20 Jan 2009, Jeff King wrote:

> On Tue, Jan 20, 2009 at 10:46:47PM +0100, Nicolas Morey-Chaisemartin wrote:
> 
> > Well I know there are solutions to convert it to a bare repo.
> > I was just wondering if there was a "clean" one which really converts
> > the repo to a bare one and not create a copy which is bare.
> 
> It has been a long time since I have done this. It used to be that you 
> could simply "mv foo/.git foo.git" and be done with it. These days I 
> think you would also need "git config core.bare true". But I haven't 
> actually tested it recently.

Yep, you need to set that option.  At least if you initialized your 
repository with anything newer than v1.5.0-rc1~3^2~2.

Ciao,
Dscho
