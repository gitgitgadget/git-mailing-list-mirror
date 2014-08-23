From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/3] Push the NATIVE_CRLF Makefile variable to C and
 added a test for native.
Date: Sat, 23 Aug 2014 08:22:25 +0200
Message-ID: <53F83321.1060906@web.de>
References: <53F797A1.1060804@web.de> <xmqq61hknnjo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 23 08:22:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL4ig-0003DY-Sc
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 08:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbaHWGW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2014 02:22:29 -0400
Received: from mout.web.de ([212.227.17.11]:64292 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbaHWGW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 02:22:29 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LyUgM-1WIt2i1sPO-015uKS; Sat, 23 Aug 2014 08:22:26
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq61hknnjo.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ojH3eeLJH7Z1252KdVB+Kvu2SMjCEZNL8S074/QM6aSVhWYi6na
 NEJYlcRV5iQNhN37+ygIN6SXK1nkm/dANYb+mTQ1lU1Q7EOOssqZKxSpKmRh7yI5+uLcHi5
 JNV9nIw7LOYWaHQuKh/cLPjlm9g7Dv40/C3MwqWQaR0v+29mT8RcVYo48N97o+D8JuwaaVP
 fno/YtTcME7uEvxZmlKgw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255737>

On 2014-08-23 00.54, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Commit 95f31e9a correctly points out that the NATIVE_CRLF setting is
>> incorrectly set on Mingw git. However, the Makefile variable is not
>> propagated to the C preprocessor and results in no change. This patc=
h
>> pushes the definition to the C code and adds a test to validate that
>> when core.eol as native is crlf, we actually normalize text files to=
 this
>> line ending convention when core.autocrlf is false.
>>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>=20
> Who should I record as the author of this patch?
>=20

Sorry for missing this, here is what Mingw says:=20

commit 0caba2cacbb9d8e6a31783b45f1a13e52dec6ce8
Author: Pat Thoyts <patthoyts@users.sourceforge.net>
Date:   Mon Nov 26 00:24:00 2012 +0000

    Push the NATIVE_CRLF Makefile variable to C and added a test for na=
tive.
   =20
    Commit 95f31e9a correctly points out that the NATIVE_CRLF setting i=
s
[]
