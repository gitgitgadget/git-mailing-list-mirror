From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Tue, 19 May 2009 13:53:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <200905190923.33874.johan@herland.net> <alpine.DEB.1.00.0905191015560.26154@pacific.mpi-cbg.de> <200905191045.39108.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 19 13:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Nt5-0000lP-TC
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 13:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbZESLxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 07:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbZESLxa
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 07:53:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:35845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750971AbZESLxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 07:53:30 -0400
Received: (qmail invoked by alias); 19 May 2009 11:53:30 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 19 May 2009 13:53:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UUYBdYUTUtU5NARcHFUcoWww5IjIAzV8g288aLt
	OQZTw/dXkEHJU6
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200905191045.39108.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119521>

Hi,

On Tue, 19 May 2009, Johan Herland wrote:

> On Tuesday 19 May 2009, Johannes Schindelin wrote:
> > On Tue, 19 May 2009, Johan Herland wrote:
> > > On Tuesday 19 May 2009, Junio C Hamano wrote:
> > > > Johan Herland <johan@herland.net> writes:
> > > > > After some thinking, I don't like my original name 
> > > > > submodule.<name>.resolve, since ".resolve" sounds more like a 
> > > > > merge strategy or conflict resolution method, than a "how to 
> > > > > deal with submodule update" choice. I propose 
> > > > > submodule.<name>.update instead.
> > > >
> > > > Sounds like a plan, even though I do not necessarily agree with 
> > > > the idea of automatically rebinding what is at the submodule path 
> > > > every time you update the toplevel project tree.
> > >
> > > I agree that in many workflows this does not make sense, but I 
> > > believe that (as with 'git submodule update --rebase') there are 
> > > some cases where it does make sense, and I see no reason to support 
> > > one, but not the other.
> >
> > We have a _lot_ of obscure things that are not supported by core Git, 
> > but are _very_ easy to add as _tiny_ add-on scripts by the user, 
> > without the need for "official" feature support.
> >
> > Just like this one
> 
> Does that mean you're also opposed to 'git submodule update --rebase' 
> (which is already in 'next', and is even Signed-off-by yourself)?

No, because -- as I said myself already a couple of times -- I can see 
this supporting a common workflow.

> I still don't see any reason why one should be added (--rebase), and not 
> the other (--merge).

When you rebase, you see your personal stuff (i.e. stuff that you do not 
want to submit, or not in its current form, or that you submitted and it 
waits for inclusion) on top of things right away.

In contrast, if you merge, you will have a different state from the 
upstream _forever_.  Even if your stuff gets included.

Needless to say, I do not see much use for the latter case, but tons for 
the former.

> Dropping both would at least be consistent from core Git's POV, but 
> following that thread, we should probably also drop "git pull" (which is 
> just a simple wrapper around "git fetch" and "git merge"), and maybe 
> also "git clone" (which can easily be scripted, using "git init", "git 
> remote", "git fetch" and "git branch")...

I will not bother to comment on this.

Ciao,
Dscho
