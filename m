From: Yves Caniou <yves.caniou@ens-lyon.fr>
Subject: Re: Compilation pb of git-1.7.0.5
Date: Mon, 19 Apr 2010 09:32:26 +0200
Organization: ENS-LIP
Message-ID: <201004190932.26445.yves.caniou@ens-lyon.fr>
References: <201004190759.15032.yves.caniou@ens-lyon.fr> <i2kfabb9a1e1004182326w32b1ce9ak2ada640ce30cc945@mail.gmail.com>
Reply-To: yves.caniou@ens-lyon.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 09:34:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3lVE-0001sD-Mw
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 09:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab0DSHee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 03:34:34 -0400
Received: from jabiru.ens-lyon.fr ([140.77.51.2]:60919 "EHLO
	jabiru.ens-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab0DSHed convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 03:34:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by jabiru.ens-lyon.fr (Postfix) with ESMTP id 8B900AFAA3;
	Mon, 19 Apr 2010 09:34:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.1 (20080629) (Debian) at ens-lyon.fr
Received: from jabiru.ens-lyon.fr ([127.0.0.1])
	by localhost (jabiru.ens-lyon.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZKav86QRlNgb; Mon, 19 Apr 2010 09:34:30 +0200 (CEST)
Received: from [133.11.204.119] (unknown [133.11.204.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by jabiru.ens-lyon.fr (Postfix) with ESMTPSA id 5883BAFA9F;
	Mon, 19 Apr 2010 09:34:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <i2kfabb9a1e1004182326w32b1ce9ak2ada640ce30cc945@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145271>

Le Monday 19 April 2010 08:26:59 Sverre Rabbelier, vous avez =C3=A9crit=
=C2=A0:
> Heya,
>
> On Mon, Apr 19, 2010 at 07:59, Yves Caniou <yves.caniou@ens-lyon.fr> =
wrote:
> > After the ./configure --prefix=3D$HOME/git, the make all gives me
>
> Which revision are you trying to compile?

I should have recall this in the mail, instead of just let it in the su=
bject: 1.7.0.5

> Also, it's probably more=20
> helpful to just post the result of 'make all' verbatim, rather than
> snippets.

Ok. Thanks to wereHamster on IRC, it appears that the compiler that was=
 used for compilation is the Hitachi Cc version 6.2 and not gcc,=20
because ./configure detects cc and uses cc instead of gcc.

Here is the output of the make all, made after the ./configure [...]

--------
$>make all
    * new build flags or prefix
    CC fast-import.o
cc: Warning: 100, Unknown option, "-g" option is ignored.
fast-import.c: 2622: Warning: 2570, Value assigned to enumeration objec=
t "type" is different type.
fast-import.c: 1776: Warning: 2570, Value assigned to enumeration objec=
t "type" is different type.
fast-import.c: 2213: Warning: 2570, Value assigned to enumeration objec=
t "type" is different type.
fast-import.c: 2346: Warning: 2570, Value assigned to enumeration objec=
t "type" is different type.
    CC abspath.o
cc: Warning: 100, Unknown option, "-g" option is ignored.
    CC advice.o
cc: Warning: 100, Unknown option, "-g" option is ignored.
    CC alias.o
cc: Warning: 100, Unknown option, "-g" option is ignored.
    CC alloc.o
cc: Warning: 100, Unknown option, "-g" option is ignored.
    CC archive.o
cc: Warning: 100, Unknown option, "-g" option is ignored.
archive.c: 223: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 309: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 311: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 313: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 315: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 316: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 317: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 318: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 319: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 320: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 321: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 322: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 323: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 324: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 325: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 326: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 329: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 332: Serious: 4470, Initialization value must be address con=
stant expression.
archive.c: 334: Serious: 4470, Initialization value must be address con=
stant expression.
make: *** [archive.o] Error 1
------------

Note that the direct compilation with the following command calls gcc, =
worked and the installation was successful.
$>make prefix=3D$HOME/git install

Thank you.

=2EYves.
