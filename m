From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Git build fails on `make`, undefined references in libcrypto.a.
Date: Mon, 18 Mar 2013 11:29:33 +0400
Message-ID: <20130318072933.GC5434@localhost.localdomain>
References: <CAA8xkY==7021SyDmeiOcHMzXbX9L0GgG9yTTED5u1r+tfAPGqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: zero modulo <zeromodulo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 08:30:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHUW7-00087w-2u
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 08:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab3CRH32 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 03:29:28 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:59103 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab3CRH31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 03:29:27 -0400
Received: from proxysrv.domain007.com (localhost [10.8.0.42] (may be forged))
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r2I7TMRG017694;
	Mon, 18 Mar 2013 11:29:23 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 8C45AB248E2; Mon, 18 Mar 2013 11:29:34 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <CAA8xkY==7021SyDmeiOcHMzXbX9L0GgG9yTTED5u1r+tfAPGqg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218395>

On Sun, Mar 17, 2013 at 10:03:37PM -0600, zero modulo wrote:

> $ LDFLAGS=3D"-L/sandbox/builds/lib" CPPFLAGS=3D"-I/sandbox/builds/inc=
lude"
> ./configure --prefix=3D$PREFIX
>=20
> $ make
> [=E2=80=A6]
> /sandbox/builds/lib/libcrypto.a(dso_dlfcn.o): In function `dlfcn_glob=
allookup':
> dso_dlfcn.c:(.text+0x1b): undefined reference to `dlopen'
[...]
> make: *** [git-imap-send] Error 1

=46YI, I've already tried to answer this exact question [1] with no
comments from the OP.

1. http://serverfault.com/a/488604/118848
