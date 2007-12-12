From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin command.
Date: Wed, 12 Dec 2007 18:24:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121823090.27959@racer.site>
References: <20071211195712.GA3865@bitplanet.net>  <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
  <1197416286.7552.4.camel@hinata.boston.redhat.com> 
 <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>  <Pine.LNX.4.64.0712121103510.27959@racer.site>
 <1197471866.9269.2.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:25:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2WGX-0001Xd-6q
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbXLLSYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbXLLSYW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:24:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:33688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752543AbXLLSYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:24:21 -0500
Received: (qmail invoked by alias); 12 Dec 2007 18:24:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 12 Dec 2007 19:24:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19n6ulRjulnbim5aS7uhTxA/uBKdMl0XYTt0Nmm23
	0L6EQ20cBy7eO0
X-X-Sender: gene099@racer.site
In-Reply-To: <1197471866.9269.2.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68080>

Hi,

On Wed, 12 Dec 2007, Kristian H?gsberg wrote:

> On Wed, 2007-12-12 at 11:12 +0000, Johannes Schindelin wrote:
> 
> > On Tue, 11 Dec 2007, Junio C Hamano wrote:
> ...
> > >  * --shared optimization
> > > 
> > >    This is a very easy addition to "git remote add".  You make sure 
> > >    that the added remote repository is on a local machine, and set 
> > >    up alternates to point at its object store.
> > 
> > Concur.
> > 
> > Since I want to lose that dependency on cpio on Windows (which we fake 
> > by using tar), I'll implement this in C anyway.
> 
> It's not used for --shared (which is just writing an alternates file), 
> it's used for -l, hardlinking locally cloned repos.  The code to replace 
> cpio is already in the patch I sent, look for clone_local().

Sorry, that comment should have gone after another part of the original 
message.

My only two excuses are that I am ill, and am overloaded with work.

Ciao,
Dscho
