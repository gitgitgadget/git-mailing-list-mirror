From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Thu, 08 Dec 2005 13:24:24 -0800
Message-ID: <7v7jafcmev.fsf@assigned-by-dhcp.cox.net>
References: <20051208202555.GA3046@steel.home>
	<7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
	<20051208210251.GB19423@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 22:26:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkTFr-0000Ji-KJ
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 22:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVLHVY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVLHVY1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 16:24:27 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:11653 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932473AbVLHVY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 16:24:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208212307.PFQW17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 16:23:07 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051208210251.GB19423@steel.home> (Alex Riesen's message of
	"Thu, 8 Dec 2005 22:02:51 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13377>

Alex Riesen <raa.lkml@gmail.com> writes:

> You do miss something. glibc will happily continue lookup if
> git-init-db in the top of the build directory is not executable, and
> it will take the next one it finds (and people _will_ have git-init-db
> in PATH).

And the reason git-init-db we just built is not executable
is...?
