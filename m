From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Mon, 30 Apr 2007 20:20:38 -0700
Message-ID: <7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
References: <463678B7.70409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 05:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiiv6-000366-GQ
	for gcvg-git@gmane.org; Tue, 01 May 2007 05:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbXEADUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 23:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755470AbXEADUm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 23:20:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60140 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465AbXEADUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 23:20:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501032040.ZNXN1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 23:20:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tfLe1W00E1kojtg0000000; Mon, 30 Apr 2007 23:20:39 -0400
In-Reply-To: <463678B7.70409@gmail.com> (Dana How's message of "Mon, 30 Apr
	2007 16:16:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45905>

Dana How <danahow@gmail.com> writes:

> It is based on "next" in order to incorporate Nicolas Pitre's work.

Heh, since last night, 'master' and 'next' points at exactly the
same tree object, although their commit ancestry are vastly
different for obvious reasons.

Which leaves 'master' right now at v1.5.2-rc1 while 'next' at
v1.5.2-rc1-687-gcb3892c; we might want to do something about
this apparent discrepancy.
