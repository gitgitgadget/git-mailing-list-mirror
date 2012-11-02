From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Document 'git commit --no-edit' explicitly
Date: Fri, 02 Nov 2012 12:29:46 +0100
Message-ID: <vpqip9ofdjp.fsf@grenoble-inp.fr>
References: <nnpq3wiaha.fsf@stalhein.lysator.liu.se>
	<1351852770-13897-1-git-send-email-Matthieu.Moy@imag.fr>
	<nnlieki6xs.fsf@stalhein.lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: nisse@lysator.liu.se (Niels =?iso-8859-1?Q?M=F6ller?=)
X-From: git-owner@vger.kernel.org Fri Nov 02 12:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUFS4-00015w-PO
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 12:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab2KBLaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 07:30:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49868 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab2KBL37 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 07:29:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qA2BLjci003912
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2012 12:21:46 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TUFRa-0002nO-Bq; Fri, 02 Nov 2012 12:29:46 +0100
In-Reply-To: <nnlieki6xs.fsf@stalhein.lysator.liu.se> ("Niels
 \=\?iso-8859-1\?Q\?M\=F6ller\=22's\?\=
	message of "Fri, 02 Nov 2012 12:24:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 02 Nov 2012 12:21:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qA2BLjci003912
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1352460106.95007@LLlFWQO39/kEnflzCtdeyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208922>

nisse@lysator.liu.se (Niels M=F6ller) writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> +--no-edit::
>> +	Use the selected commit message without launching an editor.
>> +	For example, `git commit --amend --no-edit` amends a commit
>> +	without changing its commit message.
>
> Looks clear enough to me. Thanks for fixing.
>
> Are -c --no-edit and -C really equivalent in all cases?

I guess so, but I didn't check.

> If so, maybe you want to say that in the documentation for -C.

I don't think we should target exhaustivity in the documentation, so I'=
m
not in favor of *adding* it. But maybe we should replace the doc with
stg like:

-c <commit>::
--reedit-message=3D<commit>::
	Like '-C --edit'.

(it could even make sense to deprecate one of -C/-c)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
