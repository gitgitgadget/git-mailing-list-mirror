From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: t7063-status-untracked-cache.sh test failure on next
Date: Wed, 21 Oct 2015 20:51:32 +0100
Message-ID: <5627ECC4.6030304@ramsayjones.plus.com>
References: <5627A31C.10906@ramsayjones.plus.com> <5627B7DD.3020909@web.de>
 <1445449800.8302.12.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:51:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozQD-0005A8-AN
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbbJUTvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2015 15:51:37 -0400
Received: from avasout08.plus.net ([212.159.14.20]:34419 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbbJUTvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 15:51:36 -0400
Received: from [10.0.2.15] ([87.114.3.134])
	by avasout08 with smtp
	id XvrX1r00B2tV80P01vrYj4; Wed, 21 Oct 2015 20:51:35 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=qQ71F3v+nKp5qei/W0vv8w==:117 a=qQ71F3v+nKp5qei/W0vv8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=G_wNqf4TB8V-oFW51zEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1445449800.8302.12.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280007>



On 21/10/15 18:50, David Turner wrote:
> On Wed, 2015-10-21 at 18:05 +0200, Torsten B=C3=B6gershausen wrote:
>> On 21.10.15 16:37, Ramsay Jones wrote:
>>> Hi Junio,
>>>
>>> While testing the next branch today, I had a test failure, viz:
>>>
>>>     $ tail ntest-out-fail
>>>     Test Summary Report
>>>     -------------------
>>>     t7063-status-untracked-cache.sh                  (Wstat: 256 Te=
sts: 32 Failed: 22)
>>
>> Does this patch help ?
>> (Recently send & tested by David. I just copy & paste the diff)
>=20
> My patch fixes one of the tests, but Ramsay has a zillion failures
> (presumably because test 1 fails and most everything else follows fro=
m
> that).
>=20
> That test could fail if your clock were running fast and you had
> 1-second resolution timetamps on your filesystem and you were somewha=
t
> unlucky. =20

yep. I've just stopped running the test in a loop after about an hour.
In that time it has executed the test about 130+ times (yeah, I forgot
the count), with no failures. I'm going to give up now and declare that
I was simply unlucky! :-D

ATB,
Ramsay Jones
