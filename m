From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: problem with BOINC repository and CR/LF
Date: Mon, 17 Dec 2012 11:23:05 +0100
Message-ID: <50CEF289.4040503@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 11:28:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkXvx-0001UF-8K
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 11:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab2LQK2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2012 05:28:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:64033 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132Ab2LQK2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 05:28:11 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2012 05:28:11 EST
Received: from mailout-de.gmx.net ([10.1.76.41]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Lqod2-1TF2WP0EYU-00eIHx for
 <git@vger.kernel.org>; Mon, 17 Dec 2012 11:23:07 +0100
Received: (qmail invoked by alias); 17 Dec 2012 10:23:06 -0000
Received: from f054055138.adsl.alicedsl.de (EHLO [78.54.55.138]) [78.54.55.138]
  by mail.gmx.net (mp041) with SMTP; 17 Dec 2012 11:23:06 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX1/U4PdrcfvUMMxq7xcS+VPk8zyznTO9VA+67v7934
	UyB9fkERqSPzy7
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211670>

Hello,

I'm faced with this situation :
http://lists.ssl.berkeley.edu/mailman/private/boinc_alpha/2012-December=
/017371.html
and even a "git stash" doesn't help.

Now /me wonders whether that repository is just screwed up or whether I
do have with git.1.8.0.2 at an almost stable Gentoo linux a problem.
=46WIW I already played (unsuccessful) with this too:


$ grep -B 3 crlf .gitconfig
        confirm =3D never

[core]
        autocrlf =3D true


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
