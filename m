From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -i: do not leave a =?UTF-8?Q?CHERRY=5FPICK?=
 =?UTF-8?Q?=5FHEAD=20file=20behind?=
Date: Wed, 17 Jun 2015 17:24:44 +0200
Organization: gmx
Message-ID: <d8b9c3f3376817962207b9c3f16c7d01@www.dscho.org>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
 <cover.1434528725.git.johannes.schindelin@gmx.de>
 <2751d249ba6315f0139ba8fd6aa6ff23c32c9e69.1434528725.git.johannes.schindelin@gmx.de>
 <20150617145814.Horde.VFmyWwlQfspzMMXX3ZuSlQ4@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:25:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5FCy-00082M-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 17:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbbFQPYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 11:24:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:50757 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116AbbFQPYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 11:24:50 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lm34j-1YVdL228xd-00Zifk; Wed, 17 Jun 2015 17:24:45
 +0200
In-Reply-To: <20150617145814.Horde.VFmyWwlQfspzMMXX3ZuSlQ4@webmail.informatik.kit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:jpC0SMdHWmFk9R7kB4nXsOX8HWq1X22vO/4YWgrF0L0qWu48tRJ
 vFuOfSWW8O32hOcPzlWPeZyWSsVPZz1gNO17zuAFKs+T0WXIsK1XecuQaZjR2Ix1GRIf8o4
 +OGQ38SfYwonbdcJTk15/SMgFOhPy4p8ToOsM8iKJ+wQ1hiFgPuVlYsMcH3Mj9+R0FNAaS+
 LOLTOu20gE2eDBfAs/kzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/LHke8aqm8s=:e4a3gbiXJJ6S2BywRBX5W8
 KsbzS0LEqs/J3orM4Ph9VvUSv7QD5K/mXORxpAZdL7UWVHVcMncCDRcqETivu9+Sxj3MfQ6DY
 ypiuZDYMJ8AuIll0G+u/IaiSWSIlDAwLCzGCd1sfOuhjr48037EpySOBWsEVyW4t+LuFWEkQw
 P7FYu+J7o2U+bOTCyHFiL0hmQdwX+DW/kZRoeF8ApfaYzuPhsM8+zkjlk2XElaKzRvOortiFZ
 yfbwA7z9iHZD3A/+VoXGaPYiQGRiE8A4R9lAAlxPeX+lInYFNR56gipxldkyQ+YAw/y/KkvHe
 SEM4EpO5pJkZR5mD/XDbN9YmBCNo4vxFRORdkDJ5G2qHVRdr4xzYyebx7goOjrSpheXvzZulB
 5gdMm+5KD32hFrmPn00882AlbZfk/aJDhpOpGkcKyuXCkPTO8DNjeVpN1IvFfJzRWQYol817I
 CCAPm/+n0/iXKfj7zApBh6M1yO012t/AsrExw+GoNLqlYwjFPgXIbJEBWNif5NJECE7HZft3y
 e/lhr6SrSUsu+ptBqMImADSRB9j4QyHCxQRKaHJLiSWXu4syVPB612f3WNH5Kuz6G9iZkgq/c
 Tqz02Q3DCDX8nRfX/hsHG76Er2Ed1gw3qM+CFbJ1fype0iRub/txyrf8ecFVYbiluZ6qFuMuB
 bREM9KskwFtCgQszj6gIr+8jH5oi1jN1TEYytVFA1WFzjDG8iKMYP3cP0OyAVdwyLtdY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271856>

Hi,

On 2015-06-17 14:58, SZEDER G=C3=A1bor wrote:

> Quoting Johannes Schindelin <johannes.schindelin@gmx.de>:
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index dc3133f..16e0a82 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -849,7 +849,11 @@ continue)
>>  	# do we have anything to commit?
>>  	if git diff-index --cached --quiet HEAD --
>>  	then
>> -		: Nothing to commit -- skip this
>> +		: Nothing to commit -- skip this commit
>=20
> "While at it", perhaps you could turn this into a proper comment with=
 '#".
> Now that this if-branch starts to actually do something, there's no=20
> reason to continue (ab)using the null command.

Sure thing. I'll wait if there are more comments and then send out v2.

Ciao,
Johannes
