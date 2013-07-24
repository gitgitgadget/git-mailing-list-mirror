From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Wed, 24 Jul 2013 20:03:31 +0100
Message-ID: <51F02503.7030102@ramsay1.demon.co.uk>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org> <51EDBC7D.7060200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 24 21:10:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V24SC-00035Z-6n
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 21:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab3GXTKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 15:10:22 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:53863 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753045Ab3GXTKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 15:10:21 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id F24D9A643C9;
	Wed, 24 Jul 2013 20:10:18 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5EAC0A6454A;
	Wed, 24 Jul 2013 20:10:18 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Wed, 24 Jul 2013 20:10:17 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51EDBC7D.7060200@web.de>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231113>

Torsten B=F6gershausen wrote:
> =20
>> ml/cygwin-updates:
>>      cygwin: stop forcing core.filemode=3Dfalse
>=20
> I like that: cygwin behaves more like Unix/Linux.
>=20
> Just a side-comment: When working on NTFS, cygwin
> will set core.filemode=3Dtrue, and as a result of that,
> the "cheating lstat" code is not used any more.
>=20
> So it is not run under the test suite (typically NTFS),
> and therefore "untested by default".

Indeed, the next branch is now "fixed". :-D

>=20
>> * rj/cygwin-clarify-use-of-cheating-lstat (2013-07-18) 1 commit
>>  - cygwin: Remove the Win32 l/stat() implementation
> =20
>>  I am personally in favor of this simpler solution.  Comments?
> Me too, thanks to all contributors

Thank you for taking the time to help address this issue!

ATB,
Ramsay Jones
