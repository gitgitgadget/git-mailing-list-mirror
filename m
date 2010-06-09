From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 09 Jun 2010 09:09:48 +0200
Message-ID: <4C0F3E3C.3090007@web.de>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>	<201006080912.31448.johan@herland.net>	<4C0E6A8A.70608@web.de>	<7vbpblruj8.fsf@alter.siamese.dyndns.org> <AANLkTimApr6P0sQ0FQiNkzhFuftOu1e4VefQxUCXpA53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 09:09:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMFQB-0000vm-FH
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 09:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab0FIHJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 03:09:50 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:46944 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab0FIHJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 03:09:50 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id B7821154EEA92;
	Wed,  9 Jun 2010 09:09:48 +0200 (CEST)
Received: from [80.128.93.210] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OMFQ4-0006c7-00; Wed, 09 Jun 2010 09:09:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTimApr6P0sQ0FQiNkzhFuftOu1e4VefQxUCXpA53@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18OExxkbZ1TwUvoAREY7NBEqM1uy7uMbqPHh80K
	QhC4xMFnkKEFKXpcPal+tq3ndojcNxiaI+Ip5IFtTMTGSemq/j
	bZFWSs1L3MtVSSL6hPNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148746>

Am 09.06.2010 01:19, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Tue, Jun 8, 2010 at 23:09, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Wouldn't it be enough to say --ignore-submodules for your day-to-day=
 work,
>> without lying in the gitlink entry in the superproject tree?  An ent=
ry
>> "submodule.foo.branch =3D fred" in your .gitmodules will still tell =
your
>> local git to update the submodule worktree to work on 'fred' branch.=
  At
>> least, an arrangement like that would allow the build infrastructure=
 to
>> use --no-ignore-submodules when running its equivalent of GIT-VERSIO=
N-GEN
>> to notice that what you are building is using something different fr=
om
>> what the superproject specified to use in the submodule, while not b=
ugging
>> you with differences you do not care about (or you already know abou=
t and
>> are irrelevant to the change you are working on).
>=20
> Yes I think that's even better, to have no entry in the superproject'=
s
> tree at all, and just a repo/branch pair in .gitmodules.

Thats not how I understood Junio proposal, but an alternative to using
0{40} could be to just drop the submodule entry from the tree. You get =
the
same result, but maybe less problems with older versions of git.


> Less confusion and the same features.

Not knowing the version of a submodule looks to me like a very powerful
source of confusion, but maybe thats just me ;-)
