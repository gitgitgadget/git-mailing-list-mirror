From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-archive documentation: .gitattributes must be committed
Date: Wed, 10 Feb 2010 21:00:03 +0100
Message-ID: <4B731043.6010108@lsrfire.ath.cx>
References: <1265770284-14830-1-git-send-email-fmarier@gmail.com> <4B7303FC.6070701@lsrfire.ath.cx> <7v1vgsao21.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francois Marier <fmarier@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfIjR-0007CD-AO
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab0BJUAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 15:00:10 -0500
Received: from india601.server4you.de ([85.25.151.105]:45730 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0BJUAI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 15:00:08 -0500
Received: from [10.0.1.100] (p57B7D89D.dip.t-dialin.net [87.183.216.157])
	by india601.server4you.de (Postfix) with ESMTPSA id 006A22F804E;
	Wed, 10 Feb 2010 21:00:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <7v1vgsao21.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139541>

Am 10.02.2010 20:27, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>>> +The .gitattributes file must be present in the named tree for it t=
o take
>>> +effect. Uncommitted attributes will not be considered in exports.
>>> +
>>>  EXAMPLES
>>>  --------
>>>  git archive --format=3Dtar --prefix=3Djunk/ HEAD | (cd /var/tmp/ &=
& tar xf -)::
>>
>> Yeah, the description of --worktree-attributes is a bit terse.  The
>> lines you add make it appear almost as if this switch doesn't exist,
>> though; perhaps add a "unless --worktree-attributes is given" or sim=
ilar
>> to one of the new sentences?
>=20
> My impression has always been that people use attributes with archive=
 more
> often to _tweak_ how the archive is produced after the fact, and they=
 do
> so by modifying checked out .gitattributes (or $GIT_DIR/info/attribut=
es)
> than allowing a possibly stale .gitattributes file etched in stone^Wt=
ree
> being archived.  So in that sense, probably --worktree-attributes sho=
uld
> have been the default.

That was the case up to ba053ea9 (April 2009, archive: do not read
=2Egitattributes in working directory).  I think that the current
behaviour makes sense because it provides a repeatable default.

Ren=C3=A9
