From: Tommi Virtanen <tv@eagain.net>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 01:25:34 +0300
Message-ID: <20080824222534.GC14930@eagain.net>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org> <20080824203825.GB14930@eagain.net> <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 00:26:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXO2k-0007mQ-Fx
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 00:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYHXWZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbYHXWZi
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 18:25:38 -0400
Received: from eagain.net ([208.78.102.120]:39811 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbYHXWZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 18:25:38 -0400
Received: from musti.eagain.net (a91-156-122-108.elisa-laajakaista.fi [91.156.122.108])
	by eagain.net (Postfix) with ESMTPS id 5E7A81EC039;
	Sun, 24 Aug 2008 22:25:37 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id E69C850869E; Mon, 25 Aug 2008 01:25:34 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93571>

On Sun, Aug 24, 2008 at 02:20:20PM -0700, Junio C Hamano wrote:
> I do not have particular preference either way.  What people wanted was to
> have smaller number of git-foo on $PATH, and especially as "git-shell" is
> not something people would be typing from their command line, so I dunno.

That's true, but I kinda think libexec is something only used
*internally*, and you can't claim /etc/passwd to be internal to git..

At the minimum, git-shell(1) should explain that one needs to use the
libexec path.

-- 
:(){ :|:&};:
