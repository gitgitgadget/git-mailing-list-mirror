From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Tue, 06 Mar 2007 00:22:03 -0800
Message-ID: <7v1wk2srx0.fsf@assigned-by-dhcp.cox.net>
References: <esgm1m$33f$1@sea.gmane.org>
	<7vejo2uaxs.fsf@assigned-by-dhcp.cox.net> <45ED179B.90500@lu.unisi.ch>
	<7vlkiastu8.fsf@assigned-by-dhcp.cox.net>
	<45ED1CB9.7060508@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Tue Mar 06 09:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOUvy-0004f4-4u
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 09:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbXCFIWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 03:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbXCFIWH
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 03:22:07 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46394 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbXCFIWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 03:22:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306082205.INWU2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 03:22:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XLN41W0041kojtg0000000; Tue, 06 Mar 2007 03:22:04 -0500
In-Reply-To: <45ED1CB9.7060508@lu.unisi.ch> (Paolo Bonzini's message of "Tue,
	06 Mar 2007 08:48:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41560>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> No, it's not.  But it's helped a lot by using sscanf itself,
> and "%n" is the only way I know to reliably test the return
> code of sscanf and, in the process, save one strchr and one
> strlen.

Ok, let's see if that is true in the next round, then.  I do not
have much against sscanf(%n) as long as its return value is not
depended upon (the portability issue as you mentioned).
