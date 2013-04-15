From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 15:45:02 +0200
Message-ID: <vpqbo9foqld.fsf@grenoble-inp.fr>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
	<1365887729-9630-4-git-send-email-artagnon@gmail.com>
	<vpq38us2oov.fsf@grenoble-inp.fr>
	<7vbo9g15po.fsf@alter.siamese.dyndns.org>
	<vpqbo9gqcvl.fsf@grenoble-inp.fr>
	<CALkWK0nymT=wTnHpTE=uBsqoHxACFb4gStU0SGE79bc7uBVKXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 15:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URjk3-0007mr-Pg
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 15:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab3DONqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 09:46:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37551 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839Ab3DONqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 09:46:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3FDj13O002097
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 15:45:01 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1URjiQ-0007if-RD; Mon, 15 Apr 2013 15:45:02 +0200
In-Reply-To: <CALkWK0nymT=wTnHpTE=uBsqoHxACFb4gStU0SGE79bc7uBVKXQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 18:59:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Apr 2013 15:45:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3FDj13O002097
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366638302.00481@xbnRd0lCPQUDLeHmBp9/JA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221230>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> First, this is not why Junio said pull.autostash is harmful: he had a
> completely different objection.

Yes. This is another objection.

> Second, this makes no sense.  The user consciously made the decision
> to set pull.autostash to true

... possibly a long time ago.

> This case is roughly equivalent to the user executing 'git stash' and
> suddenly waking up one day and complaining "WTF, where are my
> important changes?!?".

I disagree. A configuration option is something you set once, and then
forget about. A command, or a command-line option, is something you
explicitely add when you need it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
