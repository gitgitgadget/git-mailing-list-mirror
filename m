From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Fri, 02 Sep 2005 23:05:16 -0700
Message-ID: <7v8xyebs9v.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org,
	Horst von Brand <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Sep 03 08:06:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBR9t-0005rC-JQ
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 08:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbVICGFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 02:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161157AbVICGFW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 02:05:22 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38110 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161153AbVICGFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 02:05:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903060518.SIDX20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Sep 2005 02:05:18 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7voe7bfhfz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Sep 2005 11:33:20 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8034>

I said:

> 	I'll draw up a strawman tonight unless somebody else
> 	does it first.

1. Say 'index' when you are tempted to say 'cache'.

        git-checkout-cache      git-checkout-index
        git-convert-cache       git-convert-index
        git-diff-cache          git-diff-index
        git-fsck-cache          git-fsck-index
        git-merge-cache         git-merge-index
        git-update-cache        git-update-index

2. The act of combining two or more heads is called 'merging';
   fetching immediately followed by merging is called 'pulling'.

        git-resolve-script      git-merge-script

   The commit walkers are called *-pull, but this is probably
   confusing.  They are not pulling.

        git-http-pull           git-http-walk
        git-local-pull          git-local-walk
        git-ssh-pull            git-ssh-walk

3. Non-binaries are called '*-scripts'.

   In earlier discussions some people seem to like the
   distinction between *-script and others; I did not
   particularly like it, but I am throwing this in for
   discussion.

        git-applymbox           git-applymbox-script
        git-applypatch          git-applypatch-script
        git-cherry              git-cherry-script
        git-shortlog            git-shortlog-script
        git-whatchanged         git-whatchanged-script

4. To be removed shortly.

        git-clone-dumb-http     should be folded into git-clone-script
