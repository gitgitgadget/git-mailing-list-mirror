From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Thu, 28 Dec 2006 00:25:54 -0800
Message-ID: <7vmz58whnx.fsf@assigned-by-dhcp.cox.net>
References: <20061228073441.GB17304@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 28 09:26:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzqaM-0005z3-Id
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 09:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWL1IZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 03:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWL1IZ4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 03:25:56 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58237 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964969AbWL1IZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 03:25:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228082554.GSPO3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 03:25:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 48S81W0051kojtg0000000; Thu, 28 Dec 2006 03:26:08 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061228073441.GB17304@spearce.org> (Shawn Pearce's message of
	"Thu, 28 Dec 2006 02:34:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35540>

Shawn Pearce <spearce@spearce.org> writes:

> I'd like to see these appear in v1.5.0, but we're getting close to
> the release so I can understand if they get delayed.

I think shooting for -rc1 by mid January and stabilizing by
early to mid February for the real release, would be a realistic
timeline.

Actually I am getting more greedy, and would not mind to have
clean ups and a few more features in the new release, even the
ones that we have talked about but have not implemented.

I am very tempted to have sliding window mmap() if it helps
people on cygwin, for example.  Also, I've been running with
"next" for my daily pushes and pulls without trouble, and I am
very tempted to push out the shallow-clone topic.  Not that I
think its shallow-clone part is useful -- I do not use the
feature myself so I cannot judge -- but at least when shallow is
enabled on neither ends, it does not seem to break anything.

Although I do find the detached HEAD attractive and would want
to have it eventually, I suspect that even if it materializes
soon enough, it would at least need a couple of weeks of testing
in 'next', so making -rc1 wait for it might push back the
release a bit too much.
