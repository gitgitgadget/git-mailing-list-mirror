From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 19:48:55 +0200
Message-ID: <m239i8vjlk.fsf@igel.home>
References: <ivla29$liu$1@dough.gmane.org>
	<20110714015656.GA20136@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 19:49:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQ26-00006L-HK
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253Ab1GNRtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 13:49:00 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52524 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab1GNRs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:48:59 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DCC3A188A19F;
	Thu, 14 Jul 2011 19:48:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 9D2D81C00056;
	Thu, 14 Jul 2011 19:48:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 7PsI5D2DPKXw; Thu, 14 Jul 2011 19:48:56 +0200 (CEST)
Received: from igel.home (ppp-93-104-151-223.dynamic.mnet-online.de [93.104.151.223])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 14 Jul 2011 19:48:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id B075DCA293; Thu, 14 Jul 2011 19:48:55 +0200 (CEST)
X-Yow: I'm into SOFTWARE!
In-Reply-To: <20110714015656.GA20136@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 13 Jul 2011 21:56:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177140>

Jeff King <peff@peff.net> writes:

> So you're probably stuck with extracting the results of "git archive" to
> a temporary directory and then using GNU tar to re-archive them (or if
> you have a checkout, you can just tar that up directly, feeding the list
> from "git ls-files" into tar).

That would lose the embedded commit-id, though.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
