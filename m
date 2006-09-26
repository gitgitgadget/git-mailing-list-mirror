From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clarified documentation of --exclude-per-directory.
Date: Mon, 25 Sep 2006 22:11:07 -0700
Message-ID: <7v3baftdp0.fsf@assigned-by-dhcp.cox.net>
References: <20060925155821.GC26844@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 07:11:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS5E9-0007yr-9U
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 07:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWIZFLL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 01:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWIZFLK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 01:11:10 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32231 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751027AbWIZFLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 01:11:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926051107.ZGVA6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 01:11:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id StB41V00a1kojtg0000000
	Tue, 26 Sep 2006 01:11:05 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060925155821.GC26844@spearce.org> (Shawn Pearce's message of
	"Mon, 25 Sep 2006 11:58:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27773>

Shawn Pearce <spearce@spearce.org> writes:

> Tommi Virtanen noted on #git today that
>
>   git ls-files --exclude-per-directory
>
> doesn't appear to work as advertised by the documentation unless
> --others is also used.  According to the current source code this
> is the case as the --exclude-per-directory file isn't read unless
> we are iterating over the working directory, which only happens
> with --others.

I am puzzled by this problem description.

If we _were_ to read --exclude-per-directory file when we are
not doing --others, what better behaviour would we get out of
the command?
