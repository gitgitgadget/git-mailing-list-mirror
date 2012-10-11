From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG] Directory probing for aliases
Date: Thu, 11 Oct 2012 13:28:31 +0200
Message-ID: <m2sj9ll02o.fsf@igel.home>
References: <CAFKeBpcCZwMMcBtP8KywqnyK3e247K1Z_8na5ah+Wb+E15LPVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasiliy Yeremeyev <vayerx@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 13:28:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMGwW-0004DR-Vy
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 13:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758522Ab2JKL2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 07:28:34 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51884 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398Ab2JKL2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 07:28:34 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XcqgN0R2wz3hhg5;
	Thu, 11 Oct 2012 13:28:32 +0200 (CEST)
X-Auth-Info: 1Ir41o8UobqXu+6ibqqfyHU4HkW76ndHWyJ0ArNA82Y=
Received: from igel.home (ppp-88-217-111-196.dynamic.mnet-online.de [88.217.111.196])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XcqgN06kKzbbct;
	Thu, 11 Oct 2012 13:28:32 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 4E30ACA2A4; Thu, 11 Oct 2012 13:28:31 +0200 (CEST)
X-Yow: Yow!  We're going to a new disco!
In-Reply-To: <CAFKeBpcCZwMMcBtP8KywqnyK3e247K1Z_8na5ah+Wb+E15LPVQ@mail.gmail.com>
	(Vasiliy Yeremeyev's message of "Thu, 11 Oct 2012 14:22:45 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207472>

Vasiliy Yeremeyev <vayerx@gmail.com> writes:

> Git aliases stop working when user doesn't have permissions to any
> directory within $PATH list:
>
> % git config alias.br branch
> % git br
> fatal: cannot exec 'git-br': Permission denied

This has been fixed in git-1.7.10.1.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
