From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] setup.c: make check_filename() return 0 on
 ENAMETOOLONG
Date: Sun, 7 Feb 2016 13:23:49 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602071317330.2964@virtualbox>
References: <CA+4vN7w2=JWusWDhhGNzAkJbE-s44G4WoXdvf26yzvtYfpktfQ@mail.gmail.com> <1454800992-15953-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1586373786-1454847484=:2964"
Cc: git@vger.kernel.org, ole@tange.dk
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 13:24:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSOOA-00053p-Ih
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 13:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbcBGMX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 07:23:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:63959 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbcBGMXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 07:23:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MOwY7-1aM2iW1v9D-006KaP; Sun, 07 Feb 2016 13:23:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1454800992-15953-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-ID: <alpine.DEB.2.20.1602071318200.2964@virtualbox>
X-Provags-ID: V03:K0:4jSRxoYfWnXu5EWYX247xuGhDNTvSqYbnUY0cVTS/m7RECOlU1p
 vN24VU5FTi+2SmN3O2QXozbsm4QB/VcYTQ8BXdokha1frDiKr2LnA2oSaaEd9VBxktWySfC
 lOaO1LO79AHE/Px0RY8BzjIuKF3J8dmLCmHfB2VnczmI012xx/eDZ3G3LfvAGsHzojC1SJ8
 hBIqylWor7lE48FMbLY3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lT/P8JHANrA=:aItevb+LkgJAomdNU5PhFO
 0cbUDoy81z/7CKYSC5R3mJWH/D6OuqpxX9YB+6nLiKZ28q2IVnMlfsGVbH8REpf0IIRhPZmOt
 wSMMe/IkHD6oALavXCA7OBeUKl1QV0vteB2rC/ho11Ai9kCNj2DFhwvgTsg+s5pX7QWF3wZFr
 toB0Fh9fVAVNpcRQrqHsUvfttVGay4gjDgQP4C/zzjZngshVHXP8HSyWPBSHp8vewlgvRwqo9
 jFGYkE6b6w8m3yW4lH6kwSBeeWTpi0T270xZQzvU7oyj/HV1t2kIzbQ8v1h+mww+ma0f20v/u
 X4APofM6JgKF0CEpD8fHDmBtPDyUwI/c3qmvdRHiqt7b1A+ZXEuPdnlDIQM8Xb03SZU4zcsbu
 fKrHOmbbBIF7l426aAJaYkZWxpRdwOyYVMXLEyhiwTvOFzyOBheMixlPftHzHtyRx+u/1oXHt
 mv+jq8hawnxdG7YNJD4O9b8tkW/H9XhTr9yGNCKR0wM+PZDlkyMjSdOUEEd0ne9Zuf8qP1PsO
 PEPrA3ARmiaqUeXhWFXnUhqmfkZe6M9ghIXtw0RnwnGN+YrWB3WaT4YKSxerbNQcBxyuS3LS1
 pYlwIIBumZGKH2VRLvR80bR2glzcWt5e6elkmANWHH6d8uwPGO38ItlAdKueYrH0w1vYr3IC3
 1mThvV3NswKRJx8iunYthTcMwXtHCP55HR8k3RsqrwFjRP4rS+FRrMTUhQtcVa8wpW7YYfSyM
 j91OEO8tosC/I37jT3s6VtfSrdjry/nYk7bA5QlaBf0BLMy35BEWlkkIPfWMGctrZSdGTg2p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285726>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1586373786-1454847484=:2964
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1602071318201.2964@virtualbox>

Hi Duy,

On Sun, 7 Feb 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Noticed-by: Ole Tange <ole@tange.dk>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  On Sun, Feb 7, 2016 at 4:56 AM, Ole Tange <ole@tange.dk> wrote:
>  > If file name too long it should just try to see if it is a reference
>  > to a revision.
>=20
>  Looks easy enough to fix.

Maybe with a little bit more informative commit message? ;-)

Something like

=09Avoid interpreting too-long parameter as file name

=09Even if it is easier to write HEAD~2000, it is legal to write
=09HEAD^^^... (repeats "^" 2000 times in total). However, such a
=09string is too long to be a legal filename (and on Windows, by
=09default even much, much shorter strings are still illegal
=09because they exceed MAX_PATH).

=09Therefore, if the check_filename() function encounters too long
=09a command-line parameter, it should interpet the error code
=09ENAMETOOLONG as a strong hint that this is not a file name
=09instead of dying with an error message.

=09Noticed-by: ...

What do you think?
Dscho
--8323329-1586373786-1454847484=:2964--
