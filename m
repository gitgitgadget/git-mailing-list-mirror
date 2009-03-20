From: Petr Baudis <pasky@suse.cz>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
	shortcut to the tracked branch
Date: Fri, 20 Mar 2009 12:12:38 +0100
Message-ID: <20090320111238.GZ8940@machine.or.cz>
References: <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320060545.GB27008@coredump.intra.peff.net> <7vprgc4r6h.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 12:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkcg2-0007ay-MO
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 12:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbZCTLMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 07:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbZCTLMo
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 07:12:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50773 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbZCTLMn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 07:12:43 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 43C35204C0C6; Fri, 20 Mar 2009 12:12:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113940>

Hi!

On Fri, Mar 20, 2009 at 10:30:29AM +0100, Johannes Schindelin wrote:
> On Thu, 19 Mar 2009, Junio C Hamano wrote:
> 
> > I think you are right.  It is just "git branch" and perhaps "git
> > update-ref" are too loose in enforcing what can be created.
> 
> "git branch" I agree with, but not "git update-ref".  As plumbing, the 
> latter should be much more allowing, feeding rope aplenty (but also 
> allowing cool tricks we do not think about yet).

We shouldn't allow creating insane ref names even with update-ref. That
way porcelains cannot rely on update-ref to sanity check the user's
crap. At most, maybe you might want to bypass this check with some force
switch, though I really can't quite imagine why.

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
