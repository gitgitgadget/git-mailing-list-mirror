From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 4/2] test: use test_must_contain
Date: Sat, 21 Nov 2015 03:30:09 +0100
Message-ID: <564FD731.6070804@web.de>
References: <1448068603-2112-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 21 03:30:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzxx2-0000S6-A2
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 03:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760112AbbKUCaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2015 21:30:52 -0500
Received: from mout.web.de ([212.227.15.3]:58717 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759610AbbKUCav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 21:30:51 -0500
Received: from [192.168.178.36] ([79.253.191.33]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MGAB5-1aBFX83jRH-00FFhj; Sat, 21 Nov 2015 03:30:22
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1448068603-2112-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V03:K0:28Aa9RMhU2W1KzXmBHNFJndQZtayBgCBPYxxU1eQdAjycj9Cu1m
 U7ToWgi3FHfP/U+Oe0sArPYWS5091MEbJYAQxNljE7dkmBdQ5W9C8q72zKEPapkvrh68WQQ
 hiKec/8qmznnkMjw5tMKPvCsMRFSvDrxXwDJRYWvehRCAeG9qL6RyK7+MvfVJ1O4tWoIBXJ
 E8iMeZaR58vlexa8/KpUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yyvVxTleGo8=:Bmaqw5B+HJ9BQc6heRK1pH
 ctNgaavRY+orKkuzRbKMKcOsSNLOQcMEzA2/Ank//2/gdfRdtlcmHmLtW8hu1od4g7T59O50B
 EEbA1su9G8Ja5T/JB178XLQRwrmlYr555tad/Xev0bHvW2HV6YhU+R9/3ZU47SJ89a+2JMbq8
 oTJHrAvO3//D8Q76WKcX+OpcQJ6e6QJoZdhFGlRIgd54nRGOiIef8CSMIJ7MoHd2r/9cOO2z2
 I/M9z7SbqvgFO2DpJcAyuz/sjbb41G0i2wMwwQu6ELtZRz/UEjoOiZYwYQkOh+IHI8bA67ZXp
 nvfe8OtpSfogYXGalTLn5WUG86LkOCQ1rompjTJqPU1QttQtGZj4ZZaZbpkS+Cq3bP1dOEipG
 kJKsV0rDTFJ4ZwvMiSZGbFrEN0LXAH8AE2cjoI9C75xW/lQgUpAuoHiyeR8CqecXuUmxK2D+Q
 C58SA8XvSaRNmkI89x+kxlsyLJl3NLrqvGKuGkLzL7Zw7PfUxhAescSf/SozEjeH8+LdxoOqA
 bPlUvpceyMUV+cgKrr+a0WDrUK9sX9nI87OErVvFgZhw5In2ABR77SKtFYhs452/v3P0OMGU3
 goyTmyJRSiNPh05Rw5kZLR+c7ZFqa6DFIN3ktQSx3UBZgdE/U+9AukD7KDp9IUjPaDHyaAxRG
 6b96weUMiyYLvbWg6HjfSXxl2pn9VVg+naxaQXskrFSNlgrhnKE0V5kgqudkwxYtbeXStYfvp
 rio6rvipDgTdklT6rfUvuXVy4HU3a3ShCOZgFMGcNjHYMwvufVU+nis4E/jK2Q1TEGWIDYzC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281543>

Am 21.11.2015 um 02:16 schrieb SZEDER G=E1bor:
> Hi,
>
>> diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
>> index 8134ab4..e02b490 100755
>> --- a/t/t9810-git-p4-rcs.sh
>> +++ b/t/t9810-git-p4-rcs.sh
>> @@ -294,8 +294,7 @@ test_expect_success 'cope with rcs keyword file =
deletion' '
>>   		echo "\$Revision\$" >kwdelfile.c &&
>>   		p4 add -t ktext kwdelfile.c &&
>>   		p4 submit -d "Add file to be deleted" &&
>> -		cat kwdelfile.c &&
>> -		grep 1 kwdelfile.c
>> +		test_must_constain 1 kwdelfile.c
>
> s/constain/contain/
>

Thank you!  I need to work on my vi fu..  Or install all optional tools=
=20
to be able to run the full test suite. ;)

Ren=E9
