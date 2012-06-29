From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: Apostrophe at the end of author name
Date: Fri, 29 Jun 2012 20:17:01 +0200
Message-ID: <20120629181701.GB6533@camk.edu.pl>
References: <20120629124122.GG1258@camk.edu.pl>
 <robbat2-20120629T170457-788694600Z@orbis-terrarum.net>
 <20120629174358.GB3804@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 20:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Skfku-0007G2-T9
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 20:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab2F2SRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 14:17:16 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:55542 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab2F2SRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 14:17:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 171735F004D;
	Fri, 29 Jun 2012 20:18:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1AJXfoq0zZmB; Fri, 29 Jun 2012 20:18:08 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 9B6EB5F004A;
	Fri, 29 Jun 2012 20:18:08 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 53F354673B; Fri, 29 Jun 2012 20:17:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120629174358.GB3804@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200821>

On Fri, Jun 29, 2012 at 01:43:58PM -0400, Jeff King wrote:
> On Fri, Jun 29, 2012 at 05:05:31PM +0000, Robin H. Johnson wrote:

> > On Fri, Jun 29, 2012 at 02:41:22PM +0200,  Kacper Kornet wrote:
> > > I try to import some repositories into git and one of the developers has
> > > asked his name to be presented as: Name 'Nick' <email>.
> > > However git commit --author="Name 'Nick' <email>" strips the last
> > > apostrophe and produces a commit authored by: Name 'Nick <email>.

> > > Maybe the function  strbuf_addstr_without_crud in ident.c should strip
> > > the trailing apostrophe only when it removed it also from the beginning
> > > of the string?
> > Which version of Git? And is it being stripped by git, or one of the
> > import tools?

> I'm sure it's the most recent one,

Yes, it is 1.7.11

>  as strbuf_addstr_without_crud was
> only added recently (but it is a refactoring of older code which should
> have the same behavior).

It depends what you call recently. It was refactored in July 2005
(commit: 6aa33f4035d5). But it looks like the previous code (before
refactoring) removed only comma, dot and semicolon from the end of the
author name.

-- 
  Kacper
