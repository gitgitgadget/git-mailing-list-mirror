From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/5 v4] log: parse detached options like git log --grep foo
Date: Tue, 03 Aug 2010 21:52:05 +0200
Message-ID: <vpq39uvzd7e.fsf@bauges.imag.fr>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
	<1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
	<7vvd7tlzfu.fsf@alter.siamese.dyndns.org>
	<vpqtyncdeuc.fsf@bauges.imag.fr>
	<7vsk2wk8lc.fsf@alter.siamese.dyndns.org>
	<vpq8w4ob3yz.fsf@bauges.imag.fr>
	<7vlj8nipl9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 21:57:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgNcW-00088J-Fn
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 21:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516Ab0HCT5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 15:57:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56918 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756973Ab0HCT5q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 15:57:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o73Jfbgk027840
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Aug 2010 21:41:39 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgNWw-0005UD-6u; Tue, 03 Aug 2010 21:52:06 +0200
In-Reply-To: <7vlj8nipl9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 03 Aug 2010 10\:16\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Aug 2010 21:41:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o73Jfbgk027840
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281469301.74166@4SmGVfNSCQ5mjX4abhTlew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152536>

Junio C Hamano <gitster@pobox.com> writes:

> But I thought you were suggesting to [...] never take:
>
>     --opt <string> (even when --opt always takes an argument)
>
> because that would further reduce one source of potential confusion
> (i.e. the user needs to remember if --opt always takes an argument or
> not).  I thought you mentioned that neither parse-options nor GNU tools
> take "--prune last",

No, I said the opposite: both do.

> "--color auto" as a good supporting argument for this

"grep --color auto" is refused because the "auto" part is optional.
But both "grep --regex foo" and "grep --regexp=foo" are accepted. Same
for "git commit --message=foo" and "git commit --message foo".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
