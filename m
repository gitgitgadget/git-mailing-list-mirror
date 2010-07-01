From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Test 17 of `t9119-git-svn-info.sh' fails with svn 1.6.9
Date: Thu, 01 Jul 2010 11:48:47 +0200
Message-ID: <4C2C647F.7090909@drmicha.warpmail.net>
References: <8739w3fupp.fsf@ft.bewatermyfriend.org>	<4C2C5D2F.90000@drmicha.warpmail.net> <87y6dveekn.fsf@ft.bewatermyfriend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Eric Wong <normalperson@yhbt.net>
To: Frank Terbeck <ft@bewatermyfriend.org>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:49:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUGOt-0002kF-1O
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab0GAJti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 05:49:38 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60145 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751927Ab0GAJth (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 05:49:37 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DA38B10BF16;
	Thu,  1 Jul 2010 05:49:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 01 Jul 2010 05:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Ybrb2mHNhVJVIg/KLQ/4jM5gBkw=; b=B2xTfAqlHBIqhl6s6XQ/rg21/tBSEEJY+7DRnCH7mAiCh3V2RjcG3DyQJ/TOZQKnlwP3GR23/JDTDQd0h16jIJ6CWF95d924A1HVr7zsTBs2yUiU81NTrClZP080Dx6OLlXRvPxKaJH3W6P06oVcCNCx0pbo+caB2OHYKbiKIfA=
X-Sasl-enc: 4IaWA9sr2lGpRNe17UFLtrHdsZYFzU1WXUwGy35emIpq 1277977776
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 138DE4D3F6E;
	Thu,  1 Jul 2010 05:49:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <87y6dveekn.fsf@ft.bewatermyfriend.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150022>

=46rank Terbeck venit, vidit, dixit 01.07.2010 11:28:
> Michael J Gruber wrote:
>> Frank Terbeck venit, vidit, dixit 01.07.2010 10:54:
>>> [snip]
>>> *   ok 16: info --url added-file
>>> * FAIL 17: info added-directory
> [...]
>>> *   ok 18: info --url added-directory
>>> [...]
>>> * failed 1 among 38 test(s)
>>> make[2]: *** [t9119-git-svn-info.sh] Error 1
>>> [snap]
> [...]
>>> Anyway, my svn version is "svn, version 1.6.9 (r901367)". The test =
suite
>>> I ran is from yesterdays git master branch. If it matters, this is =
a
>>> Linux box running a debian 2.6.26-2-686 kernel; the file system in
>>> question is `ext3' being mounted `noatime'.
>>
>> It works for me with the exact same svn version on Fedora 13.
>>
>> Please run the test like that:
>> cd t
>> ./t9119-git-svn-info.sh -i
>>
>> This stop immediately after the failed test. Then, please tell us th=
e
>> contents of the actual.. and expected... files in the trash... subdi=
r.
>=20
> Okay.
>=20
> expected.info-added-directory:
> [snip]
> Path: added-directory
> URL: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/s=
vnrepo/added-directory
> Repository Root: file:///usr/src/sys/git/t/trash%20directory.t9119-gi=
t-svn-info/svnrepo
> Repository UUID: 638d0b70-c7df-46bd-9c56-aff8052b4ab8
> Revision: 0
> Node Kind: directory
> Schedule: add
> [snap]
>=20
> actual.info-added-directory:
> [snip]
> Path: added-directory
> URL: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/s=
vnrepo/added-directory
> Repository Root: file:///usr/src/sys/git/t/trash%20directory.t9119-gi=
t-svn-info/svnrepo
> Revision: 0
> Node Kind: directory
> Schedule: add
> [snap]
>=20
> And a unified diff of the two:
> [snip]
> --- trash directory.t9119-git-svn-info/actual.info-added-directory 20=
10-07-01 11:22:16.000000000 +0200
> +++ trash directory.t9119-git-svn-info/expected.info-added-directory =
2010-07-01 11:22:16.000000000 +0200
> @@ -1,6 +1,7 @@
>  Path: added-directory
>  URL: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-info/=
svnrepo/added-directory
>  Repository Root: file:///usr/src/sys/git/t/trash%20directory.t9119-g=
it-svn-info/svnrepo
> +Repository UUID: 638d0b70-c7df-46bd-9c56-aff8052b4ab8

"Nachtigall, ick h=F6r Dir trapsen." [I really don't know how to transl=
ate
this...]

Anyway, this is something I had fixed previously before realizing it
doesn't need a fix and something else is wrong:

It indicates that Git's svn-bindings (git-svn) use a different svn
version than the actual "svn". (There used to be a bug where Git was
wrong about the version of the bindings but that is fixed.)

Do the following agree for you:

git svn --version
svn --version

Do you have any private copies of svn/svn bindings in your path or perl
path?

>  Revision: 0
>  Node Kind: directory
>  Schedule: add
> [snap]
>=20
> Regards, Frank

Michael
