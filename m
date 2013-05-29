From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git init doesn't create master branch
Date: Wed, 29 May 2013 15:08:13 +0200
Message-ID: <vpqbo7udjcy.fsf@anie.imag.fr>
References: <51A5F8E0.8060906@intland.com> <vpqk3migdb1.fsf@anie.imag.fr>
	<CALkWK0m=m89QcnMNg9gEVeb7ZHSRd7ZMcL+y8gYuzn8YCTsSYw@mail.gmail.com>
	<51A5FC17.8000608@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C1kos=2C_Tajti?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhg77-0004zN-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966119Ab3E2NIT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:08:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58296 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966072Ab3E2NIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:08:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4TD8C8K000503
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 May 2013 15:08:12 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uhg6v-0007PB-QT; Wed, 29 May 2013 15:08:13 +0200
In-Reply-To: <51A5FC17.8000608@intland.com> (=?iso-8859-1?Q?=22=C1kos=2C?=
 Tajti"'s message of "Wed,
	29 May 2013 15:01:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 May 2013 15:08:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4TD8C8K000503
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1370437693.76525@JMTsx6pQJOFN0S+O7yvXSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225808>

"=C1kos, Tajti" <akos.tajti@intland.com> writes:

> The command was:
>
> git pull ../dump.dmp refs/heads/*:refs/heads/*

"git pull" does internally a "git fetch" followed by a "git merge".

If you try to pull several branches at the same time, it means you want
to merge all of them together (octopus merge), which probably isn't wha=
t
you're trying to do. You probably want just a "git fetch", or specify
only one branch to pull.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
