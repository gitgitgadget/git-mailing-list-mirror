From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Fri, 18 Mar 2016 11:14:34 +0900
Message-ID: <56EB648A.2050802@f2.dion.ne.jp>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net> <56D333F1.9050905@web.de>
 <20160315015954.GB25295@dcvr.yhbt.net> <56E79C54.8000606@web.de>
 <20160315070930.GA24036@dcvr.yhbt.net> <56E999C3.4040802@f2.dion.ne.jp>
 <56EA3DBD.2070105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 03:21:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agk2g-0007Pj-88
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 03:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbcCRCVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 22:21:31 -0400
Received: from mail-ae2-f136.auone-net.jp ([111.87.219.136]:47337 "EHLO
	dmta03.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752550AbcCRCV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 22:21:29 -0400
Received: from amlmta056.auone-net.jp (amlmta056-MM [10.188.23.167])
	by dmta03.auone-net.jp (au one net mail) with ESMTP id 6CFBADA09AA
	for <git@vger.kernel.org>; Fri, 18 Mar 2016 11:16:58 +0900 (JST)
Received: from [0.0.0.0] ([65.19.167.130])
	by amlmta056.auone-net.jp id 56eb6516000e76180000232300004d2194000bbb51a2;
	Fri, 18 Mar 2016 11:16:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <56EA3DBD.2070105@web.de>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289178>

On 2016/03/17 14:16 +0900, Torsten B=C3=B6gershausen wrote:
> On 2016-03-16 18.37, Kazutoshi Satoda wrote:
>> "funcky" looks a typo.
>>=20
>>>>     Don't use funky file names, that can not be created under
>>>>     HFS or NTFS.
>>=20
>> The file can be created on my Cygnus environment, which is under FON=
TS.
>> So it looks a bit inaccurate.

Uh, ... I noticed that I wrongly instruct the spell checker...

The above was meant to be:

  The file can be created on my Cygwin environment, which is under NTFS=
=2E
  So it looks a bit inaccurate.

>>>> -       neq=3D$(printf "\201\202") &&
>>>> -       git config svn.pathnameencoding cp932 &&
>>>> +       neq=3D$(printf "\303\244") &&
>>>> +       git config svn.pathnameencoding ISO8859-1 &&
>>=20
>> The variable name "new" was for "NOT EQUAL TO" (0x8182 in cp932 =3D =
U+2260).
>> http://unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP932.TXT

Here "new" was meant to be "neq", of course.


Sorry for the confusion.

--=20
k_satoda
