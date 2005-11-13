From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Building git on NetBSD
Date: Sat, 12 Nov 2005 18:41:34 -0800
Message-ID: <7vhdahclr5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511120649430.2695@x2.ybpnyarg>
	<43760AF5.1010704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 03:42:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb7oL-0000GI-6d
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 03:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVKMCli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 21:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVKMCli
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 21:41:38 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50872 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750990AbVKMCli (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 21:41:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051113024040.LCWI776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Nov 2005 21:40:40 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43760AF5.1010704@op5.se> (Andreas Ericsson's message of "Sat, 12
	Nov 2005 16:32:05 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11725>

Andreas Ericsson <ae@op5.se> writes:

> Yes it should. Currently the git makefile doesn't distinguish between 
> CFLAGS and LDFLAGS which results in a fair few warnings.

Very well.  Maybe LDFLAGS and ALL_LDFLAGS pair to parallel
CFLAGS and ALL_CFLAGS (the former is for the end user to
override from make command line, the latter is for Makefile to
augment and use)?
