From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 16 May 2007 00:27:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705152305460.6410@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
 <Pine.LNX.4.64.0705081256410.4167@racer.site> <87sl9ygau1.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1633736924-1179263192=:6410"
Cc: git@vger.kernel.org
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed May 16 01:27:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho6Qe-0003M9-EN
	for gcvg-git@gmane.org; Wed, 16 May 2007 01:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbXEOX1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 19:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756849AbXEOX1g
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 19:27:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:60269 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756431AbXEOX1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 19:27:35 -0400
Received: (qmail invoked by alias); 15 May 2007 23:27:33 -0000
Received: from unknown (EHLO localhost) [138.251.11.42]
  by mail.gmx.net (mp036) with SMTP; 16 May 2007 01:27:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5egMdyOq5jvzh0cJHIg/Ec3jiB2u/IJeoqL5VUX
	wkuehEnuEFiQLO
X-X-Sender: gene099@racer.site
In-Reply-To: <87sl9ygau1.fsf@morpheus.local>
Content-ID: <Pine.LNX.4.64.0705160025560.6410@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47389>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1633736924-1179263192=:6410
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0705160025561.6410@racer.site>

Hi,

On Mon, 14 May 2007, David Kågedal wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Therefore, I now put all changed files into the index (git add -u), 
> > and clean up the files one by one, always checking with "git diff" and 
> > "git diff HEAD" what I still have to do.
> 
> Why not simply use a temporary branch for this? They're free, and you 
> can diff just as easily, if not more. And you don't risk losing it if 
> you slip with a command.

Because it is much faster to work with the index?

Ciao,
Dscho
--8323584-1633736924-1179263192=:6410--
