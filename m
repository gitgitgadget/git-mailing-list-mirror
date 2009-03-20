From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
 shortcut to the tracked branch
Date: Fri, 20 Mar 2009 15:34:43 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903201515490.19665@iabervon.org>
References: <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320060545.GB27008@coredump.intra.peff.net> <7vprgc4r6h.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de>
 <20090320111238.GZ8940@machine.or.cz> <7vbprwi1ju.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkkW5-0005SH-9d
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 20:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759903AbZCTTer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759429AbZCTTer
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 15:34:47 -0400
Received: from iabervon.org ([66.92.72.58]:32814 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759128AbZCTTeq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 15:34:46 -0400
Received: (qmail 31385 invoked by uid 1000); 20 Mar 2009 19:34:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2009 19:34:43 -0000
In-Reply-To: <7vbprwi1ju.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113993>

On Fri, 20 Mar 2009, Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
> >> "git branch" I agree with, but not "git update-ref".  As plumbing, the 
> >> latter should be much more allowing, feeding rope aplenty (but also 
> >> allowing cool tricks we do not think about yet).
> >
> > We shouldn't allow creating insane ref names even with update-ref. That
> > way porcelains cannot rely on update-ref to sanity check the user's
> > crap. At most, maybe you might want to bypass this check with some force
> > switch, though I really can't quite imagine why.
> 
> That's all nice and clean in theory, but it was more or less the same
> reasoning as what was behind the tightening not to allow anything but
> refs/heads pointed by HEAD, but you know what fell out of it.  "Insane"
> and "crap" are in the eye of the beholder.

I think there's no possible use to being able to use update-ref to create 
a ref that rev-parse can't be made to read. I think people will want to do 
all sorts of things that are insane (I'd personally like some refs with 
the basename "..."), but they're only likely to do insane things that 
happen to work, rather than insane things that aren't prevented but still 
don't work.

	-Daniel
*This .sig left intentionally blank*
