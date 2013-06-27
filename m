From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: contrib/mw-to-git/Git/Mediawiki.pm
Date: Thu, 27 Jun 2013 18:39:51 +0200
Message-ID: <vpq4ncjcxt4.fsf@anie.imag.fr>
References: <51CC6189.6030701@web.de>
	<CAETqRCgctnVqrYaAYn7uZtv0rvQNawUAi513iTeWPufkZPRgAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 18:40:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsFEr-0000s5-H7
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 18:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab3F0QkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 12:40:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48743 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab3F0Qj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 12:39:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5RGdo0W028600
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Jun 2013 18:39:50 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UsFEe-00046k-Dq; Thu, 27 Jun 2013 18:39:52 +0200
In-Reply-To: <CAETqRCgctnVqrYaAYn7uZtv0rvQNawUAi513iTeWPufkZPRgAw@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Thu, 27 Jun 2013
 18:25:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Jun 2013 18:39:51 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229118>

Beno=EEt Person <benoit.person@ensimag.fr> writes:

> Junio, Matthieu : should I resend a new version of my serie which
> renames the 'git' (lowercase) file into something like 'git-dev' ?

I'd call it bin-wrapper/git, so that people can put bin-wrapper/ in
their $PATH if needed, and by analogy with ../../bin-wrapper. If you go
this way, don't forget to update the $0 relative paths.

git-dev is OK with me too.

> (some comments directly mentionning the 'git' (lowercase) file needs
> to be updated as well in the Makefile)

Yes.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
