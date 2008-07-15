From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git config oddity
Date: Tue, 15 Jul 2008 16:33:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807151631520.8950@racer>
References: <bd6139dc0807150744l78eb8d54ld167d3a9a5a600f@mail.gmail.com>  <alpine.DEB.1.00.0807151600170.8950@racer> <bd6139dc0807150829n2b3c88d7p18c203e93cd4e0c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jul 15 17:34:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImXy-0005Py-5v
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbYGOPdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbYGOPdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:33:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:47117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754112AbYGOPdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:33:24 -0400
Received: (qmail invoked by alias); 15 Jul 2008 15:33:22 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp007) with SMTP; 15 Jul 2008 17:33:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/YBZF6ia3Y3S6ZRRT9hDcBaKorDO0y1HQqCyPQxo
	IMHFKMCq3caJgm
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807150829n2b3c88d7p18c203e93cd4e0c1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88570>

Hi,

On Tue, 15 Jul 2008, Sverre Rabbelier wrote:

> On Tue, Jul 15, 2008 at 5:02 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > It is somewhat unfortunate that setting a variable does not find the 
> > section; the reason is that it sees sections only when a variable is 
> > set (to avoid having to do the parsing itself).
> 
> Ah, unfortunate indeed. I'm not sure I understand why it does not see 
> the existing header? I had a look at config.c but I couldn't really make 
> out why it doesn't.

The config writing uses the config parser to determine where the locations 
of the config variables (and therefore, sections) are by using the parser, 
and remembering the position in the file.

> Would it be difficult to add that?

Yes.

Ciao,
Dscho
