From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port
 after get_host_and_port
Date: Tue, 24 May 2016 06:44:26 +0200
Message-ID: <5743DC2A.6030808@web.de>
References: <20160521231732.4888-1-mh@glandium.org>
 <20160521231732.4888-2-mh@glandium.org>
 <399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
 <20160522080316.GA19790@glandium.org> <574287B9.4090307@web.de>
 <xmqqwpmk797y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 24 06:44:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b54D7-0007GH-MV
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 06:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbcEXEot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 00:44:49 -0400
Received: from mout.web.de ([212.227.17.12]:61815 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbcEXEos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 00:44:48 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MfYrH-1at9SY3Q4J-00P4Pf; Tue, 24 May 2016 06:44:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqwpmk797y.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:KD+CNRO/Rd56OMkIdBCYtimp9Ceoz8JG++LYBeftvzRMvFMjDyj
 vO6chUzRBEQz8JvV0t6jn6JvKqhmDWMjvfQNlibhZxTzo5sQcUapCyMx/BYnE8W4xwd+ZOT
 zI31hsEOpMK8wJvThRTKOpQPTypWHv9se6wsBfeVpSw8Qf1E8DArpUjk5ndE6AoVTVOE1IP
 BxDoTyJh+Vh62gwVR8beA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q+gqQwybz/Q=:9mNHiMEgQZZMSE0xHLuUsS
 vPiHxssf2St+z72ydsdAob3tU4bmpczKGjZUoagy0Fyj4r4jzYSu6cj/GGRez6L1Utm9TL892
 NAz8d/Xrv+ROb368LWjx404gIOD/LzkumzNIBH76bQPBGh4JZo7CGIZzVpnEe4txgkBwSdTrD
 idSsU08Bh55PCy6XWV+JBbeXii/JEcnT6j5CXKO2ELipGB+h2M+Hs6Zv1Z6FJvVGfru1xRyve
 O/3VdJSTy9nmPijYPr+foFmVsJgxLuYjbwz/ZK9R3HPtwGLg+/00e3/1VTyFJuiLmZ0+V7DPc
 C75oC3O06Xf1KZY9ntrC8QqnjRpmE5oSMUDxqZ+1+0E1CUruOdmIY4K6u4NIqE74MSGMtlRux
 papkhJCR5I9ztJ5+rebWFioiNWaCBSnKTLrH2BXNnwO74siUjfCdYa1404CvyFJBBKDSiq24P
 FAB+8auXvd98HMmbUITBqnimuLjJBC4zfnCtlViBXB8rZ/S/xXDNaq+Wtp31lfcgGuQlpyjEB
 pqB2vJh2ulgr+ZMeD+vx8dlE/DLrB8/+yfXiJwCzgpufNINkvFXejO8TGSSQMyIow7acJGXOu
 OTC+ku8ORc5njE7+e9kwggr5ii9aRluITLn0DZ+hjc6dJYU9GyvD+LBM5XSiHFdWmHMMB0UpG
 9i+2XbKmiadB3hFdbDBTA4saJqJ/QVqasb7bt+MyaH+4KZfA9Uv7KoXTMDkYXGIfjC7O2S8/5
 cOrwoU4UiJJxoM5L1EwECfOeXX49PgCrGY5ctlTruujXRCwKOn/BgrDpNDla9ancS7BjbrWm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295415>

On 05/23/2016 11:30 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>>>>>    			get_host_and_port(&ssh_host, &port);
>>>>>    +			/* get_host_and_port may not return a port
>>>>> even when
>>>>> +			 * there is one: In the [host:port]:path case,
>>>>> +			 * get_host_and_port is called with "[host:port]" and
>>>>> +			 * returns "host:port" and NULL.
>>>>> +			 * In that specific case, we still need to split the
>>>>> +			 * port. */
>>>> Is it worth to mention that this case is "still supported legacy" =
?
>>> If it's worth mentioning anywhere, it seems to me it would start wi=
th
>>> urls.txt?
>>>
>>> Mike
>>>
>> I don't know.
>> urls.txt is for Git users, and connect.c is for Git developers.
>> urls.txt does not mention that Git follows any RFC when parsing the
>> URLS', it doesn't claim to be 100% compliant.
>> Even if it makes sense to do so, as many user simply expect Git to a=
ccept
>> RFC compliant URL's, and it makes the development easier, if there i=
s
>> an already
>> written specification, that describes all the details.
>> The parser is not 100% RFC compliant, one example:
>> - old-style usgage like "git clone [host:222]:~/path/to/repo are sup=
ported
> Is it an option to fix get_host_and_port() so that it returns what
> the caller expects even when it is given "[host:port]"?  When the
> caller passes other forms like "host:port", it expects to get "host"
> and "port" parsed out into two variables.  Why can't the caller
> expect to see the same happen when feeding "[host:port]" to the
> function?
>
This is somewhat out of my head:
git clone   git://[example.com:123]:/test        #illegal, malformated =
URL
git clone   [example.com:123]:/test               #scp-like URL, legacy
git clone   ssh://[example.com:123]:/test       #illegal, but supported=
=20
as legacy, because
git clone  ssh://[user@::1]/test                       # was the only=20
way to specify a user name at a literal IPv6 address

May be we should have some  more test cases for malformated git:// URLs=
?
