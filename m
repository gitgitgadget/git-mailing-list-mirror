From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Thu, 18 Oct 2007 00:46:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710180045160.25221@racer.site>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
 <471302D2.6010405@trolltech.com> <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
 <200710150902.52653.johan@herland.net> <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
 <ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
 <0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com> <85ve98gl57.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0710171553580.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Bosch <bosch@adacore.com>,
	David Symonds <dsymonds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Marius Storm-Olsen <marius@trolltech.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:46:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiIbE-0008AR-EV
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759350AbXJQXqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 19:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759303AbXJQXql
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:46:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:48980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759242AbXJQXql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 19:46:41 -0400
Received: (qmail invoked by alias); 17 Oct 2007 23:46:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 18 Oct 2007 01:46:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RTTsIij+RmVvMZHcljGDQ8hwDlgeNe/nLG816Pp
	ZAQa5RDtFhkBXp
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0710171553580.26902@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61443>

Hi,

On Wed, 17 Oct 2007, Linus Torvalds wrote:

> On Mon, 15 Oct 2007, David Kastrup wrote:
> 
> > Geert Bosch <bosch@adacore.com> writes:
> > 
> > > On Oct 15, 2007, at 13:53, David Symonds wrote:
> > >> That's also why I suggested "skip"; you might not be able to test a 
> > >> particular commit, but you might also not *want* to test a 
> > >> particular commit for some reason.
> > >
> > > Skip seems a great choice: it directly expresses the wish to not 
> > > consider a certain commit. The reason is unimportant.
> > 
> > But it is an _action_, while "good" and "bad" are properties.
> 
> Well, this has been debated to death, but I actually think that "skip" 
> is a good choice, exactly because it's an action.

Could we, _please_, first decide if the implementation has merits, and 
just apply it as is in that case?  We can rename it whatever anybody likes 
later, and we can paint the bikeshed brown if you want to.

Ciao,
Dscho
