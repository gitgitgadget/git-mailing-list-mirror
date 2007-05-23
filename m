From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] disable merge summaries if they are disabled
Date: Wed, 23 May 2007 11:22:57 -0700
Message-ID: <7vhcq32yda.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 20:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqvUE-0004Ez-D8
	for gcvg-git@gmane.org; Wed, 23 May 2007 20:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbXEWSW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 14:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755649AbXEWSW6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 14:22:58 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37009 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbXEWSW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 14:22:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523182258.VSBI6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 14:22:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2iNw1X00Q1kojtg0000000; Wed, 23 May 2007 14:22:57 -0400
In-Reply-To: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com>
	(Alex Riesen's message of "Wed, 23 May 2007 17:28:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48167>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Otherwise the merge.summary option has no visible effect.

I suspect you are mistaking a different merge summary.  The
option affects fmt-merge-msg, iow, the shortlog looking summary
that appears as the commit message in a merge commit.

The command line parameter --no-summary inhibits the diffstat
given to the terminal after "git-pull/git-merge" is made.
