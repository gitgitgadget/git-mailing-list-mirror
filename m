From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Remove old forgotten command: whatchanged
Date: Tue, 13 Aug 2013 09:58:11 +0200
Message-ID: <vpqzjsmhvjg.fsf@anie.imag.fr>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr> <ku0lqj$qvs$1@ger.gmane.org>
	<vpqk3jwcb1q.fsf@anie.imag.fr>
	<7v1u649e5m.fsf@alter.siamese.dyndns.org>
	<vpqbo57clnb.fsf@anie.imag.fr>
	<7vwqnu6aei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Damien Robert <damien.olivier.robert+gmane@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 09:58:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V99Uq-0005Gw-3Q
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 09:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab3HMH6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 03:58:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50839 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab3HMH6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 03:58:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7D7wBxc019820
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Aug 2013 09:58:11 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V99UZ-0007gQ-TR; Tue, 13 Aug 2013 09:58:11 +0200
In-Reply-To: <7vwqnu6aei.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Aug 2013 10:28:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 13 Aug 2013 09:58:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7D7wBxc019820
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376985495.8002@TbchFKNTZ+YcMjlQ7S9ZEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232214>

Junio C Hamano <gitster@pobox.com> writes:

> +changes.  You can emulate `git log` with a trivial script that pipes

I'd say "You can emulate `git log` and `git log -p`" here, but I'm fine
with your version too.

> -[NOTE]
> -Most likely, you are not directly using the core
> -Git Plumbing commands, but using Porcelain such as 'git add', `git-rm'
> -and `git-commit'.

This removal sounds unrelated, but I don't understand what this note was
doing here anyway, so it's good to remove it.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
