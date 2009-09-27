From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: 'git branch --no-merge' is ambiguous
Date: Sun, 27 Sep 2009 10:01:18 +0200
Message-ID: <m24oqo3jg1.fsf@whitebox.home>
References: <4ABC9B69.5010205@viscovery.net> <m2ljk250f7.fsf@igel.home>
	<20090927073305.GA15393@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:01:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrohR-0001gb-D3
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 10:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZI0IBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 04:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbZI0IBP
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 04:01:15 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33606 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbZI0IBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 04:01:15 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 96A131C15387;
	Sun, 27 Sep 2009 10:01:17 +0200 (CEST)
X-Auth-Info: OLlsuYzneK0pIvkNdCaOAYfo8y5NOTZ6aQm8fY1wQz8=
Received: from whitebox.home (DSL01.83.171.162.247.ip-pool.NEFkom.net [83.171.162.247])
	by mail.mnet-online.de (Postfix) with ESMTP id 70F6390273;
	Sun, 27 Sep 2009 10:01:17 +0200 (CEST)
Received: by whitebox.home (Postfix, from userid 501)
	id 390781E5370; Sun, 27 Sep 2009 10:01:18 +0200 (CEST)
X-Yow: YOU'D cry too if it happened to YOU!!
In-Reply-To: <20090927073305.GA15393@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 27 Sep 2009 03:33:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129198>

Jeff King <peff@peff.net> writes:

> -- >8 --
> From: Andreas Schwab <schwab@linux-m68k.org>
> Subject: [PATCH] parse-opt: ignore negation of OPT_NONEG for ambiguity checks
>
> parse_long_opt always matches both --opt and --no-opt for any option
> "opt", and only get_value checks whether --no-opt is actually valid.
> Since the options for git branch contains both "no-merged" and "merged"
> there are two matches for --no-merge, but no exact match.  With this
> patch the negation of a NONEG option is rejected earlier, but it changes
> the error message from "option `no-opt' isn't available" to "unknown
> option `no-opt'".
>
> [jk: added test]
>
> Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
