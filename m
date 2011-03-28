From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 19:33:51 +0200
Message-ID: <vpq62r3i1z4.fsf@bauges.imag.fr>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
	<AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
	<4D909DD1.2050904@viscovery.net>
	<AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r?= =?iso-8859-1?Q?=F0?= Bjarmason 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:34:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4GKG-0003UN-8H
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab1C1Rd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 13:33:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36431 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755045Ab1C1Rdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 13:33:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p2SHXn8A011175
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Mar 2011 19:33:49 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q4GK7-0001bJ-DU; Mon, 28 Mar 2011 19:33:51 +0200
In-Reply-To: <AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
	(Andrew Garber's message of "Mon, 28 Mar 2011 13:18:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Mar 2011 19:33:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p2SHXn8A011175
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1301938430.70475@S4qiOJCpgvIZ0wASr4TONQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170164>

Andrew Garber <andrew@andrewgarber.com> writes:

> On Mon, Mar 28, 2011 at 10:40 AM, Johannes Sixt <j.sixt@viscovery.net=
> wrote:
>
>> =A0 =A0 =A0o--o--o--B
>> =A0 =A0 /
>> =A0--o--o--o--o--G
>>
>> When I have this history and I mark B as bad and G as good, will I n=
ow
>> find the first bad or the first good commit?
>
> That kind of situation shouldn't occur: IMO, bisect should only deal
> with a single branch (the current branch).

Why?

It's not uncommon in real life to face the "it works in branch foo but
not in branch bar, where did it break?" problem. And one expects a grea=
t
tool such as Git to be able to answer it.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
