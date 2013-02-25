From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] git rm -u
Date: Mon, 25 Feb 2013 20:39:32 +0100
Message-ID: <vpqliac41zf.fsf@grenoble-inp.fr>
References: <50FB1196.2090309@gmail.com> <1358632037-ner-2564@calvin>
	<CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
	<50FB1673.8020808@gmail.com> <7vzjys28a0.fsf@alter.siamese.dyndns.org>
	<CALWbr2x9=+PEaGTpGWoqGiiupGsPhLoPcGknPb1WtSgxdpBkdQ@mail.gmail.com>
	<vpq7glw5i20.fsf@grenoble-inp.fr>
	<CALWbr2y-CN9A346avc4AG+FN9NHgPXKvWuU-nbcyjt08DavVjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:40:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3u8-0004qc-Bj
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759503Ab3BYTjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:39:40 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36386 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759348Ab3BYTjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:39:39 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1PJdUxT005254
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2013 20:39:30 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UA3tc-00022e-Qn; Mon, 25 Feb 2013 20:39:32 +0100
In-Reply-To: <CALWbr2y-CN9A346avc4AG+FN9NHgPXKvWuU-nbcyjt08DavVjw@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 25 Feb 2013 20:21:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 25 Feb 2013 20:39:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1PJdUxT005254
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362425971.24956@yOkDq/TUhQWHEHHvaRO3Zg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217096>

Antoine Pelisse <apelisse@gmail.com> writes:

>> "git rm" really seems to be a better place for removing files from the
>> index.
>
> Then, I don't exactly understand the meaning of git-rm but being a
> _shortcut_ for "remove and stage".

"git rm --cached" is exactly "remove from index".

And even without --cached, as you notice yourself, it does a "remove and
stage [removal]", so why would it be inappropriate to stage a removal?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
