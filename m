From: Junio C Hamano <junkio@cox.net>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Wed, 23 Nov 2005 15:21:36 -0800
Message-ID: <7viruj3q7z.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 00:21:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef3vs-0003z8-KN
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 00:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVKWXVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 18:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVKWXVj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 18:21:39 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27107 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932599AbVKWXVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 18:21:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123232103.WQIA20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 18:21:03 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12658>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> So... "git-config-set" is used for both getting and setting? Why not just
>> "git-config --set" and "git-config --get" to make things a bit less confusing?
>
> I tried to do this more like a proof of a concept (Yeah, famous last 
> words...) and tried to be not so intrusive. There is already a config.c, 
> and to keep with the naming, this would have to move to config-lib.c to 
> make space for config.c which really is the source for git-config$(X).
>
> Should we rename config.c to config-lib.c, and config-set.c to config.c? 
> Personally, I think it too intrusive, but what the heck.

I do not think that change is intrusive.  We've renamed source
files number of times ;-).

I somehow get a very funny feeling to see "git-XXXX --get"
command that reports different things in different repositories
(for obvious reasons) called git-config, and not
git-repository-config.  But it probably is just me.

Anyway, the whole "remote specification in config file" is not a
very high priority for me right now.
