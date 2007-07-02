From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-prune submodule aware (and fix a SEGFAULT in the process)
Date: Mon, 02 Jul 2007 16:11:44 -0700
Message-ID: <7vwsxiv1sf.fsf@assigned-by-dhcp.cox.net>
References: <200707021356.58553.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:12:02 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5V3p-0008BX-8l
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbXGBXLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757179AbXGBXLq
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:11:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50410 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757096AbXGBXLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:11:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702231144.VNAA1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 19:11:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JnBk1X0081kojtg0000000; Mon, 02 Jul 2007 19:11:44 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51427>

Andy Parkins <andyparkins@gmail.com> writes:

> ...
> The fix made by this patch is to not blindly call lookup_blob() in
> reachable.c's add_cache_refs(), and instead skip any index entries that
> are S_ISGITLINK().

Thanks, both of you.  Will go to 'maint' hopefully tonight (if I
can shake the day job off early enough today, that is).
