From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum member
Date: Mon, 07 Nov 2011 21:13:30 +0100
Message-ID: <m2d3d34ro5.fsf@igel.home>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
	<1320581184-4557-4-git-send-email-avarab@gmail.com>
	<m2pqh5nvic.fsf@igel.home>
	<CACBZZX6CRm1W5i43=LeXPJFdcWFgVTkD8cGntHoKsPoWGx_hNg@mail.gmail.com>
	<m3pqh4krer.fsf@hase.home>
	<20111107163823.GB27055@sigill.intra.peff.net>
	<m2k47b4wqi.fsf@igel.home>
	<20111107183402.GA5118@sigill.intra.peff.net>
	<20111107185536.GA5450@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 21:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNVZg-0002f6-3C
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 21:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab1KGUNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 15:13:36 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:36062 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1KGUNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 15:13:36 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id AE6FE188A19C;
	Mon,  7 Nov 2011 21:15:06 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 77C461C0006E;
	Mon,  7 Nov 2011 21:13:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Nsv8NHtztV8C; Mon,  7 Nov 2011 21:13:31 +0100 (CET)
Received: from igel.home (ppp-93-104-152-211.dynamic.mnet-online.de [93.104.152.211])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon,  7 Nov 2011 21:13:31 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 198D5CA29C; Mon,  7 Nov 2011 21:13:31 +0100 (CET)
X-Yow: I decided to be JOHN TRAVOLTA instead!!
In-Reply-To: <20111107185536.GA5450@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 7 Nov 2011 13:55:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185021>

Jeff King <peff@peff.net> writes:

> I do still question the value of the check at all, though, given that
> static analysis can find those bugs.

Then you should remove the whole statement.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
