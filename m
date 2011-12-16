From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known extensions
Date: Fri, 16 Dec 2011 23:05:27 +0100
Message-ID: <4EEBC0A7.3030303@kdbg.org>
References: <20111216110000.GA15676@sigill.intra.peff.net> <4EEB4F13.2010402@viscovery.net> <20111216192104.GA19924@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbfuK-0006OF-F9
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882Ab1LPWFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 17:05:34 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:17331 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964826Ab1LPWFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 17:05:32 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C9F34CDF84;
	Fri, 16 Dec 2011 23:06:08 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D75DC19F5FA;
	Fri, 16 Dec 2011 23:05:27 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20111216192104.GA19924@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187323>

Am 16.12.2011 20:21, schrieb Jeff King:
> I'm not clear from what you wrote on whether you were saying it is
> simply sub-optimal, or whether on balance it is way worse than the
> default funcname matching.

I'm saying the latter. Okay, we're talking "only" about hunk headers.
But when you are reviewing patches, they are *extremely* useful and a
time-saver; when they are wrong or not present, they are exactly the
opposite.

> So, I'm confused. If you are using this, surely you have "*.c diff=xcpp"
> in your attributes file, and my patch has no effect for you,

Sure I have. What I didn't say (sorry for that!), but wanted to hint at
is that this is to experiment with a pattern in order to ultimately
improve the built-in pattern. The topic came up just the other day, and
I took Thomas Rast's suggestion to experiment with a simplified pattern:

http://thread.gmane.org/gmane.comp.version-control.git/186355/focus=186439

But as is, the built-in pattern misses way too many anchor points in C++
code.

-- Hannes
