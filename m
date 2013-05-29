From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git init doesn't create master branch
Date: Wed, 29 May 2013 14:50:42 +0200
Message-ID: <vpqk3migdb1.fsf@anie.imag.fr>
References: <51A5F8E0.8060906@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C1kos=2C_Tajti?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Wed May 29 14:50:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhfq8-00075x-0c
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934089Ab3E2Mus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 08:50:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40721 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755679Ab3E2Mur (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:50:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4TCoeH1027968
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 May 2013 14:50:40 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uhfpy-0006qV-Db; Wed, 29 May 2013 14:50:42 +0200
In-Reply-To: <51A5F8E0.8060906@intland.com> (=?iso-8859-1?Q?=22=C1kos=2C?=
 Tajti"'s message of "Wed,
	29 May 2013 14:47:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 May 2013 14:50:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4TCoeH1027968
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1370436643.11296@qMKpbWf2b/LdKtw4P2Nbpg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225804>

"=C1kos, Tajti" <akos.tajti@intland.com> writes:

> Dear List,
>
> the manual of git init says: "An initial HEAD file that references th=
e
> HEAD of the master branch is also created."
>
> However, after creating the repository using git init there's no
> master branch.

Right, but HEAD still points to it ;-). We sometimes call this an
"unborn branch".

> How can make sure that master is created?

It will be created when you do the first commit. If you insist in havin=
g
master created before you actually start working, you can run:

  git commit -m "Initial empty commit" --allow-empty

Right after "git init".

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
