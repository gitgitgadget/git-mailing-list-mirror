From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] add configuration variable for --autosquash option of interactive rebase
Date: Fri, 09 Jul 2010 20:01:22 +0200
Message-ID: <m27hl4zg99.fsf@igel.home>
References: <20100709124659.GA17559@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 20:01:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXHtD-0004bC-FI
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 20:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab0GISB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 14:01:26 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38173 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990Ab0GISBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 14:01:25 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id C8A3D1C00206;
	Fri,  9 Jul 2010 20:01:23 +0200 (CEST)
Received: from igel.home (ppp-88-217-116-164.dynamic.mnet-online.de [88.217.116.164])
	by mail.mnet-online.de (Postfix) with ESMTP id B3E5E1C000A5;
	Fri,  9 Jul 2010 20:01:23 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 31103CA297; Fri,  9 Jul 2010 20:01:22 +0200 (CEST)
X-Yow: Oh, I get it!!  ``The BEACH goes on,'' huh, SONNY??
In-Reply-To: <20100709124659.GA17559@book.hvoigt.net> (Heiko Voigt's message
	of "Fri, 9 Jul 2010 14:47:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150682>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 6b86abc..54dc983 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -111,6 +111,7 @@ VERBOSE=
>  OK_TO_SKIP_PRE_REBASE=
>  REBASE_ROOT=
>  AUTOSQUASH=
> +test "$(git config --bool rebase.autosquash)" == "true" && AUTOSQUASH=t

That should be '=' instead of '==' (which is non-std).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
