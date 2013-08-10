From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 14:34:33 +0200
Message-ID: <87bo55912e.fsf@igel.home>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
	<20130809223758.GB7160@sigill.intra.peff.net>
	<20130809231928.GY14690@google.com>
	<20130810064717.GB30185@sigill.intra.peff.net>
	<52060EF9.2040504@alum.mit.edu>
	<20130810102834.GA6237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 14:34:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V88Ni-00084d-ML
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 14:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630Ab3HJMei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 08:34:38 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43488 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab3HJMeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 08:34:37 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cC2nl3Zlqz4KK7r;
	Sat, 10 Aug 2013 14:34:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cC2nl39jFzbbfR;
	Sat, 10 Aug 2013 14:34:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 2XxNq8pHUxhC; Sat, 10 Aug 2013 14:34:34 +0200 (CEST)
X-Auth-Info: aqrXwCo4+LaRFCIzcB49mLrpoRP3TX9kwps+YkL9+O0=
Received: from igel.home (ppp-88-217-120-19.dynamic.mnet-online.de [88.217.120.19])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 10 Aug 2013 14:34:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id B795D2C01D4; Sat, 10 Aug 2013 14:34:33 +0200 (CEST)
X-Yow: Used staples are good with SOY SAUCE!
In-Reply-To: <20130810102834.GA6237@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 10 Aug 2013 06:28:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232094>

Jeff King <peff@peff.net> writes:

> So if I understand your use case, then you would be even happier if
> rather than giving a warning, git simply barfed and said "please set
> your identity before committing"?

FWIW, this is what both hg and bzr do.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
