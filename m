From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Deprecate git-cherry
Date: Fri, 06 Jul 2007 13:48:40 -0700
Message-ID: <7vmyy9dzrr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707061722020.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 22:48:44 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ujM-0004Vy-Jp
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 22:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760537AbXGFUsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 16:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760057AbXGFUsm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 16:48:42 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51034 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759816AbXGFUsl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 16:48:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070706204841.XIEP1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Jul 2007 16:48:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LLog1X0031kojtg0000000; Fri, 06 Jul 2007 16:48:40 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51787>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A cleaner alternative was introduced in v1.5.2~185^2~1, which not only
> allows you to list the commits, but to inspect them, too:
>
> 	git log --cherry-pick <upstream>...[<head>]
>
> There is a functional difference, though: git cherry shows both 
> directions, <upstream>...<head> and <head>...<upstream>, and prefixes
> the commits with '+' and '-', respectively.
>
> 'git rev-list --cherry-pick <upstream>...[<head>]' only shows one 
> direction, and does not prefix the commits.

Eh, --left-right anybody?

git-cherry is used by people's scripts, and I do not think
deprecating is an option at least in the short term.
