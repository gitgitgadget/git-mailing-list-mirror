From: <nolan.ring@emc.com>
Subject: RE: svn2git question: error: unknown switch `t'
Date: Tue, 21 Sep 2010 08:08:30 -0400
Message-ID: <4E10ACF241081344B9702AA8C6440440C5B14FB34F@MX01A.corp.emc.com>
References: <4E10ACF241081344B9702AA8C6440440C5B14FB331@MX01A.corp.emc.com>
	<AANLkTik_ouA-AD+tmGEvvcJeZqVj4Rge=hcoJ5Bqgt-R@mail.gmail.com>
	<4E10ACF241081344B9702AA8C6440440C5B14FB337@MX01A.corp.emc.com>,<AANLkTi=X3NqcURV8GSmZiq5CbVwikFF5skFt_t6gkSp9@mail.gmail.com>,<4E10ACF241081344B9702AA8C6440440C5B14FB33A@MX01A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 14:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy1ey-0001u2-PE
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 14:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab0IUMJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 08:09:14 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:55316 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab0IUMJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 08:09:13 -0400
Received: from hop04-l1d11-si04.isus.emc.com (HOP04-L1D11-SI04.isus.emc.com [10.254.111.24])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8LC9BIk022512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Sep 2010 08:09:11 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.221.253]) by hop04-l1d11-si04.isus.emc.com (RSA Interceptor); Tue, 21 Sep 2010 08:09:10 -0400
Received: from corpussmtp4.corp.emc.com (corpussmtp4.corp.emc.com [10.254.169.197])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8LC86xX008040;
	Tue, 21 Sep 2010 08:08:36 -0400
Received: from mxhub01.corp.emc.com ([10.254.141.103]) by corpussmtp4.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 21 Sep 2010 08:08:32 -0400
Received: from mxhub03.corp.emc.com (10.254.141.105) by mxhub01.corp.emc.com
 (10.254.141.103) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 21 Sep
 2010 08:08:32 -0400
Received: from MX01A.corp.emc.com ([169.254.1.232]) by mxhub03.corp.emc.com
 ([10.254.141.105]) with mapi; Tue, 21 Sep 2010 08:08:32 -0400
Thread-Topic: svn2git question: error: unknown switch `t'
Thread-Index: ActY+mhWJ7ndjL7aRICKpVnxrFffNQAAUtCjACJGSh0=
In-Reply-To: <4E10ACF241081344B9702AA8C6440440C5B14FB33A@MX01A.corp.emc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 21 Sep 2010 12:08:32.0760 (UTC) FILETIME=[B5E81780:01CB5985]
X-EMM-MHVC: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156717>

At this point I feel like I'm chasing my tail.=20

I upgraded git and then started trying to upgrade other software that s=
vn2git requires.  It's been all downhill!

I found rpm 5.2.1 and tried installing it but needed popt.  I found pop=
t and installed it but now need beecrpypt because Python.h is missing. =
 It looks like I need beecrypt but I *can't* find an appropriate beecry=
pt for Suse 11.

/bin/sh ../libtool --tag=3DCC   --mode=3Dcompile gcc -m64 -DHAVE_CONFIG=
_H -I. -I.. -I. -I../include -I/usr/include/python2.6  -I/re/thirdparty=
_tools/java/linux/jdk1.6.0_02/jre/../include -I/re/thirdparty_tools/jav=
a/linux/jdk1.6.0_02/jre/../include/linux -DOPTIMIZE_X86_64  -O2 -DNDEBU=
G -Wa,--noexecstack -c -o _bc-py.lo _bc-py.c
libtool: compile:  gcc -m64 -DHAVE_CONFIG_H -I. -I.. -I. -I../include -=
I/usr/include/python2.6 -I/re/thirdparty_tools/java/linux/jdk1.6.0_02/j=
re/../include -I/re/thirdparty_tools/java/linux/jdk1.6.0_02/jre/../incl=
ude/linux -DOPTIMIZE_X86_64 -O2 -DNDEBUG -Wa,--noexecstack -c _bc-py.c =
 -fPIC -DPIC -o .libs/_bc-py.o
_bc-py.c:8:20: error: Python.h: No such file or directory
In file included from _bc-py.c:14:
=2E./include/beecrypt/python/mpw-py.h:12: error: expected specifier-qua=
lifier-list before =E2PyObject_HEAD=E2
=2E./include/beecrypt/python/mpw-py.h:20: error: expected =E2=3D=E2, =E2=
,=E2, =E2;=E2, =E2asm=E2 or =E2__attribute__=E2 before =E2mpw_Type=E2

Am I doing something wrong here? =20

Thanks again for any insights.

Nolan

________________________________________
=46rom: git-owner@vger.kernel.org [git-owner@vger.kernel.org] On Behalf=
 Of nolan.ring@emc.com [nolan.ring@emc.com]
Sent: Monday, September 20, 2010 3:40 PM
To: avarab@gmail.com
Cc: git@vger.kernel.org
Subject: RE: svn2git question: error: unknown switch `t'

Thanks for your quick response.

svn2git has alot of pre-requisite software.  Can I just upgrade git and=
 leave the other software at its current version?

Nolan
________________________________________
=46rom: =C6var Arnfj=F6r=F0 Bjarmason [avarab@gmail.com]
Sent: Monday, September 20, 2010 3:30 PM
To: Ring, Nolan
Cc: git@vger.kernel.org
Subject: Re: svn2git question: error: unknown switch `t'

On Mon, Sep 20, 2010 at 19:19,  <nolan.ring@emc.com> wrote:
> Hmmm, guess it wasn't that obvious to me!! :-)
>
> I have 1.6.0.2 installed, which does support the --track option; did =
a later git support -t as well as --track?
>
>> git --version
> git version 1.6.0.2
>
> Is there some way to know what version of git the svn2git I have inst=
alled supports?  And any way to get a version of svn2git that supports =
the one I have.

You should just upgrade Git instead, using an old version of a
conversion tool is generally a Bad Idea.

