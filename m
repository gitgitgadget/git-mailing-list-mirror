From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Git's translations need to be updated for submission
Date: Fri, 8 Jul 2011 21:45:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1107082144240.23703@frira.zrqbmnf.qr>
References: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?Q?Marcin_Cie=C5=9Blak?= <saper@saper.info>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Reed <sam@reedyboy.net>
To: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 21:45:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfGzI-0006CK-K0
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 21:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836Ab1GHTpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jul 2011 15:45:12 -0400
Received: from seven.medozas.de ([188.40.89.202]:41921 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896Ab1GHTpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 15:45:11 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id E0DA621A05FF; Fri,  8 Jul 2011 21:45:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id BFB9721A0277;
	Fri,  8 Jul 2011 21:45:09 +0200 (CEST)
In-Reply-To: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176804>

On Wednesday 2011-07-06 21:34, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:

>I was going to submit Git's po/*.po files from the i18n branch but I
>found that while everything else has been cooking they've become out
>of date:
>
>    $ parallel -v -k 'msgfmt --statistics {}' ::: *.po
>    msgfmt --statistics de.po
>    622 translated messages, 58 fuzzy translations, 21 untranslated me=
ssages.
>    msgfmt --statistics en_GB.po
>    3 translated messages, 698 untranslated messages.
>    msgfmt --statistics hi.po
>    14 translated messages, 45 fuzzy translations, 642 untranslated me=
ssages.
>    msgfmt --statistics is.po
>    24 translated messages, 36 fuzzy translations, 641 untranslated me=
ssages.
>    msgfmt --statistics pl.po
>    24 translated messages, 46 fuzzy translations, 631 untranslated me=
ssages.
>    msgfmt --statistics sv.po
>    531 translated messages, 80 fuzzy translations, 90 untranslated me=
ssages.
>
>In particular the fuzzy translations have to be fixed (in some cases
>they're completely wrong), and it would be nice to have the
>untranslated messages translated.

Please retrieve from
	git://dev.medozas.de/git i18n

for German.
