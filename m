From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Tue, 19 May 2009 10:17:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905191015560.26154@pacific.mpi-cbg.de>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <200905182355.21645.johan@herland.net> <7vpre5anaz.fsf@alter.siamese.dyndns.org> <200905190923.33874.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 19 10:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6KVk-0006kd-Ey
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 10:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbZESIRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 04:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbZESIRL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 04:17:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:39118 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750831AbZESIRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 04:17:10 -0400
Received: (qmail invoked by alias); 19 May 2009 08:17:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 19 May 2009 10:17:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QXn4xHTuQzn0pE2+aH9etxxfiN512KqlrJLVO46
	bIvNKCtgSMFz+d
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200905190923.33874.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119504>

Hi,

On Tue, 19 May 2009, Johan Herland wrote:

> On Tuesday 19 May 2009, Junio C Hamano wrote:
> > Johan Herland <johan@herland.net> writes:
> > > After some thinking, I don't like my original name 
> > > submodule.<name>.resolve, since ".resolve" sounds more like a merge 
> > > strategy or conflict resolution method, than a "how to deal with 
> > > submodule update" choice. I propose submodule.<name>.update instead.
> >
> > Sounds like a plan, even though I do not necessarily agree with the 
> > idea of automatically rebinding what is at the submodule path every 
> > time you update the toplevel project tree.
> 
> I agree that in many workflows this does not make sense, but I believe 
> that (as with 'git submodule update --rebase') there are some cases 
> where it does make sense, and I see no reason to support one, but not 
> the other.

We have a _lot_ of obscure things that are not supported by core Git, but 
are _very_ easy to add as _tiny_ add-on scripts by the user, without the 
need for "official" feature support.

Just like this one,
Dscho
