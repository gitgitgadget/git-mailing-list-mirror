From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] prepend diffstat in front of the patch
Date: Sat, 15 Apr 2006 05:12:27 -0700
Message-ID: <7vfykfghqs.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550604150207h6fdb0042x3a9bbfa63269a8c8@mail.gmail.com>
	<Pine.LNX.4.63.0604151346270.25269@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 14:12:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUjdl-0007sC-T8
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 14:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWDOMM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 08:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWDOMM3
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 08:12:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:33779 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932489AbWDOMM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 08:12:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415121228.UIKB24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 08:12:28 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604151346270.25269@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 15 Apr 2006 13:48:49 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18744>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Anyway, as you probably saw already, I sent out a patch which does that. I 
> wanted to wait a little to introduce it, because I had the feeling that 
> the option parsing would be volatile for a few days.

Thanks for the consideration, but that's what topic branches are
for ;-).

Seriously, even the unified one (either Linus's or mine) handed
diff option parsing to an established function that is identical
to the "master" version, so the --patch-with-stat is probably a
no-impact merge.

		JC "What's Easter" Hamano ;-)
