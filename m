From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH compatibility
Date: Mon, 11 Mar 2013 18:48:13 +0100
Message-ID: <vpqppz5u8te.fsf@grenoble-inp.fr>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v38w1c3ms.fsf@alter.siamese.dyndns.org> <513E0FB4.40607@gmail.com>
	<7v8v5talzu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Manlio Perillo <manlio.perillo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 18:49:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF6qO-0000LB-9O
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 18:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab3CKRsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 13:48:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39544 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab3CKRsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 13:48:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2BHmBj0002149
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 18:48:11 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UF6pZ-00033k-Ci; Mon, 11 Mar 2013 18:48:13 +0100
In-Reply-To: <7v8v5talzu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 11 Mar 2013 10:23:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Mar 2013 18:48:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2BHmBj0002149
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363628892.38522@ehlnGABgMq8bu062YJxThQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217896>

Junio C Hamano <gitster@pobox.com> writes:

> Ahh, thanks for reminding me of this.  You are right; these two
> functions are broken when the user has CDPATH set, I think.
>
> Here is a reroll.

Thanks. Even nicer that the previous since the CDPATH implied the
subshell anyway.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
