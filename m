From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach runstatus about --untracked
Date: Tue, 12 Sep 2006 23:18:56 -0700
Message-ID: <7vu03c9tm7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609122243360.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060913061040.GA3590@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 13 08:19:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNO5L-00019n-VU
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 08:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWIMGS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 02:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWIMGS5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 02:18:57 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:51191 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751620AbWIMGS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 02:18:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913061856.QGQX6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 02:18:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MiJl1V00F1kojtg0000000
	Wed, 13 Sep 2006 02:18:46 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060913061040.GA3590@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 13 Sep 2006 02:10:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26903>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 12, 2006 at 10:45:12PM +0200, Johannes Schindelin wrote:
>
>> +	if (!s->untracked)
>> +		dir.show_other_directories = 1;
>
> This should also set dir.hide_empty_directories to match the original
> behavior.

Right.  Thanks for eyeballing.
