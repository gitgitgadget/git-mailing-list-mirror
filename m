From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/2] wrapper: supply xsetenv
Date: Tue, 13 Dec 2011 20:21:49 +0100
Message-ID: <m2wra0p99u.fsf@igel.home>
References: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
	<20111213181602.GB1663@sigill.intra.peff.net>
	<7vwra0uxqo.fsf@alter.siamese.dyndns.org>
	<CABPQNSZ_r4u-yXtEGw8duZyoN3SdF5p+7vabz2qqS161kgkHWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 13 20:22:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXvL-0003Rf-P1
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 20:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab1LMTVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 14:21:55 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:53984 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab1LMTVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 14:21:54 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 132871802045;
	Tue, 13 Dec 2011 20:21:51 +0100 (CET)
X-Auth-Info: qNJdSSWOQEfcMo4lCzMq4b9fYSzK94L2DKtpHEucOKg=
Received: from igel.home (ppp-93-104-129-131.dynamic.mnet-online.de [93.104.129.131])
	by mail.mnet-online.de (Postfix) with ESMTPA id 208A11C00132;
	Tue, 13 Dec 2011 20:21:51 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 52DDACA29C; Tue, 13 Dec 2011 20:21:50 +0100 (CET)
X-Yow: Are you mentally here at Pizza Hut??
In-Reply-To: <CABPQNSZ_r4u-yXtEGw8duZyoN3SdF5p+7vabz2qqS161kgkHWQ@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 13 Dec 2011 19:52:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187049>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Older Linux kernels maxed out at 128 kB.

But you wouldn't detect that at setenv time.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
