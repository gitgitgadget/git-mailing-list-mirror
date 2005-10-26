From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Test in git-init-db if the filemode can be trusted
Date: Wed, 26 Oct 2005 00:01:58 -0700
Message-ID: <7vhdb4ahi1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510260141220.30576@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 09:03:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUfIV-0006fR-Pn
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 09:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVJZHCC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 03:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVJZHCA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 03:02:00 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11938 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932561AbVJZHCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 03:02:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026070118.EKIY2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 03:01:18 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510260141220.30576@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 26 Oct 2005 01:43:03 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10650>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... and if not, write an appropriate .git/config. Of course, that happens 
> only if no config file was yet created (by a template or a hook).
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---
>
> 	This might be a bit controversial, as we probably need a way to 
> 	write to .git/config anyway. Until there are such functions, I'll
> 	live with this patch.

Hmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm.  Yes, we discussed something
like this earlier.  It probably is a good usability patch, but
at the same time it does not feel quite right, but I cannot
explain why.  Probably because I have not suffered from FAT for
some time, lucky me, I guess.
 
