From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Wed, 25 Jun 2008 13:33:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806251332190.9925@racer>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <1214389498.6634.10.camel@localhost>
 <20080625104605.GA10322@atn.sw.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Kestenholz <mk@spinlock.ch>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"jeske@google.com" <jeske@google.com>
To: Anton Gladkov <agladkov@parallels.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 14:37:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBUF7-0003Cd-1A
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 14:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbYFYMf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 08:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755567AbYFYMfz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 08:35:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:34931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755318AbYFYMfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 08:35:55 -0400
Received: (qmail invoked by alias); 25 Jun 2008 12:35:50 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp023) with SMTP; 25 Jun 2008 14:35:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UUEwGPTxUGHPshZ2aJTEesd/526z+EwMOpil+C5
	/KPHoAqdsNClOY
X-X-Sender: gene099@racer
In-Reply-To: <20080625104605.GA10322@atn.sw.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86272>

Hi,

On Wed, 25 Jun 2008, Anton Gladkov wrote:

> On Wed, Jun 25, 2008 at 02:24:58PM +0400, Matthias Kestenholz wrote:
> > On Wed, 2008-06-25 at 11:16 +0100, Johannes Schindelin wrote:
> > > Incidentally, a friend just told me that "checkout" is everything but
> > > intuitive, and he would have preferred "git branch switch <branch>", but
> > > then settled for my proposed "git branch --switch <branch>", which I did
> > > not have time to implement yet, unfortunately.
> > 
> > But why? I don't want to 'branch', I want to 'checkout' another branch,
> > which incidentally matches the git command I need to use to achieve
> > that.
> 
> Because 'checkout' in other SCMs like CVS or SVN means 'get latest data 
> from repo', i.e. it acts like 'pull' or 'fetch' in git. And 'branch' 
> means branch manipulation: creating, deleting, switching...

Actually, I don't find this a good reason at all.  The fact that other 
SCMs bastardized a term to mean something it clearly does not mean, is 
irrelevant here.

The thing is: if we say "let's switch branches", what command would spring 
to mind to a (non-CVS-braindamaged) user?  Exactly: "git branch".  That is 
the command that should do something with branches.

Ciao,
Dscho
