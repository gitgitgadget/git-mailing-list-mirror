From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-clone failing to get cogito latest tree.
Date: Fri, 5 Aug 2005 02:15:56 +0200
Message-ID: <20050805001556.GN24479@pasky.ji.cz>
References: <46a038f905073119492e521bde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 05 02:17:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0psj-0007qP-6h
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVHEAQB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 20:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVHEAQB
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 20:16:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51214 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262791AbVHEAP5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 20:15:57 -0400
Received: (qmail 19502 invoked by uid 2001); 5 Aug 2005 00:15:56 -0000
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f905073119492e521bde@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Aug 01, 2005 at 04:49:37AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> On a new machine, trying to boostrap into latest cogito, I download
> and make cogito 0.12.1, and then...
> 
> $ cg-clone http://www.kernel.org/pub/scm/cogito/cogito.git cogito
> defaulting to local storage area
> 14:48:53 URL:http://www.kernel.org/pub/scm/cogito/cogito.git/refs/heads/master
> [41/41] -> "refs/heads/origin" [1]
> progress: 34 objects, 45126 bytes
> error: File d2072194059c65f92487c84c53b9f6b5da780d14
> (http://www.kernel.org/pub/scm/cogito/cogito.git/objects/d2/072194059c65f92487c84c53b9f6b5da780d14)
> corrupt
> 
> Cannot obtain needed blob d2072194059c65f92487c84c53b9f6b5da780d14
> while processing commit 0000000000000000000000000000000000000000.
> cg-pull: objects pull failed
> cg-init: pull failed
> 
> any hints? I have a similar problem fetching git with cg-clone: 

That was caused by inadvertent packs appearance in the Cogito
repository. Should be fixed now, sorry about any trouble.

> $ cg-clone http://www.kernel.org/pub/scm/git/git.git git
> defaulting to local storage area
> 14:53:44 URL:http://www.kernel.org/pub/scm/git/git.git/refs/heads/master
> [41/41] -> "refs/heads/origin" [1]
> progress: 2 objects, 4666 bytes
> error: File 6ff87c4664981e4397625791c8ea3bbb5f2279a3
> (http://www.kernel.org/pub/scm/git/git.git/objects/6f/f87c4664981e4397625791c8ea3bbb5f2279a3)
> corrupt
> 
> Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
> while processing commit 0000000000000000000000000000000000000000.
> cg-pull: objects pull failed
> cg-init: pull failed
> 
> Probably doing somethginf hopelessly wrong...

Newer Git version should cure that. If you want to get it by Git,
though, you might want to defer to rsync transport for a moment.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
