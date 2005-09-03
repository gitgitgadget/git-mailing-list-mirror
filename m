From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Sat, 03 Sep 2005 01:29:40 -0700
Message-ID: <7vy86e5zbf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0508171341380.23242@iabervon.org>
	<Pine.LNX.4.63.0508172156090.17234@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0508171630140.23242@iabervon.org>
	<Pine.LNX.4.63.0508180009180.18104@wgmdd8.biozentrum.uni-wuerzburg.de>
	<430C8C31.1070902@progeny.com>
	<7v4q9eak9k.fsf@assigned-by-dhcp.cox.net>
	<43174090.5070503@progeny.com>
	<7vek88tib4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509021358000.23242@iabervon.org>
	<7voe7bfhfz.fsf@assigned-by-dhcp.cox.net>
	<7v8xyebs9v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509030233350.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org,
	Horst von Brand <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Sep 03 10:30:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBTPF-0006uw-7u
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 10:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbVICI3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 04:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbVICI3m
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 04:29:42 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:9968 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161191AbVICI3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 04:29:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903082940.CAHD11315.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Sep 2005 04:29:40 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509030233350.23242@iabervon.org> (Daniel
	Barkalow's message of "Sat, 3 Sep 2005 02:54:58 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8040>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Agreed, except that git-convert-cache and git-fsck-cache actually have 
> nothing to do this the index by any name, and should probably be 
> git-convert-objects and git-fsck-objects.

You are right.

> I think "fetch" is more applicable to what they do.

OK.  then they are git-http-fetch and friends.  How about
git-ssh-push?  The counterpart of fetch-pack/clone-pack is
called upload-pack, so would git-ssh-upload make things more
consistent?  I dunno.

> I don't think it matters very much whether something is a script or not; 
> on the other hand, it would be good to have "git" list a reasonable set of 
> commands to use through the interface, which would exclude, for example, 
> git-merge-one-file-script, and include the above commands.

Are you suggesting to drop -script from git-merge-one-file?
Then git-cherry should perhaps keep its current name.
