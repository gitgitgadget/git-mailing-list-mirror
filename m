From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Tue, 10 Apr 2012 10:31:08 +0200
Message-ID: <m262d8j8dv.fsf@igel.home>
References: <7vy5q4tw3i.fsf@alter.siamese.dyndns.org>
	<1334016800-11574-1-git-send-email-bwalton@artsci.utoronto.ca>
	<7vwr5os9zr.fsf@alter.siamese.dyndns.org>
	<1334018233-sup-7389@pinkfloyd.chass.utoronto.ca>
	<7vobr0s8ej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 10:31:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHWU0-0005wl-T9
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 10:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609Ab2DJIbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 04:31:19 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53474 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221Ab2DJIbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 04:31:17 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VRhRd2Jslz3hhbS;
	Tue, 10 Apr 2012 10:31:08 +0200 (CEST)
Received: from igel.home (ppp-93-104-144-197.dynamic.mnet-online.de [93.104.144.197])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VRhRd10VCz4KK5l;
	Tue, 10 Apr 2012 10:31:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 79799CA29F; Tue, 10 Apr 2012 10:31:08 +0200 (CEST)
X-Yow: Now, let's SEND OUT for QUICHE!!
In-Reply-To: <7vobr0s8ej.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 09 Apr 2012 18:05:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195076>

Junio C Hamano <gitster@pobox.com> writes:

> FWIW, it bothers me a lot more that expression does not anchor
> matches against path elements with explicit '/' than the issue your patch
> addresses, i.e.
>
> 	sed -e 's|[^/][^/]*/|../|g'

Note that this requires readding a trailing slash to the path, which
complicates the whole thing a bit.  The effect of * has always been to
use the longest match.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
