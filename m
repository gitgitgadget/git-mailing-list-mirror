From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: newbie with broken workflow
Date: Fri, 4 Apr 2008 12:30:46 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804041228250.19665@iabervon.org>
References: <9d27c6320804031445p3fc80115n59218673dd587795@mail.gmail.com>  <alpine.LNX.1.00.0804031957010.19665@iabervon.org> <9d27c6320804040708l6eace184q9677ca75729b4eef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Kingston <james.kingston@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 18:31:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhopB-0003VD-6A
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 18:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbYDDQas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 12:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbYDDQas
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 12:30:48 -0400
Received: from iabervon.org ([66.92.72.58]:34006 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872AbYDDQar (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 12:30:47 -0400
Received: (qmail 20744 invoked by uid 1000); 4 Apr 2008 16:30:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Apr 2008 16:30:46 -0000
In-Reply-To: <9d27c6320804040708l6eace184q9677ca75729b4eef@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78808>

On Fri, 4 Apr 2008, James Kingston wrote:

> On Thu, Apr 3, 2008 at 7:05 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >  /c/wd/cc> cd /c/cc
> >  /c/cc> git pull ../wd/cc
> >
> >  But wouldn't that fail, because the files are read-only?
> 
> Actually, I just tried and it worked beautifully.  The directory is
> writable, so git replaces rather than modifies the files.  Then I can
> use CCRC to search for hijacked files, check them out in one swoop
> with the option to keep my modifications, then check them all in as a
> group.

Ah, yes, I guess that would work. Although I suspect that it would be 
annoying to recover if you failed to get the locks for any of them, since 
you're missing CC's expected path for conflict resolution.

	-Daniel
*This .sig left intentionally blank*
