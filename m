From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 23:08:34 +0200
Message-ID: <m2obkz9j8t.fsf@igel.home>
References: <505CCA55.6030609@gmail.com>
	<1348260766-25287-1-git-send-email-artagnon@gmail.com>
	<20120921205834.GC22977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:08:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFASt-0001GI-V2
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757860Ab2IUVIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:08:40 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55126 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab2IUVIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:08:39 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XNnTt55C9z3hhbl;
	Fri, 21 Sep 2012 23:08:34 +0200 (CEST)
X-Auth-Info: nOFk4i0d5XAuWHAzm1lG0T3ltrchXnJimtO5PvWCqU8=
Received: from igel.home (ppp-88-217-127-217.dynamic.mnet-online.de [88.217.127.217])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XNnTt4nNjzbbm9;
	Fri, 21 Sep 2012 23:08:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 4BEB5CA2A5; Fri, 21 Sep 2012 23:08:34 +0200 (CEST)
X-Yow: Sometimes a TABOO is just a good CIGAR -- or a
 rare STEAK -- or a dry MARTINI!
In-Reply-To: <20120921205834.GC22977@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 21 Sep 2012 16:58:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206167>

Jeff King <peff@peff.net> writes:

> A bigger question is: why are you setting SHELL=zsh in the first place?

SHELL is set to the login shell by default.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
