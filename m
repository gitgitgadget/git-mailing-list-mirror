From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: info: display '--' as '-'
Date: Tue, 07 Aug 2012 10:29:00 +0200
Message-ID: <m2lihrxfzn.fsf@igel.home>
References: <CANes+HZ3EH70x6KiaPsV=SQpbjr5o+pEzj2+4Xx613GPZv0SLw@mail.gmail.com>
	<20120807060157.GA13222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mofaph <mofaph@gmail.com>, David Kastrup <dak@gnu.org>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 10:29:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyfAB-0005WD-T3
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 10:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab2HGI3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 04:29:10 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41342 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab2HGI3E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 04:29:04 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WrpmG02kKz4KK85;
	Tue,  7 Aug 2012 10:29:02 +0200 (CEST)
X-Auth-Info: 85qboCOqaN1T5QKaYbd3FyM4xV+wgy96DYqb2D7VQ9Q=
Received: from igel.home (ppp-93-104-155-207.dynamic.mnet-online.de [93.104.155.207])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WrpmF6bkhzbbhW;
	Tue,  7 Aug 2012 10:29:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5688ACA2A2; Tue,  7 Aug 2012 10:29:01 +0200 (CEST)
X-Yow: Mmmmmm-MMMMMM!!  A plate of STEAMING PIECES of a PIG mixed
 with the shreds of SEVERAL CHICKENS!!...  Oh BOY!!  I'm
 about to swallow a TORN-OFF section of a COW'S LEFT LEG
 soaked in COTTONSEED OIL and SUGAR!!  ..  Let's see..
 Next, I'll have the GROUND-UP flesh of CUTE, BABY LAMBS
 fried in the MELTED, FATTY TISSUES from a warm-blooded
 animal someone once PETTED!!  ...  YUM!!  That was GOOD!!
 For DESSERT, I'll have a TOFU BURGER with BEAN SPROUTS
 on a stone-ground, WHOLE WHEAT BUN!!
In-Reply-To: <20120807060157.GA13222@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Aug 2012 02:01:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203024>

Jeff King <peff@peff.net> writes:

> The data looks OK in user-manual.texi, but "--" is converted to "-" in
> git.info. So either:
>
>   1. There is a bug in makeinfo, which should not be doing this
>      conversion inside a "@display" section.

The texinfo manual says that @display does not change the font (unlike
@example), so the body will be rendered like normal text apart from the
extra indentation and preserved line breaks.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
