From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases with symlinks
Date: Mon, 20 Sep 2010 22:18:25 +0200
Message-ID: <201009202218.25558.j6t@kdbg.org>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru> <7vpqwa254i.fsf@alter.siamese.dyndns.org> <20100920180046.GA1790@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 20 22:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxmpE-0001RQ-KQ
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 22:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757447Ab0ITUSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 16:18:30 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46273 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757102Ab0ITUS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 16:18:29 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 495C4A7ECA;
	Mon, 20 Sep 2010 22:18:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CB6DF19F5F8;
	Mon, 20 Sep 2010 22:18:25 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100920180046.GA1790@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156658>

On Montag, 20. September 2010, Jeff King wrote:
>   [diff "SYMLINK"]
>     textconv = pointless-munge
>
> But again, I have no idea why anyone would want such a feature, so it is
> not worth thinking too hard about it.

Some people dislike "\ No newline at end of file" for symlinks. This would be 
the opportunity to hook a suitable diff driver.

-- Hannes
