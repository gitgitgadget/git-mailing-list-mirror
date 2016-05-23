From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 0/2] send-email: new --quote-mail option
Date: Mon, 23 May 2016 21:38:34 +0200
Message-ID: <vpqlh30d0p1.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, samuel.groot@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon May 23 21:38:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vgc-00067v-BP
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbcEWTil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:38:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57912 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbcEWTik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:38:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4NJcWgU010523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 23 May 2016 21:38:32 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4NJcYZs002009;
	Mon, 23 May 2016 21:38:34 +0200
In-Reply-To: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	(Tom Russello's message of "Mon, 23 May 2016 21:30:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 23 May 2016 21:38:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4NJcWgU010523
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464637115.26734@vLq9eM2dtxkz+8vvs5Qzzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295381>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> Hello,
>
> With the current send-email command, you can send a series of patches "in reply
> to" an email.
> This patch adds a new option to `git send-email`, `--quote-mail=<file>`, to

I think the option name should be --quote-email. Even though "mail"
usually means "email" for French people, there's still non-electronic
mail for english-speaking ones.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
