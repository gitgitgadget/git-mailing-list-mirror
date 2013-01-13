From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git list files
Date: Sun, 13 Jan 2013 14:28:00 +0100
Message-ID: <vpqhaml9pr3.fsf@grenoble-inp.fr>
References: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?0KHRgtC+0LnRh9C+INCh0LvQtdC/0YbQvtCy?= 
	<stoycho.sleptsov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 14:28:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuNbv-0006an-MB
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 14:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094Ab3AMN2H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 08:28:07 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52890 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755082Ab3AMN2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 08:28:06 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0DDFsBC024375
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 13 Jan 2013 14:15:54 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TuNbU-0005Te-OI; Sun, 13 Jan 2013 14:28:00 +0100
In-Reply-To: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
	(=?utf-8?B?ItCh0YLQvtC50YfQviDQodC70LXQv9GG0L7QsiIncw==?= message of "Sun,
 13 Jan 2013 14:05:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 13 Jan 2013 14:15:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0DDFsBC024375
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1358687756.61048@Hk2E+0YitIbWgTMskWLMxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213383>

=D0=A1=D1=82=D0=BE=D0=B9=D1=87=D0=BE =D0=A1=D0=BB=D0=B5=D0=BF=D1=86=D0=BE=
=D0=B2 <stoycho.sleptsov@gmail.com> writes:

> Hi,
>
> I was searching for some git- command to provide me a list of files
> (in a git directory), same as ls,
> but showing information from the last commit of the file instead.
>
> lets, say the equivalent of the $ls -d b* within git.git root directo=
ry
> would look like:

git ls-tree HEAD

?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
