From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/t9700/test.pl: don't access private object members,
 use 	public access methods
Date: Tue, 29 Jun 2010 08:21:00 -0500
Message-ID: <9GBPdCANIkJqMOijhTovNxubG4uDjhkPBiOv42hdrzS-K6oLSFiVLg@cipher.nrlssc.navy.mil>
References: <OYRSzEHOHSti8exa5KJzWIUEyJ8xb2sfcvm4pUcvYhBXldZMw8JzP6a6cRcRRIZjiOtW9kzmnVA@cipher.nrlssc.navy.mil> <AANLkTik3L7VcjezVK_8PCKsSpNFaTfYNvsOAgckhv-6K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 15:25:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTaoW-0006kS-PP
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 15:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0F2NZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 09:25:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38509 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0F2NZP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 09:25:15 -0400
Received: by mail.nrlssc.navy.mil id o5TDL0po002288; Tue, 29 Jun 2010 08:21:01 -0500
In-Reply-To: <AANLkTik3L7VcjezVK_8PCKsSpNFaTfYNvsOAgckhv-6K@mail.gmail.com>
X-OriginalArrivalTime: 29 Jun 2010 13:21:00.0774 (UTC) FILETIME=[EAD36060:01CB178D]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149904>

On 06/28/2010 09:19 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jun 28, 2010 at 22:51, Brandon Casey <casey@nrlssc.navy.mil> =
wrote:
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> This test is accessing private object members of the Test::More and
>> Test::Builder objects.  Older versions of Test::More did not impleme=
nt
>> these variables using a hash.
>>
>> My system complains as follows:
>>
>>   Can't coerce array into hash at <snip>/t/t9700/test.pl line 13.
>>   BEGIN failed--compilation aborted at <snip>/t/t9700/test.pl line 1=
5.
>=20
> Just for the record, what version of Test::More is that:
>=20
>     perl -MTest::More -le 'print $Test::More::VERSION'

0.47 which is available on RHEL 4.X

>> There are public access methods available for retrieving and setting=
 these
>> variables, so let's use them instead.
>>
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>=20
> This looks good, sorry for the API mistake on my part.

No problem.

-brandon
