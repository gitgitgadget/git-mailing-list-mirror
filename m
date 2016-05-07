From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: t6044 broken on pu
Date: Sat, 7 May 2016 18:18:30 +0200
Message-ID: <d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
 <878tzmrrfg.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: newren@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 07 18:21:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az4wA-0001tI-Oq
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 18:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbcEGQSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2016 12:18:35 -0400
Received: from mout.web.de ([212.227.15.3]:64822 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbcEGQSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 12:18:34 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LmuQW-1bZV990LHg-00h3By; Sat, 07 May 2016 18:18:31
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <878tzmrrfg.fsf@linux-m68k.org>
X-Provags-ID: V03:K0:cMdwTxSZ+tWsyj6HDalO/GEg89uUdmQJpiAHC95JpKmQ6jtxjQR
 6sHgWFNRs5gzCU5/U93Zl9v/jZGef0es61YTEWgFJ5ngl+ylVqzToB33aojOdVeoS65/nkc
 hBx2kWPc6B5zXTmAdAOPixGSpSONuPi7N0FLZKZXrikYaptZWudXBaCcWlrmGYFLvAURYVB
 F1KeMXk/9l+So8UCQhZDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aFfBVqsXyHk=:PQG6JaPAMlnmAoK8zupVRc
 K36XzB6NBD+G8GIicmGOWMC5gnLMVT5TMq/bbEILz+FZpsNLLbmk1vcX62FOnGt0wlb+/i07P
 UewoisuR0wTRKJRqNRxBY3uYP90IoCMJks/IunQbAk9vH0UDXgS9gET32iqoDpDjk5d/HPl/w
 ns20g9lGqn10PfYEKlLnVpr2vtqDGlKrdt2PWflexessqDf5LH9YIQCYVVtxZSREQk6ANzgt4
 71rwe3nYhRcnLSdWK3SbUWkif3f5rgG9bJumYpQtg+elgAkL7arg9FhUabsB7dMpckr37gT+F
 WlHaWI6RnVybS7WCcE94mCv9Sl3QK2E9rNPQgEEYvkvivBr2+ASKjyJPYkCW7FNDGhHkEnz+u
 z44y5UtxUgvR13T9S3IiyfmkzATY4SG6ICPBTRYTkzPCkutmhOuAMOB1iFxDznLIzoFLED+GR
 9yDWkVHnEM24E8duCEBv+uWYs6wfOOaoGoJKhSfyx4N4UCpZLQlPdA6aUMoxRHB2RU2VECR1e
 OfvwMnvAWVQKKzuSrE9Vikz39Cyj0Qv4dCR0hRXYZxRFnOh+7Qnlzbm/h3DGSRMpSesQJHbqR
 LBaVrf9Z0a4lOhYTzb87yiQy5OE99yd8W4lfqgLyHYv3R64lMlTMSHNlDBmOt+FXOY7VwDJN1
 pHCrme3dvd1maFVmW/qP4QSZDhpifllwwwFcyra4peitLa+7H+adSB8pG5n8ndDIyCkJ9fECl
 Cx6rByo1QMIhy+8boSGucPZkMP9Z4vpaLohjH6QNK3xbCzSqMbXOxd7rczjkxnqTKBtU2vPL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293902>

On 2016-05-07 14.19, Andreas Schwab wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> The "seq" is not understood by all shells,
>> using printf fixes this,
>>
>> index 20a3ffe..48d964e 100755
>> --- a/t/t6044-merge-unrelated-index-changes.sh
>> +++ b/t/t6044-merge-unrelated-index-changes.sh
>> @@ -20,7 +20,7 @@ test_description=3D"merges with unrelated index ch=
anges"
>>  #   Commit E: renames a->subdir/a, adds subdir/e
>>
>>  test_expect_success 'setup trivial merges' '
>> -       seq 1 10 >a &&
>> +       printf 1 2 3 4 5 7 8 9 10 >a &&
>=20
> $ printf 1 2 3 4 5 7 8 9 10
> 1

That's true, but the test passes anyway.
So do we need the sequence ?
Is there something that can be improved in the test ?
