From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-quiltimport /bin/sh-ism fix
Date: Thu, 29 Mar 2007 16:06:03 -0700
Message-ID: <7vr6r71wh0.fsf@assigned-by-dhcp.cox.net>
References: <20070329213820.GY24561@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Daly <francis@daoine.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 01:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX3h3-00029T-SB
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 01:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934359AbXC2XGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 19:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934361AbXC2XGG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 19:06:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48466 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934359AbXC2XGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 19:06:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329230602.CIJS25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 19:06:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gn621W00S1kojtg0000000; Thu, 29 Mar 2007 19:06:03 -0400
In-Reply-To: <20070329213820.GY24561@craic.sysops.org> (Francis Daly's message
	of "Thu, 29 Mar 2007 22:38:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43488>

Francis Daly <francis@daoine.org> writes:

> Bryan Wu reported
> /usr/local/bin/git-quiltimport: 114: Syntax error: Missing '))'
>
> Most bourne-ish shells I have here accept
>  x=$((echo x)|cat)
> but all bourne-ish shells I have here accept
>  x=$( (echo x)|cat)
> because $(( might mean arithmetic expansion.

Well spotted, thanks.


Sheesh, this is even warned in POSIX sh manpage.
