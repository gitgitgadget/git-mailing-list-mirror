From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <poststelle@suesserott.de>
Subject: Re: git-am with an initial checkin doesn't work
Date: Wed, 15 Jul 2009 16:46:36 +0200
Message-ID: <4A5DEBCC.9060600@suesserott.de>
References: <4A5C9C66.1050100@dirk.my1.cc> <7vocrngm2d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 16:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR5rW-0000nH-59
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 16:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbZGOOxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbZGOOxb
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 10:53:31 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:50461 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZGOOxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 10:53:30 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2009 10:53:30 EDT
Received: from [84.176.68.208] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <poststelle@suesserott.de>)
	id 1MR5kj-0005zI-Jz; Wed, 15 Jul 2009 16:46:38 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <7vocrngm2d.fsf@alter.siamese.dyndns.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123318>

Am 14.07.2009 20:24 schrieb Junio C Hamano:
> Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:
>=20
>> # Try to "import" the patch:
>> git am 0001-initial-checkin.patch
>>
>> The latter yields to
>> fatal: HEAD: not a valid SHA1
>> fatal: bad revision 'HEAD'
>>
>> It works, when I
>> git apply 0001-initial-checkin.patch
>> instead of am'ing it, but then the thing isn't committed and I've to
>> manually git-commit it.
>>
>> Is this a bug, intentional behavior, or am I missing some magic opti=
on
>> to git-am?
>=20
> The original mode of operation of the e-mail patchflow commands was t=
o
> support project members who contribute changes to _existing_ projects=
, and
> maintainers to accept such changes.  The reason behind the behaviour =
you
> are observing is merely a historical accident that nobody bothered ab=
out
> use cases outside of that original purpose.  For exactly the same rea=
son,
> the original implementation of format-patch did not bother with the r=
oot
> commit.
>=20
> IOW, this was not an intentional behaviour, neither it was a bug.  It=
 was
> simply use outside of spec, and nobody bothered until f79d4c8 (git-am=
:
> teach git-am to apply a patch to an unborn branch, 2009-04-10), which=
 is
> v1.6.3-rc1~11^2, added a support for it.
>=20
> What version of git are you running?
>=20
>=20

Hi Junio,

I used "1.6.1.9.g97c34" which is an msysGit release and not exactly the=
=20
latest. I now updated to "1.6.3.2.1299.gee46c" and the problem=20
dissapeared. Thanks for the hint and sorry for the noise.

     -- Dirk
