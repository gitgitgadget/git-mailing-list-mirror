From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Sun, 24 Aug 2008 13:36:37 -0700
Message-ID: <7vfxoukv56.fsf@gitster.siamese.dyndns.org>
References: <20080824202325.GA14930@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Sun Aug 24 22:37:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXMLU-0003K2-Ay
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYHXUgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbYHXUgv
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 16:36:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbYHXUgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 16:36:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F6556D8D6;
	Sun, 24 Aug 2008 16:36:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B2F786D8D5; Sun, 24 Aug 2008 16:36:40 -0400 (EDT)
In-Reply-To: <20080824202325.GA14930@eagain.net> (Tommi Virtanen's message of
 "Sun, 24 Aug 2008 23:23:25 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5F0F60A0-721C-11DD-B350-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93563>

Tommi Virtanen <tv@eagain.net> writes:

> test:x:1001:1001:,,,:/home/test:/usr/bin/git-shell
>
> line works, and
>
> test:x:1001:1001:,,,:/home/test:/usr/bin/git shell
>
> just makes ssh loop asking for a password, logging

Of course it would.  Does using /usr/libexec/git-core/git-shell work?
