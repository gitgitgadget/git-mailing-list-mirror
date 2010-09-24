From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 06:47:53 -0700
Message-ID: <86pqw3uuba.fsf@red.stonehenge.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, Tait <git.git@t41t.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 15:50:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz8fn-00058D-3h
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 15:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab0IXNrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 09:47:55 -0400
Received: from red.stonehenge.com ([208.79.95.2]:11513 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372Ab0IXNry convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 09:47:54 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 4C010513C; Fri, 24 Sep 2010 06:47:54 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.13.1; tzolkin = 4 Imix; haab = 14 Chen
In-Reply-To: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 24 Sep
 2010 12:56:31
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156988>

>>>>> "=C3=86var" =3D=3D =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> writes:

=C3=86var> Since we're not getting patches for common things that have =
been
=C3=86var> broken on 5.6 for years and bumping the requirenment to an 8=
 year old
=C3=86var> perl (5.8) instead of a 10 year old one (5.6) would make thi=
ngs much
=C3=86var> easier, including:

=C3=86var>  * Fixing the perl/ Makefile mess

=C3=86var>  * Being able to use 5.8 features

=C3=86var>  * Being able to honestly support the 5.8 release, 5.6 doesn=
't even
=C3=86var>    compile on modern systems without undocumented monkeypatc=
hes, and
=C3=86var>    few people use it so we don't get fixes for it.

=C3=86var> I'd like to propose dropping 5.6 support, and move to say 5.=
008. I can
=C3=86var> do the work required to add appropriate docs / use statement=
s and
=C3=86var> fixes to bugs that we can't fix on 5.6.

As the token resident Perl expert, I'd be completely fine with that.
Sane choice.

It might be useful to document that by adding:

  require 5.008;

at the beginning of each file that presumes it, as you get around to
editing it.

That way, Perl won't even try to run it if it's too old.

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discus=
sion
