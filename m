From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH compatibility
Date: Mon, 11 Mar 2013 17:47:40 +0100
Message-ID: <vpqtxohubmb.fsf@grenoble-inp.fr>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v38w1c3ms.fsf@alter.siamese.dyndns.org>
	<7vobepany3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 17:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5ty-0008Kx-Uc
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab3CKQsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 12:48:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51154 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab3CKQsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 12:48:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2BGlcw6000827
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 17:47:38 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UF5sy-0001rF-Eq; Mon, 11 Mar 2013 17:47:40 +0100
In-Reply-To: <7vobepany3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 11 Mar 2013 09:41:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Mar 2013 17:47:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2BGlcw6000827
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363625260.03442@vIK622hDIzhFIzX6mIMziQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217889>

Junio C Hamano <gitster@pobox.com> writes:

> So here is an updated based on your patch.

Perfect, thanks.

> The correct thing to do in the longer term may be to stop dot-sourcing
> the source meant for bash into zsh, but this patch should suffice as
> a band-aid in the meantime.

I disagree with this particular part though. I think using the same code
for bash and zsh makes sense, and it implies restricting to the common
subset. I don't consider it "band-aid", but "nice code factoring" ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
