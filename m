From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] mailmap: update my entry with new email address
Date: Tue, 1 Sep 2015 18:14:10 +0100
Message-ID: <55E5DCE2.8050403@ramsayjones.plus.com>
References: <55E5C92E.7040105@ramsayjones.plus.com>
 <01dbb6005800a8816a5f6b9ae740dbc9@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:14:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWp8T-0000kE-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbbIARON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 13:14:13 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56422 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbbIAROM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:14:12 -0400
Received: from [10.0.2.15] ([146.200.92.77])
	by avasout06 with smtp
	id BtE91r0091g8v4q01tEBoE; Tue, 01 Sep 2015 18:14:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=E4sw3vpl c=1 sm=1 tr=0
 a=nn16DVc344fa5cAYhNr7tw==:117 a=nn16DVc344fa5cAYhNr7tw==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=iTTcatRJAAAA:8 a=pGLkceISAAAA:8
 a=eNcD7ojaAAAA:8 a=mK_AVkanAAAA:8 a=U7UbAiMzAAAA:8 a=F1JCeH7uAAAA:8
 a=UFlNsD0pAAAA:8 a=VwQbUJbxAAAA:8 a=cviu8vstgFaFT04z_ZgA:9
 a=2vYSk5SnCXd18eDJ:21 a=4QtrJIM7KICDTbUm:21 a=QEXdDO2ut3YA:10
 a=x8gzFH9gYPwA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <01dbb6005800a8816a5f6b9ae740dbc9@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276995>

Hi Johannes,

On 01/09/15 17:11, Johannes Schindelin wrote:
> Hi Ramsay,
>
> On 2015-09-01 17:50, Ramsay Jones wrote:
>
>> diff --git a/.mailmap b/.mailmap
>> index ece2951..e5b4126 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -186,7 +186,7 @@ Philip J=C3=A4genstedt <philip@foolip.org>
>> <philip.jagenstedt@gmail.com>
>>  Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
>>  Philippe Bruhat <book@cpan.org>
>>  Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
>> -Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
>> +Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co=
=2Euk>
>>  Ren=C3=A9 Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
>>  Robert Fitzsimons <robfitz@273k.net>
>>  Robert Shearman <robertshearman@gmail.com> <rob@codeweavers.com>
> The idea of the .mailmap file is to fix inconsistent names in the his=
tory. For example, if you look e.g. at commit 6ebdee5af47df0c64354e4524=
19015a694c25f5f, you will see that your middle name was recorded, but i=
f you look e.g. at f84df81f654aeb0ac4582e0b3be162cba6ea5232 you will se=
e that it was not always recorded with your changes.

Hmm, I assume you are using 'git log' or 'git show' to look at these; t=
ry this:

    $ git show --use-mailmap 6ebdee5af47df0c64354e452419015a694c25f5
    $ git log -1 --use-mailmap f84df81f654aeb0ac4582e0b3be162cba6ea523

or indeed, this:

    $ git check-mailmap "Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk=
>"
    Ramsay Jones <ramsay@ramsayjones.plus.com>
    $

Also, 'git shortlog'  seems to be working just fine. (The first few com=
mits, which include
my middle name, were a mistake; back then git used to look into the GEC=
OS field if
you didn't set your name in the config ...). [If it isn't clear, I don'=
t want to see my middle
name!]

Yes, I was a little surprised that '--use-mailmap' was not on by defaul=
t, but then I have a
very vague recollection of a discussion on the list which decided other=
wise. (I'm far too
lazy to search the archives ...).

ATB,
Ramsay Jones

>
> Therefore I would recommend leaving the old line in place, and just *=
adding* another one.
>
> Besides, for consistency I would leave the middle name in there. Othe=
rwise, people might be wondering why their shortlog calls bring up some=
 other name. In other words, if you add a new line, you really want to =
use the same clear name as before.
>
> You actually do not even need to add a new line if you plan on submit=
ting patches with your middle name. Remember: the main purpose of .mail=
map is to support shortlog, i.e. appropriate grouping of patches by per=
son (such as the two commits I mentioned above).
>
> Ciao,
> Johannes
>
> P.S.: That's a major bummer on your three forced-offline weeks. I fee=
l with ya!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
