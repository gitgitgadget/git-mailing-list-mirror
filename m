From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git merge commits are non-deterministic? what changed?
Date: Fri, 09 Nov 2012 16:52:48 +0100
Message-ID: <vpq390idb8v.fsf@grenoble-inp.fr>
References: <20121109133132.GK69724@acme.spoerlein.net>
	<m2y5iarf5s.fsf@igel.home> <20121109154245.GP69724@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Ulrich =?iso-8859-1?Q?Sp=F6rlein?= <uqs@spoerlein.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWqtY-0001KL-MS
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 16:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab2KIPxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 10:53:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:60669 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab2KIPxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 10:53:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qA9FjSve026815
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2012 16:45:28 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TWqsy-0003pj-NJ; Fri, 09 Nov 2012 16:52:48 +0100
In-Reply-To: <20121109154245.GP69724@acme.spoerlein.net> ("Ulrich
 \=\?iso-8859-1\?Q\?Sp\=F6rlein\=22's\?\=
	message of "Fri, 9 Nov 2012 16:42:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 09 Nov 2012 16:45:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qA9FjSve026815
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1353080732.11124@Pkjsb0gjFa77hpulTAQrKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209224>

Ulrich Sp=F6rlein <uqs@spoerlein.net> writes:

>> > 2. Why the hell is the commit hash dependent on the ordering of th=
e
>> > parent commits? IMHO it should sort the set of parents before
>> > calculating the hash ...
>>=20
>> What would be the sort key?
>
> Trivially, the hash of the parents itself. So you'd always get
>
> ...
> parent 0000
> parent 1111
> parent aaaa
> parent ffff

That would change the behavior of --first-parent. Or you'd need to
compute the sha1 of the sorted list, but keep the unsorted one in the
commit. Possible, but weird ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
