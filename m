From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use whitespace.
Date: Mon, 28 Apr 2008 08:40:27 -0400
Message-ID: <8BF98729-6665-489A-A77B-59498B6C8C29@silverinsanity.com>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com> <20080428094119.GA20499@sigill.intra.peff.net>
Mime-Version: 1.0 (iPhone Mail 4A102)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 14:41:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqSfm-0006A6-8n
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 14:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933068AbYD1Mkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 08:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbYD1Mkp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 08:40:45 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48556 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300AbYD1Mko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 08:40:44 -0400
Received: from [10.145.103.136] (unknown [32.136.67.189])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 238FE1FFD6C4;
	Mon, 28 Apr 2008 12:40:37 +0000 (UTC)
In-Reply-To: <20080428094119.GA20499@sigill.intra.peff.net>
X-Mailer: iPhone Mail (4A102)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80527>


On Apr 28, 2008, at 5:41 AM, Jeff King <peff@peff.net> wrote:
> BTW, how did you discover this bug? Through normal use, or was there a
> failing test?

My small series of one-line patches were from trying to get t3404  
(IIRC) to work. So our tests do help. ;-)

> If a failing test, then I wonder if we could get a few people to set  
> up
> automated tests on alternate platforms. IIRC, Junio makes sure that
> master always passes test on his Linux box and KO (Debian and  
> Redhat, I
> think?). Other platforms could "git pull && make test" daily. I could
> probably do Solaris (once I get the tests to complete pass at all!)  
> and
> FreeBSD 6.

I have a script that boils down to 'make && make test && make  
install'.  I pull, check changes, and then run it once or twice a  
week. I can't dedicate my laptop to automated testing, but I do raise  
a fuss when it fails.

A build farm would help, especially with simple portability errors  
like this. Would be good to get OS X, Solaris (our old nemesis), and a  
few variations for /bin/sh. But I don't really have a good machine to  
volunteer for the effort myself.

~~ Brian G.
