From: Tommi Virtanen <tv@eagain.net>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 20:26:30 +0300
Message-ID: <20080825172630.GH23582@eagain.net>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org> <20080824203825.GB14930@eagain.net> <7vbpzikt4b.fsf@gitster.siamese.dyndns.org> <20080825170816.GQ10544@machine.or.cz> <37fcd2780808251020j1ef51b38h7c6d6e8f050a92ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:27:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXfqr-0007Ty-OX
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 19:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbYHYR0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 13:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbYHYR0d
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 13:26:33 -0400
Received: from eagain.net ([208.78.102.120]:33597 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704AbYHYR0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 13:26:32 -0400
Received: from musti.eagain.net (a91-156-122-108.elisa-laajakaista.fi [91.156.122.108])
	by eagain.net (Postfix) with ESMTPS id D86AC1EC039;
	Mon, 25 Aug 2008 17:26:31 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 6501F508043; Mon, 25 Aug 2008 20:26:30 +0300 (EEST)
Mail-Followup-To: Dmitry Potapov <dpotapov@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <37fcd2780808251020j1ef51b38h7c6d6e8f050a92ce@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93646>

On Mon, Aug 25, 2008 at 09:20:38PM +0400, Dmitry Potapov wrote:
> Perhaps, /usr/sbin would be a better place, as it is intended only for
> system administration binaries.

I'd argue that git-shell isn't *exclusively* for root, which is the
criteria for sbin. It's pretty easy to imagine a user setting up their
own ~/.ssh/authorized_keys with a special passphraseless key that
can only do git operations.

-- 
:(){ :|:&};:
