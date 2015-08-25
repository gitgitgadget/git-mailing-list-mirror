From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client
 specs.
Date: Tue, 25 Aug 2015 10:33:33 +0200
Message-ID: <55DC285D.9030500@web.de>
References: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com> <55DC111A.6090501@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pw@padd.com, torarvid@gmail.com, ksaitoh560@gmail.com,
	gitster@pobox.com
To: Luke Diamand <luke@diamand.org>, larsxschneider@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 10:36:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU9iO-0005Bj-RV
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 10:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbbHYIeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 04:34:14 -0400
Received: from mout.web.de ([212.227.17.12]:54378 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbbHYIeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 04:34:11 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MQ6H9-1ZQbIv1zsJ-005IMV; Tue, 25 Aug 2015 10:34:02
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <55DC111A.6090501@diamand.org>
X-Provags-ID: V03:K0:t0tBP03X5AWgkeMcIHM2KGQzVGG/My0WH+bYqpfExqQwzomtt5A
 V3NevAzdKOrO0ddAudTabQLHxHAyuuk6+Yzz+hkRCrMt+MrqPKGfX80VJtQpKkqKLfvnuKN
 r0zzxc1QWTRnzZXg51ZoKYcnG3Ub7cAnWolQv2DsWpoCo3MzoHQmpqTPPtDfwU4sxwZe71G
 8eGDmwNnYBhAjyNFOxBGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3+qIStclUpI=:y147ysWy8BcJUo678rRaeW
 egvqf5pRK89WGfUsEH3TTECSw4fHLbO+JGQk6ouKgAW8Uu89S0noL7isJ2aS3PxM+lx6UwS3m
 24vBwk8dbFY1CqHUEM3gEgPQUZ6rViVrBNAWEw1eg48ltLVtG8H2m7zHv/q+Gan4JKmDS/3ZL
 vLw34Ss1u7g+RKqlG9PG0sqTjs0xXCT85HKUNaXQ9dUevRWgr1VtcimeQUfXzo78Tyip9l4Ur
 vu/VkQ34Icl8TFyhjcgP1N8yadtYX5Ju6OBC+A9ZawsMrfLBaUIro1MrXSqtKZHGqI6MXiWrn
 O2BRRJ6hi4Z6DCd0B3MFsNC1T9fa0M4RfaNznqPHmg65B/DCSYPEeGCmhT1cFyfyj18JR/jvF
 dpH76vpjQfp81HjnbT6yVuB19ieabGFe/W6BEJjhzRMTFPJnyUeXNWlZbpm/r3trvGCx8TUbU
 fs6bhv3azU4iv5GH7+wmhUoet2CqOIZmCgCXpIqouycsZdZW+kfqbdQajqs9OmnWDVC4xmZnS
 p9v+E86mow0NuvCsorXPxygGPeDdXU0sr/J48FVZwPfFGzc5BrLQVQuiwSnDqwi+q7HalUXCS
 kJlLmgBOTX4DA+az7O49qp/l7/IIaSDl2uIzB3jPO5kbaddbgCsGhBLA7lvd7HvHZvXiqBTfy
 sYXzqQTLuc5uKI2ttcZg0hB4qj4GxffvACAF6p0dOmSu84hFG760+7zg3K+MzJJTSvIYM6GMp
 OyrFzp3uV5lB18M4mnJdw/SFaK/4KT3kX0ATuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276511>

On 08/25/2015 08:54 AM, Luke Diamand wrote:
> On 24/08/15 22:30, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> Thanks to Luke Diamand I realized the core problem and propose here a
>> substiantially simpler fix to my PATCH v4.
>>
>> The test cases remain and prove the problem. In particular
>> "8 - Clone path (ignorecase)" and
>> "Add a new file and clone path with new file (ignorecase)" fail with the
>> current implementation on OS X and Linux.
>
> That's a lot simpler, thanks!
>
> Could we give this its own command line option and git config variable?
>
> Core.ignorecase gets set if the client is on a filing system that 
> ignores case. This is slightly different - it squashes case in depot 
> files for people with depots that have incorrectly jumbled-up case.
>
> Conflating the two seems like it would cause confusion at some point - 
> for example, I have no idea how the rest of git behaves if 
> core.ignorecase is set to True on a case-preserving file system.
>
That doesn't work as expected and is not allowed (or say strictly 
forbidden, or strongly recommended not to do)

Remembering older discussions about importers from foreign VCS:
This should work best for most people:
Look at the command line option, if no one is given,
look at core.ignorecase.

So the command line option overrides core.ignorecase,
and the  user can either run
--ignore-path-case
or
--no-ignore-path-case
  PS:
Need to drop Eric from the list: the MX/A from from web.de problem still 
exists
