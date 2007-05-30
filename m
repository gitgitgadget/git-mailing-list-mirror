From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-parse: Identify short sha1 sums correctly.
Date: Tue, 29 May 2007 17:53:06 -0700
Message-ID: <7vtztv3zf1.fsf@assigned-by-dhcp.cox.net>
References: <1180481391179-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Wed May 30 02:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtCRF-0005po-1N
	for gcvg-git@gmane.org; Wed, 30 May 2007 02:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbXE3AxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 20:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXE3AxJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 20:53:09 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37009 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbXE3AxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 20:53:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070530005308.EUOR15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 29 May 2007 20:53:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5Ct51X01E1kojtg0000000; Tue, 29 May 2007 20:53:07 -0400
In-Reply-To: <1180481391179-git-send-email-jbowes@dangerouslyinc.com> (James
	Bowes's message of "Tue, 29 May 2007 19:29:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48717>

Thanks, James.

This seems to fix the bug I mentioned about 'next' in the last
"What's cooking" message.  Also I have been seeing a segfault
from rev-parse in t5500 (rev-parse --short hits the same issue,
because the bug caused object name not to be abreviated) but
that is also fixed with this patch.

Will apply, instead of reverting the "lazy index loading".
