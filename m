From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH V3 1/4] git-mw: Introduction of GitMediawiki.pm
Date: Tue, 18 Jun 2013 12:54:52 +0200
Message-ID: <vpqa9mnu1s3.fsf@anie.imag.fr>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
	<1371349893-7789-2-git-send-email-benoit.person@ensimag.fr>
	<vpqobb5g679.fsf@anie.imag.fr>
	<CAETqRChcu+N-2uNzL9_J6abR5fnduT5UVRif5NTQYOoxPTiRTw@mail.gmail.com>
	<vpq8v299pn6.fsf@anie.imag.fr>
	<CAETqRCjiMh_cYuZit5Z8OLki_RTz8=ViYPMv005iQu9Fv=U0ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 12:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UotYy-00076c-QE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab3FRKy4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 06:54:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34381 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436Ab3FRKy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:54:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5IAspue017793
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 12:54:51 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UotYq-0008Ny-QR; Tue, 18 Jun 2013 12:54:52 +0200
In-Reply-To: <CAETqRCjiMh_cYuZit5Z8OLki_RTz8=ViYPMv005iQu9Fv=U0ow@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Tue, 18 Jun 2013
 11:06:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Jun 2013 12:54:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228193>

Beno=EEt Person <benoit.person@ensimag.fr> writes:

> On 17 June 2013 09:12, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wr=
ote:
>>>> Also, it seems to be only part of the solution. With your change, =
from
>>>> contrib/mw-to-git/ and after running only "make",
>>>>
>>>> ./git-mw takes the installed version of GitMediawiki.pm in priorit=
y
>>>>
>>>> ../../bin-wrappers/git takes the installed version of git-mw only =
(i.e.
>>>> does not know "git mw" if "make install" hasn't been ran).
>>> Same thing as the documentation point, I think I am a bit lost in t=
hat
>>> whole thing. I will re-look into it for the next version :/ .
>>
>> In short, the include path should contain both the *.pm file and the
>> git-<foo> ones.
> The fact is, for now, is there a way to test changes in
> git-remote-mediawiki.perl without 'make install'-ing it ? I could not=
 find one

You can put contrib/mw-to-git/ in your $PATH, and then run git normally=
=2E

> So maybe in the "build-perl-script" of the toplevel Makefile we could=
 add
> something copying the script at the toplevel ?

I find this a bit dirty, as it polutes the toplevel with untracked file=
s
(that are not in the .gitignore file). But that's what the testsuite
already does (IIRC, it does a symlink), so I'd say it's OK for now.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
