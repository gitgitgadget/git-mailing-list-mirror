From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Mon, 25 Jan 2010 17:26:07 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001251708530.14365@iabervon.org>
References: <alpine.LNX.2.00.1001251628431.14365@iabervon.org> <fabb9a1e1001251353q3739a5efq38606ca0b63ce10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZXO1-0005hF-3S
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 23:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab0AYW0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 17:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845Ab0AYW0N
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 17:26:13 -0500
Received: from iabervon.org ([66.92.72.58]:47332 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab0AYW0L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 17:26:11 -0500
Received: (qmail 11562 invoked by uid 1000); 25 Jan 2010 22:26:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2010 22:26:07 -0000
In-Reply-To: <fabb9a1e1001251353q3739a5efq38606ca0b63ce10@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138000>

On Mon, 25 Jan 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Mon, Jan 25, 2010 at 22:35, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > The push support is also currently based on a transport helper
> > export design that isn't upstream and I don't like any more; a better
> > design is probably to have the core send an "export" command and then a
> > gfi stream, but I haven't worked on this.
> 
> Ah, that was actually what I _thought_ the export command did, and how
> I was/am going to implement it for git-remote-hg.

That's the right thing to do. However, you might notice that there's no 
code around to actually do it (or anything else, presently).

> Do you think you'll have time to work on that anytime soon? My git 
> budget should go up enough to do some serious work after this weekend, 
> so if you have time we could work on moulding the 'export' feature into 
> something more generically useful. If not, I'll do the work anyway, and 
> hope you'll have time to review it at some point :).

I've been working primarily on non-git-related stuff lately, and that's 
been keeping me pretty busy. I can definitely review and discuss design 
issues, but I'm not sure I'll manage writing anything any time soon.

	-Daniel
*This .sig left intentionally blank*
