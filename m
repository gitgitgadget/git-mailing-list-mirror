From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] wt-status.c: Increase readability.
Date: Tue, 26 Apr 2011 09:50:19 +0200
Message-ID: <vpqaafd8n9g.fsf@bauges.imag.fr>
References: <1303801713-22639-1-git-send-email-henrik@fiktivkod.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Henrik Hautakoski <henrik@fiktivkod.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:50:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEd2X-0006Nu-VD
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 09:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab1DZHu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 03:50:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43230 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932253Ab1DZHuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 03:50:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p3Q7oJr6004729
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Apr 2011 09:50:19 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QEd2J-0001R6-U0; Tue, 26 Apr 2011 09:50:19 +0200
In-Reply-To: <1303801713-22639-1-git-send-email-henrik@fiktivkod.org> (Henrik
	Hautakoski's message of "Tue, 26 Apr 2011 09:08:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 26 Apr 2011 09:50:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p3Q7oJr6004729
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1304409022.34632@k4YAwbYmc/FaVZP3Zj+DrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172073>

Henrik Hautakoski <henrik@fiktivkod.org> writes:

> Subject: [PATCH] wt-status.c: Increase readability.

Maybe "increase code readability" instead, I originally thought you
wanted to increase the readability of the output.

> Add braces to if/else statements to make the code more readable.

Git's coding style usually do not use "useless" braces. I think you're
only adding some in if statements that already had one branch (then or
else) braced, which is OK, but you should state that in the commit
message.

I don't care much either way about the application of this patch, but
expect others to say "this is useless code churn, not worth the
trouble".

> -	} else if (s->commitable)
> +	} else if (s->commitable) {
>  		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
>  			advice_status_hints
>  			? _(" (use -u option to show untracked files)") : "");
> +    }

Whitespace damage on the last }.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
