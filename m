From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 06/19] Factor ref updating out of fetch_with_import
Date: Mon, 2 Nov 2009 11:36:56 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911021124040.14365@iabervon.org>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>  <1256839287-19016-7-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300221290.14365@iabervon.org>  <fabb9a1e0910300557x42d3612pf7e83907e91efdc9@mail.gmail.com> 
 <alpine.LNX.2.00.0910301118070.14365@iabervon.org> <fabb9a1e0911011733o7d8d95eem57e02d455e0bd86@mail.gmail.com>  <alpine.LNX.2.00.0911012038120.14365@iabervon.org> <fabb9a1e0911020712q4920e009w5a6d435be205b68e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 17:37:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4ztw-0001H7-21
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 17:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403AbZKBQgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 11:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbZKBQgw
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 11:36:52 -0500
Received: from iabervon.org ([66.92.72.58]:32813 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273AbZKBQgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 11:36:52 -0500
Received: (qmail 31069 invoked by uid 1000); 2 Nov 2009 16:36:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Nov 2009 16:36:56 -0000
In-Reply-To: <fabb9a1e0911020712q4920e009w5a6d435be205b68e@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131923>

On Mon, 2 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Mon, Nov 2, 2009 at 04:16, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > Why not have the regular list report:
> >
> > @refs/heads/trunkr HEAD
> >
> > or whatever it is, again like native git? That is, SVN would have an
> > interaction like:
> 
> That's fine with me, but earlier you said you didn't like the whole
> symlinking idea.

Now that you're not using them for other stuff, they're free to use for 
their normal purpose without confusion. The normal layout for a remote git 
repository's refs has HEAD as a symlink to something in refs/heads/*, so 
it's

> You said in another thread you'll be working on some patches, does
> that include this 'refs' command? I want to avoid duplicate work if
> possible :).

No, I'm just working on getting the handler to work in a context where 
there's no local repository, if possible. This will probably generate a 
bunch of easy conflicts, but not actually overlap with what you're doing 
here.

	-Daniel
*This .sig left intentionally blank*
