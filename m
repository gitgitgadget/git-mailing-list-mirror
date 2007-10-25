From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 11:07:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251106110.25221@racer.site>
References: <Pine.LNX.4.64.0710212308540.25221@racer.site>  <471C9B13.9080603@op5.se>
  <Pine.LNX.4.64.0710221445170.25221@racer.site>  <471CB443.9070606@op5.se>
  <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> 
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>  <Pine.LNX.4.64.0710231155321.25221@racer.site>
  <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>  <20071024192058.GF29830@fieldses.org>
 <471F9FD1.6080002@op5.se> <8fe92b430710241648j609d4d00x121836001a69d1e6@mail.gmail.com>
 <472048EB.1000707@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkzdU-0001RM-56
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbXJYKIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbXJYKIF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:08:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:50839 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754229AbXJYKIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:08:04 -0400
Received: (qmail invoked by alias); 25 Oct 2007 10:08:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 25 Oct 2007 12:08:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9t6kL/gT9f4A06ZiKZ0dJVXJStyobEs2JJ3xOff
	bOD2AbIMtZqVcq
X-X-Sender: gene099@racer.site
In-Reply-To: <472048EB.1000707@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62291>

Hi,

On Thu, 25 Oct 2007, Andreas Ericsson wrote:

> Jakub Narebski wrote:
> > On 10/24/07, Andreas Ericsson <ae@op5.se> wrote:
> > 
> > > git pull. Not git push. git pull operates on one working branch at a 
> > > time (by default), whereas git push uploads and fast-forwards all 
> > > the common branches (by default). I want git pull to work like git 
> > > push.
> > 
> > git push is opposite (almost) to git fetch, not to git pull.
> 
> Not to an end user that has no idea or desire to learn about git remotes 
> or anything else.

At some point you _have_ to expect your users to learn something.  In the 
git documentation, we never pretend that pull is anything else than "fetch 
+ merge".

So this assumption of your end user is a lack of training, really.

Ciao,
Dscho
