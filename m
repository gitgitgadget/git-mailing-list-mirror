From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] http.c: use CURLOPT_RANGE for range requests
Date: Mon, 02 Nov 2015 22:50:10 +0100
Message-ID: <87mvuwcbql.fsf@igel.home>
References: <1446492986-32350-1-git-send-email-dturner@twopensource.com>
	<20151102201831.GA10722@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 02 22:50:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtMzd-00066e-34
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 22:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbbKBVuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 16:50:16 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:42125 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbKBVuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 16:50:15 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3nqSb9590wz3hj3D;
	Mon,  2 Nov 2015 22:50:13 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3nqSb92KsHzvdWJ;
	Mon,  2 Nov 2015 22:50:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id qFSB0ACfjnJy; Mon,  2 Nov 2015 22:50:11 +0100 (CET)
X-Auth-Info: z/jXlrkpBQYBYHhHyseeB4mFKzPzX+8/S2xphdwPL5UKaMmNgp+zeIXzlHbgfGP4
Received: from igel.home (ppp-93-104-185-31.dynamic.mnet-online.de [93.104.185.31])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon,  2 Nov 2015 22:50:11 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id CAD902C11FD; Mon,  2 Nov 2015 22:50:10 +0100 (CET)
X-Yow: Hey!!  Let's watch the' ELEVATOR go UP and DOWN at th' HILTON HOTEL!!
In-Reply-To: <20151102201831.GA10722@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 2 Nov 2015 15:18:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280725>

Jeff King <peff@peff.net> writes:

>   4. Fix all of the callers. I suspect this would involve calling
>      fstat(fileno(fh)) to get a real off_t.

You can also use ftello which returns off_t.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
