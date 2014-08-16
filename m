From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter instead of mmap
Date: Sat, 16 Aug 2014 19:00:24 +0200
Message-ID: <874mxc9xp3.fsf@igel.home>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de>
	<1407303134-16635-3-git-send-email-prohaska@zib.de>
	<20140816102703.GD7857@serenity.lan>
	<FA3F1197-25C5-42E4-9418-1C821D430819@zib.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 16 19:00:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIhLG-00084d-1U
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 19:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaHPRAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 13:00:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33911 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbaHPRA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 13:00:29 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3hb77F46dwz3hhp1;
	Sat, 16 Aug 2014 19:00:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3hb77F3nXLz7S6S8;
	Sat, 16 Aug 2014 19:00:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id rZZ-3Q1PmLJZ; Sat, 16 Aug 2014 19:00:24 +0200 (CEST)
X-Auth-Info: pdgmeprc7vjnugDt94susVsM72Q3m8ImXJycimevZEQ=
Received: from igel.home (ppp-93-104-153-146.dynamic.mnet-online.de [93.104.153.146])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 16 Aug 2014 19:00:24 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 2A1AD2C054A; Sat, 16 Aug 2014 19:00:24 +0200 (CEST)
X-Yow: ..  So, if we convert SUPPLY-SIDE SOYBEAN FUTURES into
 HIGH-YIELD T-BILL INDICATORS, the PRE-INFLATIONARY risks
 will DWINDLE to a rate of 2 SHOPPING SPREES per EGGPLANT!!
In-Reply-To: <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de> (Steffen Prohaska's
	message of "Sat, 16 Aug 2014 18:26:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255338>

Steffen Prohaska <prohaska@zib.de> writes:

> The test should confirm that the the file that is added is not mmapped to
> memory.

RSS doesn't tell you that.  You can mmap a big file without RSS getting
bigger.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
