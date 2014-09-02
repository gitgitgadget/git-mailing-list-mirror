From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 2/2] MinGW: Update tests to handle a native eol of
 crlf
Date: Tue, 02 Sep 2014 21:53:54 +0200
Message-ID: <54062052.3070106@web.de>
References: <5402447B.3080700@web.de> <xmqq1trt25zt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:54:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOu9Z-00065W-Vo
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 21:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbaIBTyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 15:54:00 -0400
Received: from mout.web.de ([212.227.15.4]:64545 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830AbaIBTx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 15:53:58 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MYO5B-1Xu1vX1e3V-00VAKb; Tue, 02 Sep 2014 21:53:54
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq1trt25zt.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:0QMcRj3QchvWc2P8dBKxeJVLhs3OnAbhODhct7UEyR2Osoqxd1W
 6xX2ZeCoZ7q4wULOOmdJo3Rs1N8UBnq1bsrq0hBG9wCbIADTxt+Gj1R0QDCzWKtlYctZYc9
 Q/HZNfGDJpZD+armntQofdl+5yRSv0Rrz+9QIgZ8mt4TgYcLi6L+hszGeYJeCS/0YB1ZlWT
 U4nrL+f9ZclHmKqhIwc7A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256343>

On 2014-09-02 21.10, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Integrate commit b1d07649588102 from msysgit:
>>   MinGW: Update tests to handle a native eol of crlf
>>
>>   Some of the tests were written with the assumption that the native=
 eol would
>>   always be lf. After defining NATIVE_CRLF on MinGW, these tests beg=
an failing.
>>   This change will update the tests to also handle a native eol of c=
rlf.
>>
>>   Signed-off-by: Brice Lambson <bricelam@live.com>
>>
>> On top of that, fix the broken && chain in t0026
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>=20
> Should this be marked with "From: Brice Lambson <bricelam@live.com>"?
>=20
> Thanks.
Yes. If possible please squeeze.
