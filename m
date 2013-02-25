From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] git rm -u
Date: Mon, 25 Feb 2013 20:07:03 +0100
Message-ID: <vpq7glw5i20.fsf@grenoble-inp.fr>
References: <50FB1196.2090309@gmail.com> <1358632037-ner-2564@calvin>
	<CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
	<50FB1673.8020808@gmail.com> <7vzjys28a0.fsf@alter.siamese.dyndns.org>
	<CALWbr2x9=+PEaGTpGWoqGiiupGsPhLoPcGknPb1WtSgxdpBkdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3Om-0003Jo-0R
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759346Ab3BYTHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:07:15 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51253 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758580Ab3BYTHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:07:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1PJ72Wb017709
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2013 20:07:02 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UA3OB-0001RE-Uj; Mon, 25 Feb 2013 20:07:04 +0100
In-Reply-To: <CALWbr2x9=+PEaGTpGWoqGiiupGsPhLoPcGknPb1WtSgxdpBkdQ@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 25 Feb 2013 19:54:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 25 Feb 2013 20:07:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1PJ72Wb017709
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362424027.9984@jmcwUpnX0m+qsAUXKrUNmg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217087>

Antoine Pelisse <apelisse@gmail.com> writes:

> I must say that I'm not very interested in the feature. In my opinion,
> there are already many different ways to stage changes.
> Assuming that the feature would be needed, I would keep it under the
> scope of git-add, as it's the reference for staging. I would suggest
> something like:
>
>     git add -r   "Stage removal of deleted files."

Would "add -r" stand for "add --remove"? That would be weird ...

"git rm" really seems to be a better place for removing files from the
index.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
