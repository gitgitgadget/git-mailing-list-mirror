From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Sat, 3 Sep 2005 02:54:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509030233350.23242@iabervon.org>
References: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0508171341380.23242@iabervon.org>
 <Pine.LNX.4.63.0508172156090.17234@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0508171630140.23242@iabervon.org>
 <Pine.LNX.4.63.0508180009180.18104@wgmdd8.biozentrum.uni-wuerzburg.de>
 <430C8C31.1070902@progeny.com> <7v4q9eak9k.fsf@assigned-by-dhcp.cox.net>
 <43174090.5070503@progeny.com> <7vek88tib4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509021358000.23242@iabervon.org> <7voe7bfhfz.fsf@assigned-by-dhcp.cox.net>
 <7v8xyebs9v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org,
	Horst von Brand <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Sep 03 08:51:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBRrv-0002Un-5d
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 08:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbVICGvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 02:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbVICGvL
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 02:51:11 -0400
Received: from iabervon.org ([66.92.72.58]:4614 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1161170AbVICGvK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Sep 2005 02:51:10 -0400
Received: (qmail 28127 invoked by uid 1000); 3 Sep 2005 02:54:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Sep 2005 02:54:58 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xyebs9v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8036>

On Fri, 2 Sep 2005, Junio C Hamano wrote:

> I said:
> 
> > 	I'll draw up a strawman tonight unless somebody else
> > 	does it first.
> 
> 1. Say 'index' when you are tempted to say 'cache'.
> 
>         git-checkout-cache      git-checkout-index
>         git-convert-cache       git-convert-index
>         git-diff-cache          git-diff-index
>         git-fsck-cache          git-fsck-index
>         git-merge-cache         git-merge-index
>         git-update-cache        git-update-index

Agreed, except that git-convert-cache and git-fsck-cache actually have 
nothing to do this the index by any name, and should probably be 
git-convert-objects and git-fsck-objects.

> 2. The act of combining two or more heads is called 'merging';
>    fetching immediately followed by merging is called 'pulling'.
> 
>         git-resolve-script      git-merge-script
> 
>    The commit walkers are called *-pull, but this is probably
>    confusing.  They are not pulling.
> 
>         git-http-pull           git-http-walk
>         git-local-pull          git-local-walk
>         git-ssh-pull            git-ssh-walk

I think "fetch" is more applicable to what they do.

> 3. Non-binaries are called '*-scripts'.
> 
>    In earlier discussions some people seem to like the
>    distinction between *-script and others; I did not
>    particularly like it, but I am throwing this in for
>    discussion.
> 
>         git-applymbox           git-applymbox-script
>         git-applypatch          git-applypatch-script
>         git-cherry              git-cherry-script
>         git-shortlog            git-shortlog-script
>         git-whatchanged         git-whatchanged-script

I don't think it matters very much whether something is a script or not; 
on the other hand, it would be good to have "git" list a reasonable set of 
commands to use through the interface, which would exclude, for example, 
git-merge-one-file-script, and include the above commands.

> 4. To be removed shortly.
> 
>         git-clone-dumb-http     should be folded into git-clone-script

Agreed.

	-Daniel
*This .sig left intentionally blank*
