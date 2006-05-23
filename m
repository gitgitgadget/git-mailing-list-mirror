From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change GIT-VERSION-GEN to call git commands with "git" not "git-".
Date: Mon, 22 May 2006 18:20:37 -0700
Message-ID: <7vpsi58rkq.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP09B22AA86724B4F2C01F7FAE9A0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 23 03:20:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiLZh-00019Z-9i
	for gcvg-git@gmane.org; Tue, 23 May 2006 03:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWEWBUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWEWBUi
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 21:20:38 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:10896 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750793AbWEWBUi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 21:20:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523012038.ZJID18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 21:20:38 -0400
To: git@vger.kernel.org
In-Reply-To: <BAYC1-PASMTP09B22AA86724B4F2C01F7FAE9A0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Mon, 22 May 2006 00:39:52 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20560>

Sean <seanlkml@sympatico.ca> writes:

> GIT-VERSION-GEN can incorrectly return a default version of
> "v1.3.GIT" because it tries to execute git commands using the
> "git-cmd" format that expects all git commands to be in the $PATH.
> Convert these to  "git cmd" format so that a proper answer is
> returned even when the git commands have been moved out of the
> $PATH and into a $gitexecdir.

IIRC, the reason we spelled it as "git-describe"
with a dash is ancient git wrapper said "not a git command" when
given "describe" which it did not understand without failing.

I think it has been long enough since we introduced "git describe",
so this would be OK. 
