From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Thu, 07 Feb 2013 18:25:53 +0000
Message-ID: <5113F1B1.3010102@ramsay1.demon.co.uk>
References: <201301271557.08994.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3WBi-0003XT-1w
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 19:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046Ab3BGS0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 13:26:46 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:39141 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161000Ab3BGS0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 13:26:45 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id BB5774006BB;
	Thu,  7 Feb 2013 18:26:43 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 06C7F400607;	Thu,  7 Feb 2013 18:26:43 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Thu,  7 Feb 2013 18:26:42 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <201301271557.08994.tboegi@web.de>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215708>

Torsten B=C3=B6gershausen wrote:
> t0070 and t1301 fail when running the test suite under cygwin.
> Skip the failing tests by unsetting POSIXPERM.

t1301 does not fail for me. (WIN XP (SP3) on NTFS)
[It's so long since I looked, but I'm pretty sure that the failure
in t0070 is caused by *git*, not by cygwin not supporting POSIXPERM]

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/test-lib.sh | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1a6c4ab..94b097e 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -669,7 +669,6 @@ case $(uname -s) in
>  	test_set_prereq SED_STRIPS_CR
>  	;;
>  *CYGWIN*)
> -	test_set_prereq POSIXPERM
>  	test_set_prereq EXECKEEPSPID
>  	test_set_prereq NOT_MINGW
>  	test_set_prereq SED_STRIPS_CR
>=20

So, I'm not in favour of this, FWIW.

ATB,
Ramsay Jones
