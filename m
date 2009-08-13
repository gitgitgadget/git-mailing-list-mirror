From: Johan Herland <johan@herland.net>
Subject: Re: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Thu, 13 Aug 2009 02:20:02 +0200
Message-ID: <200908130220.02517.johan@herland.net>
References: <1250036031-32272-1-git-send-email-johan@herland.net>
 <200908121108.28714.johan@herland.net> <4A83579E.70302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	barkalow@iabervon.org, gitster@pobox.com,
	Johannes.Schindelin@gmx.de, Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 13 02:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbO3H-0001jX-OE
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 02:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbZHMAUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 20:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbZHMAUF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 20:20:05 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58288 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750741AbZHMAUE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 20:20:04 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOA0048CGXGDK80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 02:20:04 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOA00K90GXE9C20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 13 Aug 2009 02:20:04 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.13.919
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <4A83579E.70302@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125759>

On Thursday 13 August 2009, Michael Haggerty wrote:
> Johan Herland wrote:
> > On Wednesday 12 August 2009, David Aguilar wrote:
> >> On Wed, Aug 12, 2009 at 02:13:49AM +0200, Johan Herland wrote:
> >>> +	def __init__ (self, date, author, message):
> >>> +		self.revs    = {}      # dict: path -> CvsRev object
> >>> +		self.date    = date    # CvsDate object
> >>> +		self.author  = author
> >>> +		self.message = message # Lines of commit message
> >>
> >> pep8 and other parts of the git codebase recommend against
> >> lining up the equals signs like that.  Ya, sorry for the nits
> >> being that they're purely stylistic.
> >
> > I can't find a good rationale for this rule in PEP8 (other than Guido's
> > personal style), and I personally find the above much more readable
> > (otherwise I wouldn't go through the trouble of lining them all up...).
> > Can I claim exception (1) (readability)?
>
> I think you are missing the point.  It may be true that the rules in
> PEP8 were *originally* written according to the unjustified whims of the
> BDFL, but now that they are established the reason for following them is
> not that Guido likes them but rather to be consistent with the bulk of
> other Python code on the planet.

Ok. I will try to follow PEP8 as closely as possible.

> With respect to the rule to use 4-space indents, there are serious
> practical problems with using tabs *in addition to* the consistency
> argument.

There are? What arguments? Assuming I don't mix spaces and tabs (which I 
certainly don't), I can't see any "practical problems" with using tabs 
(except for the PEP8/consistency issue).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
