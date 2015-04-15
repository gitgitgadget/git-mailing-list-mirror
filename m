From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 3/3] t0027: Add repoMIX and LF_nul
Date: Wed, 15 Apr 2015 21:58:24 +0200
Message-ID: <552EC2E0.3010705@web.de>
References: <552E9950.9050008@web.de> <c87875cc4da70fc671b40ba637421c94@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git-owner@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?B?VG9yc3Rlbg==?= =?UTF-8?B?IELDtmdlcnNoYXVzZW4=?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 21:58:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiTSD-00011X-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 21:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbbDOT63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2015 15:58:29 -0400
Received: from mout.web.de ([212.227.15.14]:51538 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913AbbDOT62 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 15:58:28 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0M0yjP-1ZVV6c3gsh-00vABb; Wed, 15 Apr 2015 21:58:25
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <c87875cc4da70fc671b40ba637421c94@www.dscho.org>
X-Provags-ID: V03:K0:rZD2Uno3iV9dyaV0T0nCddi0ZaeO1ud7qFwaQ+teugTuHnnXLTk
 bno1A+u8RCBSEafmEvlXhsxPBuoBnyl0+p/a0KAaL/bLBcGUP1JRmRrpc4+Yu8CfpfyFAda
 he/HEZL9m3VTSS+uo/Vaq7JWKwdw1u9go9ZQe0Y+l0ABW0aEfyoACi4i01gVt4VAa6uYEgE
 5KFUlXUIyc+9rirtajLsg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267234>

On 2015-04-15 19.36, Johannes Schindelin wrote:
> Hi Torsten,
>=20
> On 2015-04-15 19:01, Torsten B=C3=B6gershausen wrote:
>=20
>>  t/t0027-auto-crlf.sh | 155 ++++++++++++++++++++++++++++------------=
-----------
>=20
> I fear that we duplicated work here, due to me working on Git for Win=
dows 2.x and you sending mails to the non-Windows mailing list.
>=20
Good to here that this TC is alive, sorry for the breakage.
> For what it is worth, my patches can be viewed here:
>=20
> https://github.com/git-for-windows/git/commits/master/t/t0027-auto-cr=
lf.sh
>=20
> And in particular this one is important:
>=20
> https://github.com/git-for-windows/git/commit/c07cae2576cd3ed193bb766=
959f226a8fac5aa17
>=20
Thanks for the info and the fix.

> It would maybe be a good idea to work together?
Yes, I try to be up-to-date with Git for Windows, but missed to follow =
this very patch.
Do you plan to send it to git.git ?
>=20
> Ciao,
> Johannes
