From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 19:39:25 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806231938020.6440@racer>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <alpine.DEB.1.00.0806231756340.6440@racer>
 <alpine.LFD.1.10.0806231019170.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAqzk-0004sF-9m
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbYFWSla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbYFWSla
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:41:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:44872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752979AbYFWSl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 14:41:29 -0400
Received: (qmail invoked by alias); 23 Jun 2008 18:41:24 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp059) with SMTP; 23 Jun 2008 20:41:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/h7OZGQ1nhpLyyNaJ/qCM5bl7umbkDjw97LfM+Zq
	rzmA1GOra00/43
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0806231019170.2926@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85902>

Hi,

On Mon, 23 Jun 2008, Linus Torvalds wrote:

> (And yes, I can handle even the --help cases. It's actually not that 
> hard to just remember all the different option structs you've seen, and 
> handle all of that totally independently internally in parse_options(). 
> You don't need recursion, you just need a trivial list of options.)

So what you actually do is just linearizing the recursion.  Well then, 
yes, your solution is good.

However, I thought that recursion (as I implemented it) would make the 
revlist option parsing (which includes diff parsing) quite nice.

Whatever,
Dscho
