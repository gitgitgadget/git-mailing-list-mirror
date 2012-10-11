From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [minor] two tests broken when run with a --root directory that's
 a symlink
Date: Fri, 12 Oct 2012 00:50:13 +0200
Message-ID: <50774D25.6000403@alum.mit.edu>
References: <CACBZZX6Cu_4X=AywsDMebdoFYdEN1Gmp439aEAcehHBuMhziTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	Tim Henigan <tim.henigan@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 00:50:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMRaG-0005Pt-G1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 00:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab2JKWuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 18:50:18 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:51995 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756813Ab2JKWuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 18:50:16 -0400
X-AuditID: 12074411-b7fa36d0000008cc-41-50774d27107f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F2.EB.02252.72D47705; Thu, 11 Oct 2012 18:50:15 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9BMoDrv013297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2012 18:50:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <CACBZZX6Cu_4X=AywsDMebdoFYdEN1Gmp439aEAcehHBuMhziTw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqKvuWx5gcHKVjsXaZ3eYLLqudDNZ
	7G7Nstj16A+LA4vHzll32T3enWpg9fi8SS6AOYrbJimxpCw4Mz1P3y6BO2NXS23BTa6Knt0X
	2BoYt3N0MXJySAiYSFx9sIsVwhaTuHBvPVsXIxeHkMBlRol/0yYxQTjHmSRWb3sEVsUroC1x
	9OV6RhCbRUBVYs3Sy2BxNgFdiUU9zUwgtqhAmMS7X0eh6gUlTs58wgJiiwi4S3z9uxpsKLPA
	TEaJ7ae7gYo4OIQFIiWajzqB1AgJBEhsmvwAbD6nQKBE+5yFbCAlzALqEuvnCYGEmQXkJZq3
	zmaewCgwC8mGWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pSuokR
	EsCCOxhnnJQ7xCjAwajEw8vytixAiDWxrLgy9xCjJAeTkijvC/fyACG+pPyUyozE4oz4otKc
	1OJDjBIczEoivK80gXK8KYmVValF+TApaQ4WJXFeviXqfkIC6YklqdmpqQWpRTBZGQ4OJQne
	795AjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKI0vBsYpSIoHaO8xkHbe4oLE
	XKAoROspRl2Oj43zHjIKseTl56VKifNuBikSACnKKM2DWwFLV68YxYE+FuZ9AVLFA0x1cJNe
	AS1hAloiM6kEZElJIkJKqoHRKrlT//Vnp3i7uG3nlrjIL0pkUP+/ff3kzd/1dW9v5W98tuJG
	5rk5h86cOTX11MvXCvdrP0zNn9cbVn/l6IbJVXc3yZtUPjMoDXFZPq8w7fjKM5ZX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207519>

On 10/11/2012 11:55 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> These issues are minor, I noticed it because I test with /dev/shm/git
> as the --root, which on Debian is symlinked to /run/..
>=20
>     $ rm -rf /tmp/{foo,bar}
>     $ mkdir /tmp/target; ln -s /tmp/target /tmp/link
>     $ prove ./t4035-diff-quiet.sh ./t9903-bash-prompt.sh :: --root=3D=
/tmp/target
>     ./t4035-diff-quiet.sh ... ok
>     ./t9903-bash-prompt.sh .. ok
>     All tests successful.
>     Files=3D2, Tests=3D64,  1 wallclock secs ( 0.04 usr  0.00 sys +  =
0.07
> cusr  0.06 csys =3D  0.17 CPU)
>     Result: PASS
>     $ prove ./t4035-diff-quiet.sh ./t9903-bash-prompt.sh :: --root=3D=
/tmp/link
>     ./t4035-diff-quiet.sh ... Dubious, test returned 1 (wstat 256, 0x=
100)
>     Failed 3/20 subtests
>     ./t9903-bash-prompt.sh .. Dubious, test returned 1 (wstat 256, 0x=
100)
>     Failed 6/44 subtests
>=20
> Everything else in the test suite passes with a --root that's a symli=
nk.

I ran into the same problem a while ago, and submitted a patch series
that fixes t4035 (whose problems are related to GIT_CEILING_DIRECTORIES=
):

    http://thread.gmane.org/gmane.comp.version-control.git/206633

Junio didn't like the approach so much and I haven't yet had time to
submit a revised version.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
