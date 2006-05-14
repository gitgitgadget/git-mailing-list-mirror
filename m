From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Ensure author information is set before asking for commit message.
Date: Sat, 13 May 2006 19:41:27 -0700
Message-ID: <7vlkt5s4yw.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP10DC791E7560155D9E71F4AEA20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 04:41:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff6Y5-0001JB-IK
	for gcvg-git@gmane.org; Sun, 14 May 2006 04:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWENCl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 22:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWENCl3
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 22:41:29 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:59348 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750736AbWENCl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 22:41:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514024128.LKCS9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 May 2006 22:41:28 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP10DC791E7560155D9E71F4AEA20@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sat, 13 May 2006 21:51:15 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19955>

Sean <seanlkml@sympatico.ca> writes:

> It's better to find out you need to set your author information
> properly before you enter a long commit message.
>
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

Makes sense but I suspect you would want COMMITTER not AUTHOR.
Imagine you pulled from somewhere else and it conflicted,
requiring you to hand resolve and then run git-commit.
