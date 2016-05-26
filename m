From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port
 after get_host_and_port
Date: Thu, 26 May 2016 07:35:23 +0200
Message-ID: <57468B1B.4080604@web.de>
References: <20160521231732.4888-1-mh@glandium.org>
 <20160521231732.4888-2-mh@glandium.org>
 <399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
 <20160522080316.GA19790@glandium.org> <574287B9.4090307@web.de>
 <xmqqwpmk797y.fsf@gitster.mtv.corp.google.com> <5743DC2A.6030808@web.de>
 <20160525233403.GA23405@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu May 26 07:36:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5ny1-0003q9-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 07:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbcEZFgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 01:36:11 -0400
Received: from mout.web.de ([212.227.17.12]:52379 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbcEZFgK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 01:36:10 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LqDYi-1bjHZS1t32-00djZk; Thu, 26 May 2016 07:35:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <20160525233403.GA23405@glandium.org>
X-Provags-ID: V03:K0:AO2aNaMmBXOO/YDqzasaI0LEvmnngdodmaSchurbZu/dD7GSNhY
 MroCOOvla0lQ3+NaW7RuXxe88aNQLpDxwUTtqfbYWrMw73AAcH7X4ZN5Y4FN4GugjEdp3vo
 xMhnHdeTaSptJbwQjTD2407r74oW0MKQvd2fOWtG42BxVkY2sN1XwvhrTI0A/tpyqVubMR2
 TjF1v1RrXMrCyC6+nnCAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o7lgn5TGrto=:9/CK/q0aQFxpDiPlK3yI13
 sSXS+i5LxuaiN1/l0k1f3CBzAw2ePw17nOWLKO++Z43wuCzr+ovig0MMQtiYAdQZabcAM3Kf3
 oHKZVc4y2S+gZucCMtmJNR3we/e9hsVJqxOaFNSYD0uqIEoJIgADyC8Pk8zr/CDhVqNwD4nsg
 DQSx5R2NVu4ErfftamhZgIyG/Ffa0fIoEP7Of7zVVSMKNCRb387temgIDfv4tUpOaJEYURWnu
 BEgjq7xuFzjpDlyGOtsKWNydas2YN0U6At8k4IDF6eeq1drr1m90zJTGeB52bkmtDZ10WLDbc
 HSoh99y0RGQDQdsb6q/p3qTQt6xRIOqDu4thKqWLdv6ANCi5GW29JJzIapeBlABsMx7tSm+yf
 tehW7rrHrn1yZ7h7MlLE6DbWy7WwLoqgcpMonR0Apr3yXKDXBsQpnS7n88Oac+FjNbNnHGVAl
 qlXlksD3G0mk8dzxBu7lNkihOVfuIxAkjh8zW4+qJr4eW2MVWVpyWMHKoY8LcmrVC+WfEzgP0
 hAEREZtXgXp5b3MsmwTVG+kRMn2w+WhYd7qnk3pnzCwWtHg2DKH0I9LJONvzeNgXVfaDqO+qK
 JwPj4A114JfG3AzhXYsAKL2wg+bdoe2KhidlBz57f11fGq26waeOMjKAYvdtLmtQkrqCr6rsp
 ariMFsLxd/yZgyGUNflrTsQxV+PdpOo2Wq2U1y5BHwFfdsGP8ry0nR4OcKc5Wp2Wjd1+nJINf
 1a14WJQmDLbSgHW9ieobnMWtf9OvWk/Jk+IteaKHHtOhzr+NhyDPoxyAkJ3xJT5ATL00i+b2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295633>

On 05/26/2016 01:34 AM, Mike Hommey wrote:
> On Tue, May 24, 2016 at 06:44:26AM +0200, Torsten B=F6gershausen wrot=
e:
>> On 05/23/2016 11:30 PM, Junio C Hamano wrote:
>>> Torsten B=F6gershausen <tboegi@web.de> writes:
>>>
>>>>>>>     			get_host_and_port(&ssh_host, &port);
>>>>>>>     +			/* get_host_and_port may not return a port
>>>>>>> even when
>>>>>>> +			 * there is one: In the [host:port]:path case,
>>>>>>> +			 * get_host_and_port is called with "[host:port]" and
>>>>>>> +			 * returns "host:port" and NULL.
>>>>>>> +			 * In that specific case, we still need to split the
>>>>>>> +			 * port. */
>>>>>> Is it worth to mention that this case is "still supported legacy=
" ?
>>>>> If it's worth mentioning anywhere, it seems to me it would start =
with
>>>>> urls.txt?
>>>>>
>>>>> Mike
>>>>>
>>>> I don't know.
>>>> urls.txt is for Git users, and connect.c is for Git developers.
>>>> urls.txt does not mention that Git follows any RFC when parsing th=
e
>>>> URLS', it doesn't claim to be 100% compliant.
>>>> Even if it makes sense to do so, as many user simply expect Git to=
 accept
>>>> RFC compliant URL's, and it makes the development easier, if there=
 is
>>>> an already
>>>> written specification, that describes all the details.
>>>> The parser is not 100% RFC compliant, one example:
>>>> - old-style usgage like "git clone [host:222]:~/path/to/repo are s=
upported
>>> Is it an option to fix get_host_and_port() so that it returns what
>>> the caller expects even when it is given "[host:port]"?  When the
>>> caller passes other forms like "host:port", it expects to get "host=
"
>>> and "port" parsed out into two variables.  Why can't the caller
>>> expect to see the same happen when feeding "[host:port]" to the
>>> function?
>>>
>> This is somewhat out of my head:
>> git clone   git://[example.com:123]:/test        #illegal, malformat=
ed URL
>> git clone   [example.com:123]:/test               #scp-like URL, leg=
acy
>> git clone   ssh://[example.com:123]:/test       #illegal, but suppor=
ted as
>> legacy, because
>> git clone  ssh://[user@::1]/test                       # was the onl=
y way to
>> specify a user name at a literal IPv6 address
>>
>> May be we should have some  more test cases for malformated git:// U=
RLs?
>
> None of these malformed urls are rejected with or without my series
> applied:
>
> Without:
> $ git fetch-pack --diag-url git://[example.com:123]:/test
> Diag: url=3Dgit://[example.com:123]:/test
> Diag: protocol=3Dgit
> Diag: hostandport=3D[example.com:123]:
> Diag: path=3D/test
> $ git fetch-pack --diag-url
> ssh://[example.com:123]:/test
> Diag: url=3Dssh://[example.com:123]:/test
> Diag: protocol=3Dssh
> Diag: userandhost=3Dexample.com
> Diag: port=3D123
> Diag: path=3D/test
>
> With:
> $ git fetch-pack --diag-url git://[example.com:123]:/test
> Diag: url=3Dgit://[example.com:123]:/test
> Diag: protocol=3Dgit
> Diag: user=3DNULL
> Diag: host=3Dexample.com
> Diag: port=3D123
> Diag: path=3D/test
> $ git fetch-pack --diag-url ssh://[example.com:123]:/test
> Diag: url=3Dssh://[example.com:123]:/test
> Diag: protocol=3Dssh
> Diag: user=3DNULL
> Diag: host=3Dexample.com
> Diag: port=3D123
> Diag: path=3D/test
>
> Note in the first case, hostandport is "[example.com:123]:", and that
> is treated as host=3Dexample.com:123 and port=3DNULL further down, so=
 my
> series is changing something here, but arguably, it makes it less wor=
se.
> (note that both with and without my series,
> "git://[example.com:123]:42/path" is treated the same, so only a corn=
er
> case changed)
>
> Can we go forward with the current series (modulo the comment style
> thing Eric noted, and maybe adding a note about the parser handling u=
rls
> as per urls.txt), and not bloat scope it? If anything, the state of t=
he
> code after the series should make further parser changes easier.
>
> Cheers,
>
> Mike
>


Thanks for digging.

How about something like this:

/*
  * get_host_and_port may not return a port in the [host:port]:path cas=
e.
  * To support this undocumented legacy we still need to split the port=
=2E
*/
