From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 13:19:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703141314140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com>
 <7vodmwfg2c.fsf@assigned-by-dhcp.cox.net> <20070314074440.GC12710@thunk.org>
 <200703141045.58739.andyparkins@gmail.com> <7vps7caxjb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	James Bowes <jbowes@dangerouslyinc.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRSS0-0007bw-B1
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 13:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbXCNMTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 08:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbXCNMTZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 08:19:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:52295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161198AbXCNMTY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 08:19:24 -0400
Received: (qmail invoked by alias); 14 Mar 2007 12:19:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 14 Mar 2007 13:19:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+B9mYF5niBGu55+F1JqOGTbv6rDkR2Kk8D6rqP7r
	mdVf6N1dq4IbmJ
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vps7caxjb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42203>

Hi,

On Wed, 14 Mar 2007, Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > On Wednesday 2007 March 14 07:44, Theodore Tso wrote:
> >
> >> I agree with Junio; I think the scripts are much more readable and
> >> easier to understand; In fact, it would be nice if the script were
> >> preserved somewhere, perhaps as comments in the .c file.
> >
> > If only there were some tool that would keep collections of files as a 
> > snapshotted whole and allow us to browse the history of those snapshots in 
> > some sort of connected graph, with each snapshot being given some sort of 
> > unique ID.  Then we could simply refer to that unique ID when we wanted to 
> > tell someone about a particular historical instance.
> >
> > :-)
> 
> There is a difference between having a readily greppable and
> lessable copy handy to study at your own initiative, and being
> able to retrieve to review only after being told.
> 
> You could argue that we can all do that with git-grep and
> git-less ;-).

Not to forget git-checkout.

But I like the idea of contrib/examples/. Why not put more stuff there, 
instead of clinging onto scripts for core-git? The purpose of 
contrib/examples/ is to provide easy samples, and the purpose of core-git 
is _not_ to provide easy examples, but a consistent and portable set of 
programs.

Als, when reading Git's scripts, I often think

- wow, what a different style from my one, and
- would locking not be a nice thing?

But I guess that now that the King Penguin spoke, I no longer have to 
argue for more builtins, even if they are trivial. (Who knows, maybe we 
can ship _one_ program, which is then hard linked to git-*, soon?)

Ciao,
Dscho
