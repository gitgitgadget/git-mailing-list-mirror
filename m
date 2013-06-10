From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Mon, 10 Jun 2013 10:24:04 +0200
Message-ID: <vpqvc5mqspn.fsf@anie.imag.fr>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<1370680434-2709-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<CALkWK0==9aN1wVoSXENvTJHOT8bd2SYrEFxrmTdhzMxB3mHPCQ@mail.gmail.com>
	<19969d9996306bf0e7ac6351d4ad435d@ensibm.imag.fr>
	<CALkWK0n+yF-kRahgsQQuT-+QiT5gy=J_Bdati=uooiW0djQrgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu =?iso-8859-1?Q?Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:24:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlxOh-0006qQ-If
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab3FJIYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 04:24:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46736 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128Ab3FJIYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:24:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5A8O3YL015325
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 10:24:03 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlxOW-0007tR-ES; Mon, 10 Jun 2013 10:24:04 +0200
In-Reply-To: <CALkWK0n+yF-kRahgsQQuT-+QiT5gy=J_Bdati=uooiW0djQrgw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 10 Jun 2013 13:25:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 10:24:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227258>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Mathieu Li=E9nard--Mayor wrote:
>> I'm not so sure i understand. Do you mean rmHints should deactivate =
addHints
>> aswell, or do you mean that since we're introducing rmHints it would=
 be
>> natural to introduce addHints ?
>
> More the latter, but I'm tilting towards addRmHints (or something)
> which affects both add and rm hints.

I don't see why add and rm hints should be correlated, or I don't have
the same advice as you in mind.

$ git add foo.txt
The following paths are ignored by one of your .gitignore files:
foo.txt
Use -f if you really want to add them.
fatal: no files added

$ git rm foo.txt=20
error: 'foo.txt' has changes staged in the index
(use --cached to keep the file, or -f to force removal)

Both have completely different meanings: the first is about .gitignore,
and the second about not loosing data.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
