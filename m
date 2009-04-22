From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 20:15:56 +0200
Message-ID: <vpqws9cd06b.fsf@bauges.imag.fr>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
	<20090422152719.GA12881@coredump.intra.peff.net>
	<W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
	<alpine.LFD.2.00.0904221331450.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwhga-0004m1-OX
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbZDVS7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 14:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbZDVS7G
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 14:59:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:34914 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833AbZDVS7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 14:59:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3MIrTQT000738
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Apr 2009 20:53:32 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LwgzE-000196-CO; Wed, 22 Apr 2009 20:15:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LwgzE-0002HF-A8; Wed, 22 Apr 2009 20:15:56 +0200
In-Reply-To: <alpine.LFD.2.00.0904221331450.6741@xanadu.home> (Nicolas Pitre's message of "Wed\, 22 Apr 2009 13\:39\:21 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 22 Apr 2009 20:53:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Why so?  Having fewer packs is always a good thing.  Having only one 
> pack is of course the optimal situation. 

Good and optimal wrt Git, but not wrt an incremental backup system for
example. I have a "git gc" running daily in a cron job in each of my
repositories, but to be nice with my sysadmin, I don't want to rewrite
tens of megabytes of data each night just because I commited a 2 lines
patch somewhere.

-- 
Matthieu
