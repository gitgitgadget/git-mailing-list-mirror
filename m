From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Thu, 15 Nov 2012 20:35:34 +0100
Message-ID: <50A54406.5080309@web.de>
References: <20121113175205.GA26960@sigill.intra.peff.net> <50A2B14C.9040608@web.de> <50A53CF0.7040809@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, mlevedahl@gmail.com,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:36:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ5EX-0001Fh-T9
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 20:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768793Ab2KOTgC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 14:36:02 -0500
Received: from mout.web.de ([212.227.17.12]:54327 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768775Ab2KOTgB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 14:36:01 -0500
Received: from wanderer.site ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lylrf-1TCNc73FSB-015Pa3; Thu, 15 Nov 2012 20:35:45
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <50A53CF0.7040809@ramsay1.demon.co.uk>
X-Provags-ID: V02:K0:zPhv3kioTs3qt+buJs5LShg0LgTuYSUXupeBuk00eLy
 wJVtGCH5SjEaQpV0Y9cls0nYoKeunFfl/VPLdpzM8BG8foPJ+Y
 MZ0gKYGanjWZY4OiHsXmCp/mgSAY7b0OFZEVdXftFLAUZ90t9Y
 nSz7i45VqYkKJmhyyWH7O16pLtT0KXnnMYpq97f/dMa64bmpZ3
 y75zE4Ygy3rAXZThN6jmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209844>

On 11/15/2012 08:05 PM, Ramsay Jones wrote:
> Torsten B=C3=B6gershausen wrote:
>>> * ml/cygwin-mingw-headers (2012-11-12) 1 commit
>>>   - Update cygwin.c for new mingw-64 win32 api headers
>>>
>>>   Make git work on newer cygwin.
>>>
>>>   Will merge to 'next'.
>>
>> (Sorry for late answer, I managed to test the original patch minutes=
 before Peff merged it to pu)
>> (And thanks for maintaining git)
>>
>> Is everybody using cygwin happy with this?
>
> I am still on cygwin 1.5.22 and quite happy that this patch does
> not (seem) to cause any problems. ;-P
>
>> I managed to compile on a fresh installed cygwin,
>> but failed to compile under 1.7.7, see below.
>> Is there a way we can achieve to compile git both under "old" and "n=
ew" cygwin 1.7 ?
>> Or is this not worth the effort?
>
> Did the cygwin project not bump an api version number somewhere?
>
> ATB,
> Ramsay Jones
Ramsay,
you can run uname -r to see the version number.

I myself haven't fully understood all the consequences,
somewhere between 1.7.7 and 1.7.17 the include files had been changed.

If this has consequences for using e.g. winsock2.dll, I want to know=20
myself ;-)

/Torsten
