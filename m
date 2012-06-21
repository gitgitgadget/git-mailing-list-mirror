From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: start warning upcoming default change for push.default
Date: Thu, 21 Jun 2012 17:50:55 +0200
Message-ID: <vpqd34su0io.fsf@bauges.imag.fr>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
	<1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vehp9x3yz.fsf@alter.siamese.dyndns.org>
	<vpqpq8t96zw.fsf@bauges.imag.fr>
	<7va9zxvkyp.fsf@alter.siamese.dyndns.org>
	<7v62alvk2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 17:54:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShjiI-00061M-64
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 17:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab2FUPyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 11:54:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46053 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968Ab2FUPxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 11:53:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5LFoVvr020056
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 17:50:31 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Shjep-0007PJ-QD; Thu, 21 Jun 2012 17:50:55 +0200
In-Reply-To: <7v62alvk2e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 Jun 2012 12:51:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 21 Jun 2012 17:50:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5LFoVvr020056
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340898632.65256@0awIZEn3VUFnQ3yMDeRsXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200404>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps we should say more to help people decide which one to choose
> in this message.
[...]
>     You can squelch this message by picking your preferred default now,
>     e.g. running one of these:
>
>             git config push.default matching
>             git config push.default simple
>             git config push.default current

I don't see any added value. Seeing this, it's less clear to the user,
and he may chose 'simple', and then complain that it breaks his older
Git. Really, if 'simple' isn't an option for someone, why should we make
this someone think before chosing between 'current' an 'simple'?

Also, my version purposely made 'simple' more visible than 'current'
(cut-and-paste ready alone on its line Vs within parenthesis), because
this is the one we want to advertise. Putting the 3 options at the same
level is a regression to me.

We can rephrase the advice to make it clearer that 'simple' !=
'current', like

  (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
  'current' instead if you sometimes use older versions of Git)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
