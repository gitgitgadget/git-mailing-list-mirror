From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Fri, 19 Nov 2010 20:40:18 +0100
Message-ID: <m2ipzt14rh.fsf@igel.home>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
	<20101118175007.GA26505@sigill.intra.peff.net>
	<20101118184241.GN3693@efreet.light.src>
	<20101118190414.GA30438@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 20:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJWoz-0005sj-Qq
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 20:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab0KSTkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 14:40:21 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:43234 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab0KSTkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 14:40:20 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id B6F74188A184;
	Fri, 19 Nov 2010 20:40:18 +0100 (CET)
Received: from igel.home (ppp-88-217-122-42.dynamic.mnet-online.de [88.217.122.42])
	by mail.mnet-online.de (Postfix) with ESMTP id 6A34C1C018E0;
	Fri, 19 Nov 2010 20:40:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 33314CA2A0; Fri, 19 Nov 2010 20:40:18 +0100 (CET)
X-Yow: There's a lot of BIG MONEY in MISERY if you have an AGENT!!
In-Reply-To: <20101118190414.GA30438@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 18 Nov 2010 14:04:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161777>

Jeff King <peff@peff.net> writes:

> it really only makes sense to push from a non-bare repo,

Why?  The repo could itself be a mirror.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
