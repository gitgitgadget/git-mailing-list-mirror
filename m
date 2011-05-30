From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 3/3] gitk: Allow displaying time zones from author and commit timestamps
Date: Mon, 30 May 2011 21:35:50 +0200
Message-ID: <m2sjrw9e21.fsf@igel.home>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
	<alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu>
	<20110529044656.GA8881@brick.ozlabs.ibm.com>
	<alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu>
	<alpine.DEB.2.02.1105292305390.23145@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon May 30 21:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR8Ft-0000ff-0P
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 21:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab1E3Tfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 15:35:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50381 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab1E3Tfy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 15:35:54 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id A42E2188B580;
	Mon, 30 May 2011 21:35:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id A2DDE1C0009D;
	Mon, 30 May 2011 21:35:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id cjjhLQPGHfjG; Mon, 30 May 2011 21:35:51 +0200 (CEST)
Received: from igel.home (ppp-88-217-112-53.dynamic.mnet-online.de [88.217.112.53])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 30 May 2011 21:35:51 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id B9619CA29C; Mon, 30 May 2011 21:35:50 +0200 (CEST)
X-Yow: I'm in ATLANTIC CITY riding in a comfortable ROLLING CHAIR...
In-Reply-To: <alpine.DEB.2.02.1105292305390.23145@dr-wily.mit.edu> (Anders
	Kaseorg's message of "Sun, 29 May 2011 23:06:34 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174770>

Anders Kaseorg <andersk@MIT.EDU> writes:

> +		catch {set savedTZ $env(TZ)}
                if {[info exits env(TZ)]} {set savedTZ $env(TZ)}

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
