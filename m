From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: 1e633418479926bc85ed21a4f91c845a3dd3ad66 breaks on OSX
Date: Tue, 05 Oct 2010 14:13:53 -0700
Message-ID: <86iq1g2vhq.fsf@red.stonehenge.com>
References: <86r5g42wo8.fsf@red.stonehenge.com>
	<AANLkTinq7haFRs6h8W+ycDy5MzFgjty6LaD8syL+KnHX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 23:14:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Epj-0006Xz-AL
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 23:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824Ab0JEVNy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 17:13:54 -0400
Received: from red.stonehenge.com ([208.79.95.2]:11303 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760Ab0JEVNx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 17:13:53 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 804072686; Tue,  5 Oct 2010 14:13:53 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.13.12; tzolkin = 2 Eb; haab = 5 Yax
In-Reply-To: <AANLkTinq7haFRs6h8W+ycDy5MzFgjty6LaD8syL+KnHX@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 5 Oct
 2010 21:05:45
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158250>

>>>>> "=C3=86var" =3D=3D =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> writes:

=C3=86var> 1e63341 is a merge commit, and none of the merged things (in=
 the
=C3=86var> commit message) seem to have anything to do with the Perl ma=
kefile
=C3=86var> process.

=C3=86var> Can you run:

=C3=86var>     make -j 1 V=3D1

=C3=86var> And report what output you get?

Oddly enough, just rerunning the make again *worked*.

That's scary.

And therefore also not bisectable. :(

I imagine there's some heisenbug in there, that we'll probably trip ove=
r
later.

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
