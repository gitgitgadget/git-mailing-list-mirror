From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --continue and --abort options to git-rebase.
Date: Wed, 26 Apr 2006 13:05:28 -0700
Message-ID: <7v3bg0nlvb.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP0659C709B7FFCB63182FE1AEBC0@CEZ.ICE>
	<e2np4p$b9a$1@sea.gmane.org>
	<BAYC1-PASMTP025110BEB495EC4F07CDE2AEBC0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 22:05:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYqGU-0007fA-3b
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 22:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWDZUFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 16:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWDZUFa
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 16:05:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28354 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932388AbWDZUFa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 16:05:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426200529.BGBY15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 16:05:29 -0400
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP025110BEB495EC4F07CDE2AEBC0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Wed, 26 Apr 2006 10:49:38 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19217>

sean <seanlkml@sympatico.ca> writes:

>   git rebase [--onto <newbase>] <upstream> [<branch>]
>   git rebase --continue
>   git rebase --abort
>
> ---
>
> Take 2.  Must simpler patch which doesn't trying to 
> rejigger the command line too much.

This second round seems to make more sense.  Sign-off?
