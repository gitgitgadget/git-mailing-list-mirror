From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 23:44:19 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801152337140.13593@iabervon.org>
References: <478D79BD.7060006@talkingspider.com> <ee77f5c20801152006w11307ce0j17463f1c6536543f@mail.gmail.com> <478D85A9.6050807@talkingspider.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:44:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF08w-0007PP-Tg
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbYAPEoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757568AbYAPEoW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:44:22 -0500
Received: from iabervon.org ([66.92.72.58]:55827 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757146AbYAPEoV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:44:21 -0500
Received: (qmail 18827 invoked by uid 1000); 16 Jan 2008 04:44:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2008 04:44:19 -0000
In-Reply-To: <478D85A9.6050807@talkingspider.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70631>

On Tue, 15 Jan 2008, Mike wrote:

> David Symonds wrote:
> > On Jan 16, 2008 2:27 PM, Mike <fromlists@talkingspider.com> wrote:
> > > 2. If I tar/gz my code and deliver it to a client, I don't want the .git
> > > dir slipping into the tarball, allowing my client to be able to peruse
> > > the history of what we did and when.
> > 
> > Use git-archive.
> > 
> 
> Thanks but this isn't sufficient. If we have one directory of our web root in
> a git repository, say docroot/php, and we tar up docroot, it will include
> php/.git.  We don't want that.  We would have to go out of our way to avoid
> the .git directory.  The point is, we don't want anything in docroot that
> shouldn't be made live.

I don't know about you, but my source directories get lots of other 
junk: editor backup files, half-written scripts, debugging output, etc. 
Furthermore, there's the issue of whether you can accidentally distribute 
something you haven't added to your version control yet and therefore 
can't reproduce. It's just a lot cleaner to deploy and distribute out of 
the version control system instead of out of a working directory.

I don't know why you don't seem to have git-archive (or its manpage); it's 
in the version you have. Maybe it didn't get into the deb-generation files 
at the time? You might have git-tar-tree instead, though.

	-Daniel
*This .sig left intentionally blank*
