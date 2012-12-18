From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: problem with BOINC repository and CR/LF
Date: Tue, 18 Dec 2012 10:58:12 +0100
Message-ID: <50D03E34.8090609@gmx.de>
References: <50CEF289.4040503@gmx.de> <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com> <50CF41EB.1060402@gmx.de> <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com> <50D03D80.3090005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:58:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TktwX-00059A-7v
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 10:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab2LRJ6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2012 04:58:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:51046 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924Ab2LRJ6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 04:58:14 -0500
Received: from mailout-de.gmx.net ([10.1.76.30]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MISg5-1Tp0o61a2B-0048r9 for
 <git@vger.kernel.org>; Tue, 18 Dec 2012 10:58:13 +0100
Received: (qmail invoked by alias); 18 Dec 2012 09:58:13 -0000
Received: from g224044128.adsl.alicedsl.de (EHLO [92.224.44.128]) [92.224.44.128]
  by mail.gmx.net (mp030) with SMTP; 18 Dec 2012 10:58:13 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX1/Q78hZWA/Ql+0l4Pv3MMAqmdFUwSN7EWqd+Vdcga
	OsQDKEa18fZ3IE
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50D03D80.3090005@gmx.de>
X-Enigmail-Version: 1.4.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211741>

On 12/18/2012 10:55 AM, Toralf F=C3=B6rster wrote:
> failed test(s): t3600 t7508
>=20
> fixed   0
> success 8342
> failed  8
> broken  56
> total   8528
>=20

ick forgot these :

n22 /usr/portage/dev-vcs/git # grep -i "^not ok" /tmp/git.log | grep -v=
 TODO
not ok - 15 Test that "git rm -f" fails if its rm fails
not ok - 16 When the rm in "git rm -f" fails, it should not remove the =
file from the index
not ok - 20 Re-add foo and baz
not ok - 21 Modify foo -- rm should refuse
not ok - 22 Modified foo -- rm -f should work
not ok - 23 Re-add foo and baz for HEAD tests
not ok - 24 foo is different in index from HEAD -- rm should refuse
not ok - 55 status succeeds in a read-only repository

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
