From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git  log --grep=foo".
Date: Tue, 27 Jul 2010 10:45:53 +0200
Message-ID: <vpqbp9t9uta.fsf@bauges.imag.fr>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTikGPMDvxQKjpKOBge8UwrC_GuC36_=C_tYR_ngr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 10:46:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odfnf-0007Ts-E3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 10:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab0G0IqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 04:46:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38833 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755654Ab0G0Ip7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 04:45:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o6R8ZlT6017821
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 10:35:47 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OdfnN-0001k3-VQ; Tue, 27 Jul 2010 10:45:54 +0200
In-Reply-To: <AANLkTikGPMDvxQKjpKOBge8UwrC_GuC36_=C_tYR_ngr@mail.gmail.com> (Sverre Rabbelier's message of "Tue\, 27 Jul 2010 01\:43\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 27 Jul 2010 10:35:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6R8ZlT6017821
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280824551.21146@NjEabima1zarDB8YhpnpLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151919>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Mon, Jul 26, 2010 at 13:14, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:
>> + =A0 =A0 =A0 } else if (!strcmp(arg, "--grep")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_message_grep(revs, optarg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
>
> This one makes a little less sense since to me '--flag' are always
> booleans, whereas '-m' can take an argument (such as '-m' from 'git
> commit'.

Try this:

  git commit --message foo

=2E.. it works. Parse-options allows it, but handwritten option parsing
for git log doesn't.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
