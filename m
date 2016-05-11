From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: t5551 hangs ?
Date: Wed, 11 May 2016 22:03:45 +0200
Message-ID: <5f285a5f-f66a-ed35-ecf9-0fece19ee5ca@web.de>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
 <cover.1462863934.git.johannes.schindelin@gmx.de>
 <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
 <db56fae5-799a-29af-3a0f-a7b5c671063a@web.de>
 <20160511173130.GA29731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 11 22:04:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0aMT-0002n4-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 22:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcEKUD5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 16:03:57 -0400
Received: from mout.web.de ([212.227.15.3]:57891 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbcEKUD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 16:03:57 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MP2Sl-1awS1s3Hex-006KWe; Wed, 11 May 2016 22:03:47
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <20160511173130.GA29731@sigill.intra.peff.net>
X-Provags-ID: V03:K0:Tne5XDb+3tIqHXc1FM7sk/qPw0GLn3g1QjJJrh9CDIoF3MInHe3
 2griv3ixITHi18PE9l5Q5w1j5kcHcAUJIM+MT0HSe78c/p3nJhM9BBHHuBa2p1vrjrXz+tc
 L1E4jX+/sIdJasVN0ioJZZ2YPs/z0dgB7VY8EFurCyY0LfVKCmo0pmsJAyvBL9CwdfsxmPj
 sNTUJuhAGQrZPj32sVe4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LmS2dbTHTQE=:tdTO7ZGva8r/rCTQJmSdmP
 gyux93JETsRTSYkwLsDzasGo8Xcl/37EKkN87d0030BAS798+wUt4RRqjsnFaMToXGE/52MIZ
 uSdfOY7P9KCExaO5c8dAMjkPNh2aioLzYJB581GJxxr0hPwvOkZhnS15Cx31+NZYUxHFYdDt3
 x+WJYPzxqmNnVBgikNv6L/ffiGMPNRGWmeGttBg9wBZwC23FQaSgicYlmSsjqpLCZJ8An2+b/
 KegKNJzGo8KlZZmuF9k7ST5a2Jblj5QkQjzYINElAOA55JGZoLKHtKAJ02LN0Rsu78ptdlTNZ
 2ped9rm9dZyf68tdH4cvPIkD90y+Eqf/5ynk/oKHRVps/960lMcW9kTDrl1IK0bNrGcSNB0uq
 F9i+w3WyNBcvjQOjHV7oJeDX68H+ft3SgKVa9voe6Z5PfdnCnam5p9f16rGkFBlIX9i4f7NXJ
 QMg/TrgE+pzqIj/KwCGRKQH9Z8B+4+ohftB6CJ7VeI+tmGivIB25eBofZWdne5GMpmX/8h7GA
 IHFbWJZ4V9ojIcgnANyhOw+QWFcX6WP6x8xotOyM0bPxrBWijHs5iNlODEr/ef35bJMBH9UQ7
 xalO8eqqfGesKslE0QCcLiMeoGBaO2PT/nIM+6dm4HcIPM2acRXqjzyqrN8qf1bIlnFLMNleX
 8jPC/paMNykUC3HSkCjZa+jynKDgem9XQfpRW2wq/0+5mkqOdkwe+Bnss45H5IRPTCD9CSOWW
 BN2pvoHTYp7hu0rHceY8afedbV/Nhqvn9f0C7Fsf236hkaXUNywNnyfWyy8TndtM4nI9QpDq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294361>

On 11.05.16 19:31, Jeff King wrote:
> On Wed, May 11, 2016 at 07:13:56PM +0200, Torsten B=C3=B6gershausen w=
rote:
>=20
>> On 10.05.16 09:08, Johannes Schindelin wrote:
>> - I'm not sure, if this is the right thread to report on -
>>
>> It seems as if t5551 is hanging ?
>> This is the last line from the log:
>> ok 25 - large fetch-pack requests can be split across POSTs
>=20
> Are you running the tests with "--long" or GIT_TEST_LONG in the
> environment? The next line should show it skipping test 26 unless one=
 of
> those is set.
Yes
>=20
> If you are, can you confirm that it's actually hanging, and not just
> slow? On my system, test 26 takes about a minute to run (which is why=
 we
> don't do it by default).
Nearly sure. After 10 minutes, the test was still running.

Yesterday another machine was running even longer.

Any tips, how to debug, are welcome.
