From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -
	scripts/get_maintainer.pl
Date: Tue, 14 Aug 2007 10:00:24 -0700
Message-ID: <1187110824.32555.76.camel@localhost>
References: <1186984174.10249.7.camel@localhost>
	 <200708131933.10125.m.kozlowski@tuxland.pl>
	 <1187026955.2688.4.camel@laptopd505.fenrus.org>
	 <1187037445.6628.98.camel@heimdal.trondhjem.org>
	 <1187054366.2757.0.camel@laptopd505.fenrus.org>
	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>
	 <46C1CFFE.4000001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 19:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKzlB-0006Gz-I6
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 19:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764038AbXHNRAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 13:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763169AbXHNRAe
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 13:00:34 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:4665 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760732AbXHNRAc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 13:00:32 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id KAA23096;
	Tue, 14 Aug 2007 10:22:55 -0700
In-Reply-To: <46C1CFFE.4000001@gmail.com>
X-Mailer: Evolution 2.10.2-2.1mdv2007.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55841>

On Tue, 2007-08-14 at 17:53 +0200, Rene Herman wrote:
> It isn't about MODULE_FOO() tags, it is about tagging /source/ files 
> to help with putting CCs on patch submissals.
> If we want to link source file foo.c and the 
> MAINTAINERS information, we have 3 options:
> 1. MAINTAINERS --> foo.c
> 2. foo.c --> MAINTAINERS
> 3. foo.c <--> some 3rd file <--> MAINTAINERS

I added git@vger.kernel.org and Junio Hamano

Another possibility is improving git to allow
some sort of "declaration of interest" in bits
of projects.

That would allow options like:

o  git-format-patch to include CCs
o  git-commit and git-branch to notify or
     take some other action

etc...

It's generic, applies to multiple projects, etc.

I don't care which mechanism is used, I just want
to be able to CC appropriate people and lists on
changes to their areas of interest without wasting
time searching all over the place per file changed.

The LK MAINTAINERS file is weakly specified, but
I'm not a git-geek, nor do I want to be one, so
MAINTAINERS was the file I could easiest change
with minimal impact to LK sources.

The get_maintainer script is trivial,
I'm not wedded to it at all.
