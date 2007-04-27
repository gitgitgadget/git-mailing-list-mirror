From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Fri, 27 Apr 2007 12:32:11 -0700
Message-ID: <7vabwtobpg.fsf@assigned-by-dhcp.cox.net>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
	<1177693212202-git-send-email-lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Fri Apr 27 21:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhWBH-0007uS-RJ
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 21:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150AbXD0TcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 15:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757168AbXD0TcN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 15:32:13 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53052 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757150AbXD0TcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 15:32:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427193212.WPVU1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 15:32:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sKYA1W00a1kojtg0000000; Fri, 27 Apr 2007 15:32:11 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45747>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
writes:

> From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
>
> This macro may be used to iterate over revisions, so, instead of
> doing: ...

I am not a big fan of magic control-flow macros, as it makes the
code harder to grok for people new to the codebase.
