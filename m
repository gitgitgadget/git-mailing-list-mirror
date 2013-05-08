From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Problems with Windows, Was: What's cooking in git.git (May 2013,
 #01; Fri, 3)
Date: Tue, 07 May 2013 20:30:55 -0400
Message-ID: <51899CBF.2020805@gmail.com>
References: <7vvc6zwta7.fsf@alter.siamese.dyndns.org> <51890F48.3090409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 02:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZsHq-00063r-OJ
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 02:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab3EHAbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 May 2013 20:31:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:35123 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab3EHAbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 20:31:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UZsHi-0005vj-Dh
	for git@vger.kernel.org; Wed, 08 May 2013 02:31:06 +0200
Received: from pool-173-79-125-63.washdc.fios.verizon.net ([173.79.125.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 May 2013 02:31:06 +0200
Received: from mlevedahl by pool-173-79-125-63.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 May 2013 02:31:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-173-79-125-63.washdc.fios.verizon.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <51890F48.3090409@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223634>

On 05/07/2013 10:27 AM, Torsten B=F6gershausen wrote:
> On 2013-05-04 01.14, Junio C Hamano wrote:
>>
>>   Cygwin portability; both were reviewed by Jonathan, and the tip on=
e
>>   seems to want a bit further explanation.  Needs positive report
>>   from Cygwin 1.7 users who have been on 1.7 to make sure it does no=
t
>>   regress for them.
>
> I was trying to verify that cygwin 1.7 is still Ok, but got puzzled.
>
> Running the test suite under cygwin doesn't seem to work any more (?)=
:
>
> Scenario 1:
> The PC is running alone, and goes into the screen saver.
> Pressing CTRL-ALT-DEL didn't get any effect.
>
> Scenario 2:
> The PC didn't react any more, when the test suite was run in backgrou=
nd.
> In 3 or 4 cases the PC needed to be reboot hardly.
>
> Using the commits before and after this change makes the test suite h=
ang
> as well at some point, then it hangs somewhere at TC 3000--4000.
>
> Scenario 4:
> The I disabled the screensaver, upgdated cygwin,
>   and went back to an older commit:
> The latest run from commit 52d63e70, April 28,
> hangs in TC 5500, ok 26 clone shallow object count.
>
> I can see 2 times
> git.exe pull --depth 4 ..A
>
> Scenario 5:
> The run of today 1.8.3-rc1, hangs in t5510,
> some git.exe are running fetch. (or pull)
>
>
> It seems as if some process/exes are not terminated
> in the way it should be.
>
> I will try on a different machine,
> comments are wellcome
> /Torsten
>

I have run into very similar problems trying to test these patches, so =
I=20
declined to reply thinking someone else might have better or at least=20
explicable results. I am able to build git on cygwin 1.7 using the=20
proposed patches, it seems to work, but I've run into strange problems=20
such as the main git repo becoming corrupted, no idea how or why.

Mark
