From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 21:06:09 +0100
Message-ID: <vpqbocipaha.fsf@grenoble-inp.fr>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
	<1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vwqv6fiz7.fsf@alter.siamese.dyndns.org>
	<CAA01CsqwuR+HTUWA+iqSamOcR0WBhwK0kfn5+80L95TZn-SRng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:06:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxNdg-0004MG-5t
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 21:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561Ab3AUUGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 15:06:19 -0500
Received: from mx2.imag.fr ([129.88.30.17]:41334 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755583Ab3AUUGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 15:06:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0LK673e019836
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2013 21:06:07 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TxNdB-000552-WC; Mon, 21 Jan 2013 21:06:10 +0100
In-Reply-To: <CAA01CsqwuR+HTUWA+iqSamOcR0WBhwK0kfn5+80L95TZn-SRng@mail.gmail.com>
	(Piotr Krukowiecki's message of "Mon, 21 Jan 2013 20:34:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 21 Jan 2013 21:06:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0LK673e019836
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359403571.45226@r+7SGqUFc3MZ6hdFcLDExQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214159>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Another issue is usability. Can we definitely say which is better: add
> all changes from current subdir, or add all changes from whole tree? I
> don't know.

Hard to tell, depending on users, use-case, ...

But the good news is: whatever option is chosen, the other one is only a
few keystrokes away (git add -u . or git add -u :/).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
