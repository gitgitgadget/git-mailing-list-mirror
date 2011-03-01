From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Tue, 01 Mar 2011 21:25:29 +0100
Message-ID: <vpqvd02a8qu.fsf@bauges.imag.fr>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
	<7vei6t4uwa.fsf@alter.siamese.dyndns.org>
	<AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
	<7vy6512rnb.fsf@alter.siamese.dyndns.org>
	<AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
	<7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
	<vpqipw2rixy.fsf@bauges.imag.fr>
	<7vd3maelbh.fsf@alter.siamese.dyndns.org>
	<vpq4o7mfzd1.fsf@bauges.imag.fr>
	<7vzkped2hk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?iso-8859-1?Q?G=E1b?= =?iso-8859-1?Q?or?= 
	<szeder@ira.uka.de>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuW8t-0001xc-Fp
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418Ab1CAUZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 15:25:54 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35466 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757388Ab1CAUZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:25:53 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p21KPP6n027495
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Mar 2011 21:25:25 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PuW8P-00075p-Ie; Tue, 01 Mar 2011 21:25:29 +0100
In-Reply-To: <7vzkped2hk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Mar 2011 12:12:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Mar 2011 21:25:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p21KPP6n027495
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1299615928.13833@YYO/watZATdO+OOK1H8dPg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168253>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> But "update" should mean "replace git add -u with git add -u .", which
>> is the portable way to do the same.
>>
>>> so the introduction of the configuration becomes a flag-day event.
>>> Hmph...
>>
>> The introduction of the config variable is a non-event if you already
>> use the portable . notation.
>
> I think you got this part wrong.  Until now, there was no "portability" to
> worry about when using "git add -u".  "git add -u" used to be _guaranteed_
> to be relative to the cwd, with or without ".".  Our update will _break_
> that expectation and suddenly make "." "the portable notation".
>
> In other words, it is far from a non-event.

There is a "if" in my sentence, and I do claim that if you verify the
condition behind the "if", it is a non-event.

I did not claim that the whole change was a non-event, just that the
introduction of a config variable was.

> We still have to say "We are sorry, we will be breaking your scripts.
> Please add an extra dot at the end".

Absolutely. My claim is just that adding the extra dot is the way to fix
script wrt the future change, or at least a better way than relying on a
config variable.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
