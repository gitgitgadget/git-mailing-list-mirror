From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] git rm -u
Date: Mon, 21 Jan 2013 09:44:13 +0100
Message-ID: <vpqmww353j6.fsf@grenoble-inp.fr>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
	<vpq622s9jk1.fsf@grenoble-inp.fr>
	<7v622rn1bh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	git@vger.kernel.org, Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 09:44:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCzk-0004Q6-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab3AUIoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:44:23 -0500
Received: from mx1.imag.fr ([129.88.30.5]:45271 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab3AUIoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:44:23 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0L8iDlL027773
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2013 09:44:13 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TxCzG-00083v-97; Mon, 21 Jan 2013 09:44:14 +0100
In-Reply-To: <7v622rn1bh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 20 Jan 2013 10:42:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jan 2013 09:44:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0L8iDlL027773
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359362658.28156@FUo17mSf1ttKsVwXrJvpyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214106>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> "git add -u" is one of the only exceptions (with "git grep"). I consider
>> this as a bug, and think this should be changed. This has been discussed
>> several times here, but no one took the time to actually do the change
>
> Did we ever agree that it is a good change to begin with?  Pointers?

I don't think a consensus was reached, but it has been discussed at
least once in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/166223/focus=168238

Essentially, the discussion boiled down to "it would be cool to change,
but the migration won't be easy".

The main argument for change is (for me) consistency. Having
"git add -p" tree-wide and "git add -u" limited to . is really strange.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
