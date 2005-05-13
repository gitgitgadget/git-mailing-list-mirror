From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Sat, 14 May 2005 01:37:39 +0200
Message-ID: <20050513233738.GL32232@pasky.ji.cz>
References: <20050513221935.GC32232@pasky.ji.cz> <Pine.LNX.4.21.0505131853020.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 14 01:40:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWjle-0000IM-Ol
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVEMXiq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 19:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVEMXiU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 19:38:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14218 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262577AbVEMXho (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 19:37:44 -0400
Received: (qmail 12102 invoked by uid 2001); 13 May 2005 23:37:39 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505131853020.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 01:14:22AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Sat, 14 May 2005, Petr Baudis wrote:
> 
> > Hmm, I've honestly expected something different - a generic way to
> > specify any file in the repository to be pulled along, instead of a
> > introducing refs awareness at this level of git. What would be the
> > advantages of that approach against just specifying list of other files
> > to pull along?
> 
> The point is to specify the commit to pull by fetching a file from the
> other side, not just to move a file. So you need to be specifying that the
> file is a hex encoding of the sha1 hash of the starting point of the pull,
> and the refs/ area is where these are expected to be. (Note that it still
> doesn't have any knowledge about the meanings of files in refs/; you tell
> it which one you want to use, and optionally which one you want to write
> to, and it will use the names you provide).
> 
> It wouldn't help much to download the head file if you had to know the
> contents of that file already in order to do everything as a single
> transfer.

So what about just something like

	git-wormhole-pull remote:refs/head/master wormhole://localhost/

That is, you could just specify remote:path_relative_to_url instead of
SHA1 id as the commit.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
