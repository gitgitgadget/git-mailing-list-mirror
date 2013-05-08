From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Problems with Windows, Was: What's cooking in git.git (May 2013,
 #01; Fri, 3)
Date: Wed, 08 May 2013 17:01:21 +0200
Message-ID: <518A68C1.8010802@web.de>
References: <7vvc6zwta7.fsf@alter.siamese.dyndns.org> <51890F48.3090409@web.de> <51899CBF.2020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 17:01:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua5sF-0008Eh-LX
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 17:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511Ab3EHPBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 May 2013 11:01:39 -0400
Received: from mout.web.de ([212.227.15.3]:57081 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756236Ab3EHPBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 11:01:39 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MDPI5-1UmRms3iyT-00HTb6; Wed, 08 May 2013 17:01:20
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51899CBF.2020805@gmail.com>
X-Provags-ID: V02:K0:pYag1VPZj5xxWnvPeQiBe0OcDU90y8pqxJY/QQWLtk5
 vm4YwFA8GVTQSbVIphG6hnAhYXADtsS/SwrHLKLKwYcgvdVLlp
 VsVVeRfZZQi8NiivPiUKyHMwP74jpTrVbOTPrbbf0LbABywINm
 21CRsBWSZlmOv5kig0aOzs5TPqTp3VDMaejJQP1mIW3erU3zYd
 s/aR6ILKXzrIrhH4fYAtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223671>

On 2013-05-08 02.30, Mark Levedahl wrote:
> On 05/07/2013 10:27 AM, Torsten B=F6gershausen wrote:
>> On 2013-05-04 01.14, Junio C Hamano wrote:
>>>
>>>   Cygwin portability; both were reviewed by Jonathan, and the tip o=
ne
>>>   seems to want a bit further explanation.  Needs positive report
>>>   from Cygwin 1.7 users who have been on 1.7 to make sure it does n=
ot
>>>   regress for them.
>>
>> I was trying to verify that cygwin 1.7 is still Ok, but got puzzled.
>>
>> Running the test suite under cygwin doesn't seem to work any more (?=
):
>>
>> Scenario 1:
>> The PC is running alone, and goes into the screen saver.
>> Pressing CTRL-ALT-DEL didn't get any effect.
>>
>> Scenario 2:
>> The PC didn't react any more, when the test suite was run in backgro=
und.
>> In 3 or 4 cases the PC needed to be reboot hardly.
>>
>> Using the commits before and after this change makes the test suite =
hang
>> as well at some point, then it hangs somewhere at TC 3000--4000.
>>
>> Scenario 4:
>> The I disabled the screensaver, upgdated cygwin,
>>   and went back to an older commit:
>> The latest run from commit 52d63e70, April 28,
>> hangs in TC 5500, ok 26 clone shallow object count.
>>
>> I can see 2 times
>> git.exe pull --depth 4 ..A
>>
>> Scenario 5:
>> The run of today 1.8.3-rc1, hangs in t5510,
>> some git.exe are running fetch. (or pull)
>>
>>
>> It seems as if some process/exes are not terminated
>> in the way it should be.
>>
>> I will try on a different machine,
>> comments are wellcome
>> /Torsten
>>
>=20
> I have run into very similar problems trying to test these patches, s=
o I declined to reply thinking someone else might have better or at lea=
st explicable results. I am able to build git on cygwin 1.7 using the p=
roposed patches, it seems to work, but I've run into strange problems s=
uch as the main git repo becoming corrupted, no idea how or why.
>=20
> Mark

I tried 1.8.3-rc1 on a different PC, and it seems to have the same hang=
ing.
So I will do some bisecting on master, and try to find out more.


=20
