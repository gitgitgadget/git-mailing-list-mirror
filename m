From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 12:47:12 +0200
Message-ID: <20070715104712.GF2568@steel.home>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: VMiklos <vmiklos@frugalware.org>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 15 12:47:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA1dI-0003j8-IX
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 12:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbXGOKrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 06:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbXGOKrR
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 06:47:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:63606 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbXGOKrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 06:47:16 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (klopstock mo28) (RZmta 8.3)
	with ESMTP id 301ba2j6F4QZUb ; Sun, 15 Jul 2007 12:47:14 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 97A6C277BD;
	Sun, 15 Jul 2007 12:47:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0844BC164; Sun, 15 Jul 2007 12:47:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715083959.GC999MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52540>

Sven Verdoolaege, Sun, Jul 15, 2007 10:39:59 +0200:
> On Fri, Jul 13, 2007 at 11:46:30PM +0200, VMiklos wrote:
> > i mean, first i thought that after configuring a submodule under libfoo,
> > then a git pull will update libfoo's repo under libfoo, too. or
> > something like that.
> 
> Unless I've missed something, it doesn't.
> Some of use would like git to do just that (at least Alex Riesen,
> Martin Waitz and myself have sent in patches to that effect),
> but we haven't been able to convince Junio yet.

Count me out. Junio convinced me instead and having tried the
subprojects I find it really convenient: I can choose when and what
should be updated and I can see what _can_ be updated, iff I decide
to. Subprojects defined in such a loosely way are more flexible then
having git-pull fetch subprojects by default. Sometimes I even want be
_sure_ the subprojects are completely untouched (I have some critical
parts in them).
