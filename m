From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Accept-language test fails on Mac OS
Date: Sat, 06 Dec 2014 10:50:56 +0100
Message-ID: <5482D180.9010002@web.de>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com> <xmqqppbxogli.fsf@gitster.dls.corp.google.com> <CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, EungJun Yi <semtlenori@gmail.com>
To: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 10:51:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxC1T-0001Vy-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 10:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbaLFJvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 04:51:19 -0500
Received: from mout.web.de ([212.227.17.11]:62424 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbaLFJvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 04:51:08 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LfRnJ-1XdYWy0ZHF-00p6vn; Sat, 06 Dec 2014 10:51:01
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>
X-Provags-ID: V03:K0:x1EMCHbBw6EnTTJcgIvS2lm0MZIYaP2gYxuv9HFdXopcjyiA0cT
 yMnprQKbvqesHP6E9x0vxoSSnpZ2oYbejCeqHpAjzcBx5tXWOIQHWN0phpeVJZXmB4qB765
 TJLIqRRxZjaVJekWBziO2Cw0m00tTxrxyqyv5/pkGeQxHokQ+q7LCjEZ5EnmHHmkeoAB2Wa
 KW94H0Grgpt0EFOwnIr4Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260945>

On 2014-12-06 00.01, Michael Blume wrote:
> On Fri, Dec 5, 2014 at 2:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael Blume <blume.mike@gmail.com> writes:
>>
>>> Test #25 'git client sends Accept-Language based on LANGUAGE, LC_ALL,
>>> LC_MESSAGES and LANG' in t5550 fails consistently on my mac, and has
>>> since the test was introduced. Test 26 and 27 ('git client sends
>>> Accept-Language with many preferred languages' and 'git client does
>>> not send Accept-Language') seem fine.
>>>
>>> I'm building git with NO_GETTEXT=1, which may be an issue? But in that
>>> case the test should probably be gated on gettext?
>>
>> I recall queuing a SQUASH??? on top of the posted patch; does these
>> tests pass with it reverted?
> 
> The test fails both on pu and on 7567fad which is prior to the
> SQUASH??? commit, so the squash does not seem to change anything.
pu@c83418638e0c326f:
t5550 fails here under Debian Linux,
I haven't digged further

not ok 25 - git client sends Accept-Language based on LANGUAGE, LC_ALL, LC_MESSAGES and LANG
#       
#               check_language "ko-KR, *;q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
#               check_language "de-DE, *;q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8 &&
#               check_language "ja-JP, *;q=0.1" ""          ""          ja_JP.UTF-8 en_US.UTF-8 &&
#               check_language "en-US, *;q=0.1" ""          ""          ""          en_US.UTF-8
#       
