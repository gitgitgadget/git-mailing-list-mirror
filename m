From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Makefile: quiet shell commands when "make --silent"
Date: Mon, 10 Sep 2012 08:16:51 -0400
Message-ID: <20120910121651.GA26218@padd.com>
References: <20120909230921.GA23806@padd.com>
 <7voblepvdv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 14:17:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB2vH-0006hP-Qk
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 14:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584Ab2IJMQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 08:16:56 -0400
Received: from honk.padd.com ([74.3.171.149]:51166 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757286Ab2IJMQz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 08:16:55 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 6C2755AF5;
	Mon, 10 Sep 2012 05:16:54 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C64FE32112; Mon, 10 Sep 2012 08:16:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7voblepvdv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205121>

gitster@pobox.com wrote on Sun, 09 Sep 2012 17:35 -0700:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > Option "--silent", "--quiet" or "-s" to make prevents
> > echoing of commands as they are executed.  However, there
> > are some explicit "echo" commands in the Makefile and in
> > the two GIT-VERSION-GEN scripts that always echo.
> 
> "make -s clean"?

Fixed here.

> I am not very enthused, especially if the primary motivation is
> about "check-docs".  Such a script must be prepared to filter out
> cruft from the output of $(MAKE) and to pick out the bits that
> interests it and that has been the way of life with $(MAKE) way
> before Git started as a project ;-).

My motivation was to quiet output from a script I use
to test bisectability.  I sent it out because I noticed
someone else found the verbosity annoying too.

Agreed that "fixing" check-docs is not important; that's
why I didn't bother in this patch.

		-- Pete
