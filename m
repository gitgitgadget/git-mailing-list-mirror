From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 3/3] Support fetching from foreign VCSes
Date: Mon, 12 Jan 2009 00:48:28 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901120041260.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110335520.19665@iabervon.org> <7vfxjpmhow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 06:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMFgP-0002au-JW
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 06:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbZALFsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 00:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbZALFsa
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 00:48:30 -0500
Received: from iabervon.org ([66.92.72.58]:36131 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbZALFsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 00:48:30 -0500
Received: (qmail 29552 invoked by uid 1000); 12 Jan 2009 05:48:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 05:48:28 -0000
In-Reply-To: <7vfxjpmhow.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105295>

On Sun, 11 Jan 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This supports a useful subset of the usual fetch logic, mostly in the
> > config file.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> 
> I like the direction this series is going.  In the longer term, it would
> be nice if we can have git-svn and git-cvsimport replaced with something
> like this.

That was my goal, although the only foreign system I currently use is 
Perforce.

> Is the current foreign vcs interface sufficiently rich to support git as a
> foreign scm by using fast-import and fast-export?

I think so, although it would be pretty strange, since it would generally 
have a whole lot of local data (a complete clone of any remote 
repository).

	-Daniel
*This .sig left intentionally blank*
