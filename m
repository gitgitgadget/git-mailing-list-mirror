From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] Handle atexit list internaly for unthreaded builds
Date: Mon, 13 Oct 2014 18:37:22 +0200
Message-ID: <87bnpg9b99.fsf@igel.home>
References: <CACsJy8CbhS=dv3fHvyTv0b-jazh3XS+nswmz_0AsLeHqko794g@mail.gmail.com>
	<1413213552-13769-1-git-send-email-etienne.buira@gmail.com>
	<eb384a98a5c5642c4d3ccf0cf4b74b62e268e100.1413213400.git.etienne.buira@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Etienne Buira <etienne.buira@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 18:37:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdick-0002LH-9L
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 18:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbaJMQh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 12:37:26 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53647 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbaJMQhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 12:37:25 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jGlsv2xGwz3hj6s;
	Mon, 13 Oct 2014 18:37:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jGlsv2G8Mzvh1p;
	Mon, 13 Oct 2014 18:37:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 53PE1K-MHExs; Mon, 13 Oct 2014 18:37:22 +0200 (CEST)
X-Auth-Info: w4oIOhYflRkvwBEdtkZcc0EQrCr+msMkBqTprU16bd2F9tN1EwmId6ONaBB+K9KO
Received: from igel.home (ppp-188-174-148-125.dynamic.mnet-online.de [188.174.148.125])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 13 Oct 2014 18:37:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 31AFF2C2584; Mon, 13 Oct 2014 18:37:22 +0200 (CEST)
X-Yow: I have nostalgia for the late Sixties!  In 1969 I left my laundry with
 a hippie!!  During an unauthorized Tupperware party it was chopped &
 diced!
In-Reply-To: <eb384a98a5c5642c4d3ccf0cf4b74b62e268e100.1413213400.git.etienne.buira@gmail.com>
	(Etienne Buira's message of "Mon, 13 Oct 2014 17:19:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Etienne Buira <etienne.buira@gmail.com> writes:

> +#define tmp_atexit atexit

> +#define atexit tmp_atexit
> +#undef tmp_atexit

What is this supposed to do?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
