From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Document escaping of special characters in gitignore files
Date: Wed, 05 Jan 2011 16:53:06 +0100
Message-ID: <m27hejtkil.fsf@igel.home>
References: <1294234732-20094-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bruce Korb <bruce.korb@gmail.com>,
	avarab@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 16:53:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaVfo-0002yG-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 16:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab1AEPxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 10:53:10 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37960 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab1AEPxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 10:53:09 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 839541C08DFA;
	Wed,  5 Jan 2011 16:53:07 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 7E4781C00193;
	Wed,  5 Jan 2011 16:53:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 2jui0ESPwJNc; Wed,  5 Jan 2011 16:53:07 +0100 (CET)
Received: from igel.home (ppp-93-104-134-111.dynamic.mnet-online.de [93.104.134.111])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed,  5 Jan 2011 16:53:06 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 98BD1CA2A0; Wed,  5 Jan 2011 16:53:06 +0100 (CET)
X-Yow: Nice decor!
In-Reply-To: <1294234732-20094-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Wed, 5 Jan 2011 14:38:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164568>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 7dc2e8b..20abc20 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -68,6 +68,7 @@ Patterns have the following format:
>     for readability.
>  
>   - A line starting with # serves as a comment.
> +   Use `\#` for a literal # character starting filename.

Should this be written as `{backslash}#`?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
