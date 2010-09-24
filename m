From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 07:07:16 -0700
Message-ID: <86lj6rutez.fsf@red.stonehenge.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
	<86pqw3uuba.fsf@red.stonehenge.com>
	<AANLkTikLYjKHyYOqiubygOD6nWO-FUS38dLALnx3iJ_8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, Tait <git.git@t41t.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 16:11:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz8za-0008S6-N3
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 16:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab0IXOHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 10:07:18 -0400
Received: from red.stonehenge.com ([208.79.95.2]:48116 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0IXOHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 10:07:17 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id E2CE251A7; Fri, 24 Sep 2010 07:07:16 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.13.1; tzolkin = 4 Imix; haab = 14 Chen
In-Reply-To: <AANLkTikLYjKHyYOqiubygOD6nWO-FUS38dLALnx3iJ_8@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 24 Sep
 2010 14:04:08
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156992>

>>>>> "=C3=86var" =3D=3D =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> writes:

=C3=86var> Right, except that should be `use 5.008`. Since you don't wa=
nt to run
=C3=86var> anything else within an implicit or explicit BEGIN block bef=
ore perl
=C3=86var> fails on that. E.g. `require 5.008; use Digest::MD5;` would =
just spew
=C3=86var> an error about Digest::MD5.

=46airy 'nuff.

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discus=
sion
