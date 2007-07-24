From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email and pine alias format
Date: Mon, 23 Jul 2007 23:53:20 -0700
Message-ID: <7vodi2i97j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707231146160.6889@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 08:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDEGr-0001rd-7y
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 08:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbXGXGxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 02:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbXGXGxW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 02:53:22 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56546 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbXGXGxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 02:53:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724065319.PITS1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 02:53:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TJtL1X00U1kojtg0000000; Tue, 24 Jul 2007 02:53:21 -0400
In-Reply-To: <Pine.LNX.4.64.0707231146160.6889@blarg.am.freescale.net> (Kumar
	Gala's message of "Mon, 23 Jul 2007 11:49:29 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53526>

Kumar Gala <galak@kernel.crashing.org> writes:

> I was wondering why we don't parse the pine alias format according to the
> following spec:
>
> http://www.washington.edu/pine/tech-notes/low-level.html
>
> I'd expect something like, to get the address field.

My guess is simply because we got a "works-for-us" regexp by
observing the program's behaviour, done by real Pine users.  On
top of that, probably nobody knew and/or bothered to check if
there is such "official spec" available.

Could you send a signed and testable patch to the list so other
Pine users can try it out please?  After seeing a few Ack's on
the list, I'd like to apply it and preferably do so before 1.5.3
final.
