From: Junio C Hamano <junkio@cox.net>
Subject: Re: Next problem: empty ident  <joern@limerick.(none)> not allowed
Date: Tue, 18 Apr 2006 13:37:19 -0700
Message-ID: <7vu08qei2o.fsf@assigned-by-dhcp.cox.net>
References: <20060418202525.GD25688@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 22:37:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVwx0-00022u-L3
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 22:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWDRUhY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWDRUhX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 16:37:23 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9869 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932315AbWDRUhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 16:37:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418203721.DDNP8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 16:37:21 -0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20060418202525.GD25688@wohnheim.fh-wedel.de>
 (=?iso-8859-1?Q?J=F6rn?= Engel's
	message of "Tue, 18 Apr 2006 22:25:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18877>

J=F6rn Engel <joern@wohnheim.fh-wedel.de> writes:

> And now I have some questions:
> 1. Why didn't the environment variables work?
> 2. Why is there a check for commit information when I pull from some
> tree?

Because "pull" means "fetch and merge the local modifications if
any".  When you merge (and you _did_ merge), you create a new
commit of your own, and the commit records who committed it.

You need GIT_COMMITTER_EMAIL.

Now, the normal "git log" does not verbosely show committer and
author,
