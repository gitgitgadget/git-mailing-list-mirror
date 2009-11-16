From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Nov 2009, #03; Sun, 15)
Date: Sun, 15 Nov 2009 19:30:39 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911151917100.14365@iabervon.org>
References: <7vtywwm6i4.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0911151711170.14365@iabervon.org> <fabb9a1e0911151532w1ad81a0bi8b13ca59d13cdd79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 01:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9pUj-000887-6j
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 01:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbZKPAaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 19:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZKPAaf
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 19:30:35 -0500
Received: from iabervon.org ([66.92.72.58]:39748 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361AbZKPAae (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 19:30:34 -0500
Received: (qmail 2355 invoked by uid 1000); 16 Nov 2009 00:30:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Nov 2009 00:30:39 -0000
In-Reply-To: <fabb9a1e0911151532w1ad81a0bi8b13ca59d13cdd79@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132977>

On Mon, 16 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Sun, Nov 15, 2009 at 23:26, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > My initial cleanup for "Allow helper to map private ref names into normal
> > names" was wrong (and the original was supposed to be RFC, and isn't
> > signed-off); I identified the bug he reported in it, but haven't gotten
> > positive test results from him yet, and the series obviously needs a
> > proper version rolled in before it goes into next.
> 
> Sorry, I tested, got primary positive results, then wanted to test
> something else and instead of:
> ~/code$ rm -rf test
> 
> I did:
> ~/code$ rm -rf git
> 
> I hate it when my fingers don't listen. Anyway, I ^C-ed and managed to
> save my worktree, but most of my git/.git was gone already. I'll get
> back to you tomorrow with more results since the time I was going to
> spend on running it through valgrind was wasted trying to recover my
> git repo :P.

Ouch. I remember one day when I got some old code all cleaned up for my 
initial commit, and was about to type "cvs import", but decided I should 
get rid of the editor cruft first. So I typed "rm *~", but missed one key.

	-Daniel
*This .sig left intentionally blank*
