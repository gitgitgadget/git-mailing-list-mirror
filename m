From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Sat, 30 Apr 2011 01:31:00 +0200
Message-ID: <m2k4ecy6rv.fsf@igel.home>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
	<20110429223433.GA3434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:31:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFx9T-00039K-HV
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 01:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754Ab1D2XbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 19:31:06 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40941 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544Ab1D2XbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 19:31:05 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 855F41C08CC3;
	Sat, 30 Apr 2011 01:31:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 1D5101C000F1;
	Sat, 30 Apr 2011 01:31:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id AHzANJhcRqit; Sat, 30 Apr 2011 01:31:01 +0200 (CEST)
Received: from igel.home (ppp-93-104-140-6.dynamic.mnet-online.de [93.104.140.6])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 30 Apr 2011 01:31:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 3A30DCA29C; Sat, 30 Apr 2011 01:31:01 +0200 (CEST)
X-Yow: ..  bleakness....  desolation....  plastic forks...
In-Reply-To: <20110429223433.GA3434@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Apr 2011 18:34:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172512>

Jeff King <peff@peff.net> writes:

> It also conflicts a little with the shell's "~user" syntax, though
> presumably you don't have users named "1" and "2".

Well, you sorta do if you did use pushd.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
