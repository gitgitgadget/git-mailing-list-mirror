From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] git tag --contains: avoid stack overflow
Date: Tue, 23 Sep 2014 23:48:58 +0200
Message-ID: <87wq8u3t4l.fsf@igel.home>
References: <20140417215817.GA822@sigill.intra.peff.net>
	<20140423075325.GA7268@camelia.ucw.cz>
	<xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
	<20140423191628.GA20596@sigill.intra.peff.net>
	<xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
	<20140423205533.GA20582@sigill.intra.peff.net>
	<xmqqfvl3ycwk.fsf@gitster.dls.corp.google.com>
	<20140424122029.GA8168@camelia.ucw.cz>
	<20140424122439.GB8168@camelia.ucw.cz> <871tr688a4.fsf@igel.home>
	<20140923160552.GA20624@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stepan Kasal <kasal@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWXxO-0005r8-Ue
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756997AbaIWVtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 17:49:06 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53468 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808AbaIWVtF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 17:49:05 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3j2bkh2XPXz3hj9N;
	Tue, 23 Sep 2014 23:49:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3j2bkh1QLCzvh22;
	Tue, 23 Sep 2014 23:49:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 9aL7wUrjAeqe; Tue, 23 Sep 2014 23:48:58 +0200 (CEST)
X-Auth-Info: yS4XTJ2RphYXYYSYd8QJNCKwTkC7Y3usEHbNcpaCkpzVzs+/CvUTJB+CbUhh2s4/
Received: from igel.home (ppp-188-174-63-72.dynamic.mnet-online.de [188.174.63.72])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 23 Sep 2014 23:48:58 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 7BBDB2C4350; Tue, 23 Sep 2014 23:48:58 +0200 (CEST)
X-Yow: I've read SEVEN MILLION books!!
In-Reply-To: <20140923160552.GA20624@peff.net> (Jeff King's message of "Tue,
	23 Sep 2014 12:05:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257446>

Jeff King <peff@peff.net> writes:

> But if we do want to keep it, does bumping it to 128 (and bumping the
> 4000 to 8000 in the test below it) work?

It works for all architectures supported by the openSUSE build service.

https://build.opensuse.org/package/show/home:AndreasSchwab:f/git

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
