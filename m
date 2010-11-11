From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <mkiedrowicz@ivo.pl>
Subject: 'gettext -- "--cached cannot be used with --files"' does not work
Date: Fri, 12 Nov 2010 00:10:37 +0100
Message-ID: <20101112001037.6e0fef15@ivo.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 00:36:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGghK-0004My-9A
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 00:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab0KKXgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 18:36:47 -0500
Received: from pc20.ivo.park.gdynia.pl ([153.19.128.20]:40686 "EHLO
	mail.ivo.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab0KKXgp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 18:36:45 -0500
X-Greylist: delayed 1564 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Nov 2010 18:36:45 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.ivo.pl (Postfix) with ESMTP id B408550546CC;
	Fri, 12 Nov 2010 00:10:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail.ivo.pl
Received: from mail.ivo.pl ([127.0.0.1])
	by localhost (mail.ivo.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YmR+IJl-+e63; Fri, 12 Nov 2010 00:10:38 +0100 (CET)
Received: from localhost (184-183-78-94.net.stream.pl [94.78.183.184])
	by mail.ivo.pl (Postfix) with ESMTP id 25FD45074500;
	Fri, 12 Nov 2010 00:10:38 +0100 (CET)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161308>

Hi,

I just noticed that

	'gettext -- "--cached cannot be used with --files"'=20

in git-submodule.sh generates

	#: git-submodule.sh:588
	msgid "--"
	msgstr ""

in *.po files. You can this e.g. in po/de.po.

This is not what commit message says :)

    gettextize: git-submodule "cached cannot be used" message
   =20
    Gettextize the "--cached cannot be used with --files" message. Sinc=
e
    this message starts with "--" we have to pass "--" as the first
    argument. This works with both GNU gettext 0.18.1 (as expected), an=
d
    the gettext(1) on Solaris 10.

$ gettext --version
gettext (GNU gettext-runtime) 0.18.1

--=20
regards,
Micha=C5=82 Kiedrowicz
