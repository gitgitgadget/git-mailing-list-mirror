From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum member
Date: Mon, 07 Nov 2011 19:24:05 +0100
Message-ID: <m2k47b4wqi.fsf@igel.home>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
	<1320581184-4557-4-git-send-email-avarab@gmail.com>
	<m2pqh5nvic.fsf@igel.home>
	<CACBZZX6CRm1W5i43=LeXPJFdcWFgVTkD8cGntHoKsPoWGx_hNg@mail.gmail.com>
	<m3pqh4krer.fsf@hase.home>
	<20111107163823.GB27055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 19:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNTro-0006HL-ET
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 19:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989Ab1KGSYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 13:24:15 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:43071 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab1KGSYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 13:24:14 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id CEB2A188A181;
	Mon,  7 Nov 2011 19:25:42 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 8C8221C001BF;
	Mon,  7 Nov 2011 19:24:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 8rkIC7PlVlcU; Mon,  7 Nov 2011 19:24:06 +0100 (CET)
Received: from igel.home (ppp-93-104-152-211.dynamic.mnet-online.de [93.104.152.211])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon,  7 Nov 2011 19:24:06 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9E5F3CA29C; Mon,  7 Nov 2011 19:24:05 +0100 (CET)
X-Yow: I'm EMOTIONAL now because I have MERCHANDISING CLOUT!!
In-Reply-To: <20111107163823.GB27055@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 7 Nov 2011 11:38:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185007>

Jeff King <peff@peff.net> writes:

> Yes, but now you are getting into implementation-defined behavior, which
> is also something to avoid.

The whole point of the statement is a sanity check to uncover bugs.  If
you remove the first condition you completely ruin its point.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
