From: "Philippe Bruhat (BooK)" <philippe.bruhat@free.fr>
Subject: Re: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Thu, 17 Jun 2010 18:42:13 +0200
Message-ID: <20100617164212.GG20658@swoosh>
References: <7viq5ict4p.fsf@alter.siamese.dyndns.org>
 <7vocf939vu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Brian Downing <bdowning@lavos.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Ian Ward Comfort <icomfort@stanford.edu>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Philippe Bruhat <book@cpan.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simo Melenius <simo.melenius@i
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 18:42:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPIAe-0008MB-9L
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 18:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760264Ab0FQQmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 12:42:21 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:40166 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab0FQQmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 12:42:19 -0400
Received: from localhost ([127.0.0.1] helo=swoosh)
	by ks354402.kimsufi.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1OPIAP-00048F-88; Thu, 17 Jun 2010 18:42:13 +0200
Received: from book by swoosh with local (Exim 4.71)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1OPIAP-0005VP-1c; Thu, 17 Jun 2010 18:42:13 +0200
Content-Disposition: inline
In-Reply-To: <7vocf939vu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149320>

On Thu, Jun 17, 2010 at 09:24:21AM -0700, Junio C Hamano wrote:
> 
> > * ab/tap (2010-06-09) 4 commits
> >  - We use TAP so the Perl test can run without scaffolding
> >  - Skip tests in a way that makes sense under TAP
> >  - Merge branch 'jc/t9129-any-utf8' into ab/tap
> >  - Make test-lib.sh emit valid TAP format
> >  (this branch uses jc/t9129-any-utf8.)
> 
> I was not sure why TAP is worth the trouble, and I still am not sure.

Assuming I was on the list because I'm a Perl person, I'd say
that the benefit of TAP is that there are plenty of tools that
can parse it to provide nice reports.

> > * pb/maint-perl-errmsg-no-dir (2010-06-14) 1 commit
> 
> There was a comment on what the proposed commmit log message said
> regarding $!; perhaps an update is in order?

Oh, that was for this, actually.

Ok, I'll send a new patch with the discussed change.

-- 
 Philippe Bruhat (BooK)

 Mankind is the story of the same mistakes in different places.
                                                 (Moral from Groo #1 (Image))
