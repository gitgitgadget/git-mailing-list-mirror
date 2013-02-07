From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] Git.pm: Add interface for git credential command.
Date: Thu, 07 Feb 2013 08:19:42 +0100
Message-ID: <vpqvca4vbe9.fsf@grenoble-inp.fr>
References: <cover.1360183427.git.mina86@mina86.com>
	<cover.1360183427.git.mina86@mina86.com>
	<f4b5413b0a55474346daa7b0866c7a4fed55778d.1360183427.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 08:20:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3LmN-0002RF-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 08:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809Ab3BGHT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 02:19:56 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53146 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab3BGHTz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 02:19:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r177JfCd030042
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Feb 2013 08:19:41 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U3Llm-0005cC-CB; Thu, 07 Feb 2013 08:19:42 +0100
In-Reply-To: <f4b5413b0a55474346daa7b0866c7a4fed55778d.1360183427.git.mina86@mina86.com>
	(Michal Nazarewicz's message of "Wed, 6 Feb 2013 21:47:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Feb 2013 08:19:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r177JfCd030042
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360826383.25131@3CGpUpX5a5OCiqNJab0zkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215675>

Michal Nazarewicz <mpn@google.com> writes:

> From: Michal Nazarewicz <mina86@mina86.com>
>
> Add a credential() function which is an interface to the
> git credential command.

Nice.

I think you should credit git-remote-mediawiki for the code in the
commit message. Perhaps have a first "copy/paste" commit, and then an
"adaptation" commit to add sort, ^ anchor in regexp, doc and your
callback mechanism, but I won't insist on that.

Other than that, it all looks good, thanks. I'll take care of deleting
the old code in git-remote-mediawiki and use Git.pm instead.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
