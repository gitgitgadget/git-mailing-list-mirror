From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 15:22:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281521140.5399@eeepc-johanness>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com>
 <ee77f5c20804280612o3db1fb86nf089e2201f688d2f@mail.gmail.com> <F205FBFD-99B1-45F5-9596-3FE8384A9268@silverinsanity.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-79859607-1209392573=:5399"
Cc: David Symonds <dsymonds@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	=?ISO-8859-15?Q?=22J=F6rg_Sommer=22?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:24:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqUGw-00017G-3W
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 16:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933582AbYD1OWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 10:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763242AbYD1OWo
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 10:22:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:50780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933551AbYD1OWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 10:22:43 -0400
Received: (qmail invoked by alias); 28 Apr 2008 14:22:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp017) with SMTP; 28 Apr 2008 16:22:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0yBAsBOK0bLv6cw3Uzkvd7EBQIOryZtpUlxJCUg
	6Wh530eHN5vR/Y
X-X-Sender: user@eeepc-johanness
In-Reply-To: <F205FBFD-99B1-45F5-9596-3FE8384A9268@silverinsanity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80538>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-79859607-1209392573=:5399
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Apr 2008, Brian Gernhardt wrote:

> On Apr 28, 2008, at 9:12 AM, David Symonds wrote:
> 
> >I doubt Jörg suggested it for its speed, but it removes the dependency 
> >on Perl.
> 
> We already depend on perl for git-add--interactive.perl in core git, and 
> for git-svn, git-cvs*, and git-send-email.  I don't think this one line 
> is going to make a big difference in our Perl dependency.

It does.  It goes the wrong way.  And work on building in 
git-add--interactive.perl has already begun, so that is not a strong 
argument.

As for git-svn and git-cvs* I agree, they will probably remain perl 
scripts.  But I think that they are not that important, since they are not 
strictly _core_ parts of Git, being importers/exporters that not everybody 
needs.

Ciao,
Dscho

--658432-79859607-1209392573=:5399--
