From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Wed, 20 Feb 2008 02:01:34 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0802200156560.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org> <47BAF18F.5040709@freescale.com> <alpine.LNX.1.00.0802191127080.19024@iabervon.org> <7vy79ghbob.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802191856420.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Loeliger <jdl@freescale.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdLs-0007En-PY
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762707AbYBTBBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763679AbYBTBBi
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:01:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:42785 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757083AbYBTBBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:01:37 -0500
Received: (qmail invoked by alias); 20 Feb 2008 01:01:34 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp025) with SMTP; 20 Feb 2008 02:01:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LrKMqJY/LkLw/UxjHQRqtTOV5Ps4U0j1cYxlvke
	Dgpr8AgfcBKopN
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LNX.1.00.0802191856420.19024@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74489>

Hi,

On Tue, 19 Feb 2008, Daniel Barkalow wrote:

> On Tue, 19 Feb 2008, Junio C Hamano wrote:
> 
> > Either your '[host "$this_url"] aka = $that_url' or
> > Dscho's earlier '[rewrite "$this_url_to"] url = $that_url' shows
> > that this is not about host but "prefix part of URL".
> 
> Well, it shows that it's *possible* to do this feature that way, 
> although I'm not entirely convinced that it's best to do it like that. 

I think in the interest of simplicity, you do not want to have an extra 
(arbitrary) key.

> Are there character set concerns with having urls in config keys?

I think not.  AFAICT the "extended base var" is allowed anything except 
for newlines.  Everything else you can get at least escaped with '\'.  If 
in doubt, consult get_extended_base_var() in config.c.

Hth,
Dscho
