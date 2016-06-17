Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29381FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 22:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbcFQWae (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 18:30:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:58607 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbcFQWae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 18:30:34 -0400
Received: from [192.168.178.27] ([88.70.210.132]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LwqwS-1bTRUE2tLM-016Osu; Sat, 18 Jun 2016 00:30:22
 +0200
Subject: Fwd: Re: [PATCH] hooks--pre-commit.sample: check for chars, that are
 not allowed for a windows file name
References: <md5:R1EZE/1Dtqwpy0vish86ww==>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
From:	dex teritas <dexteritas1@gmx.de>
X-Forwarded-Message-Id:	<md5:R1EZE/1Dtqwpy0vish86ww==>
Date:	Sat, 18 Jun 2016 00:30:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <md5:R1EZE/1Dtqwpy0vish86ww==>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-ID: <0LfSeH-1blNsV3c53-00p913@mail.gmx.com>
X-Provags-ID: V03:K0:35uHMFt+Coxe4nEm064wsoR05amishNKy1D24OWFHmP3dgEhRLI
 B7GOlF/FSg4JxjAV8OpSy1yM5c1fXV7pHL3xgifRIlpN8xkK2bgR4RgHoqeETieOYkyVlYQ
 PB0KKfZtM6VfyhU4cuIbkwTzCfwZ6RjVeGsAKe4xnW2g59DHXTfBEDMb3N1G6yO25l93fXG
 PVc8FzzXLQgT9WweCDPqg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:AybzvEkUP2Q=:N6hZDuGK0LidPU0PJvEXDG
 IL9QapW9pVub7+3KnVqfD5np/iewy0DeHw4SBs7biSEQUuCDmWZ4zeChnDxVPfOh+uG9j0+Dc
 NoiZ9DZgCH3At7hm1bxilG6zZvDcRwpeFvT0I7XfIvU9IaHPKQoSdiWWNv1sK2M9g3WXnfYnX
 sRdZgxr+g5qMkhfxXtpn+9O+LXxxFjtESV3lPGcXyFWRZ7zhlSV5mi8HrglFtyVepNQt91o6S
 oYjNaJwlgJqPU3Cb03hPcq8yspbpQD2Z2R/D8MyH5Jjx/GGUIw2sU8/tDy96BjVXIHKeCBUVp
 C4t8yelLDxdLVINs8lDq8H3k4TwpsHCE7Dotc2fDxlptKFXrXoW4LRfG0NxB+WbtFLhmXeeh7
 EqsELJH0D0ShH+ur1HJYwXLfs6Gmrp//bwZ702QPBDIn3ctG98PG17QdxBXNnxMYOeiZh3fbo
 qzp3lOuPkL/U9J3Cu/2M1ls1ZbL/j+JDBEpmyN5etFK9lZm1JiqCLwfteAL2PbkcrIVavi0nf
 A7d5MJ+z5VWP/fFnxCMUqHGQc1e40eKzlD1hPc43C8r3knbxsuSMHVYAXJVowxYGIQJ/taDXv
 iRBhVABImuRcVdlwSsIfs+PZ/GkYYT75XXJEPCDZ7/Wz3a4mWdel68TQEHl0XgLjM407/YJbG
 kWIkv55fxsOwVw8H8A9uMoP+r/lV3NTqwKsHWTEqHZ7TDsodCwKivYpauKsH19scOQmL2QGHs
 KwY3Inf5Ltg5z+cjN1D32I1OBi2zuYUfyAW3UpnTrGKn2N0+VutfM6FEK8tQaqO9gvUROrs5r
 O6bY8rA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



Am 15.06.2016 um 19:54 schrieb Junio C Hamano:
>
> dexteritas <dexteritas1@gmx.de>writes:
>>
>> After the ASCII-check, test the windows compatibility of file names.
>> Can be disabled by: git config hooks.allownonwindowschars true ---
>
> Missing sign off.
Will be there next time.
>>
>> templates/hooks--pre-commit.sample | 22 ++++++++++++++++++++++ 1 file
>> changed, 22 insertions(+) diff --git
>> a/templates/hooks--pre-commit.sample
>> b/templates/hooks--pre-commit.sample index 68d62d5..120daf1 100755
>> --- a/templates/hooks--pre-commit.sample +++
>> b/templates/hooks--pre-commit.sample @@ -17,6 +17,7 @@ fi # If you
>> want to allow non-ASCII filenames set this variable to true.
>> allownonascii=$(git config --bool hooks.allownonascii)
>> +allownonwindowschars=$(git config --bool hooks.allownonwindowschars)
>> # Redirect output to stderr. exec 1>&2 @@ -43,6 +44,27 @@ If you know
>> what you are doing you can disable this check using: git config
>> hooks.allownonascii true EOF exit 1 +elif [ "$allownonwindowschars"
>> != "true" ] &&
>
> This line is doubly irritating because (1) the double negation is
> somewhat hard to grok, and (2) [] is not part of our CodingStyle.
> Because you inherited this from the existing "allow-non-ascii" one,
> however, I do not want to see you change this line, if you need to
> reroll.
ok
>>
>> + # If you work with linux and windows, there is a problem, if you
>> use + # chars like \ / : * ? " < > |
>
> There is no reason to single out Linux, is there? This new check is
> only about Windows and because people on other platforms, not limited
> to Linux, may not be aware of some characters that are not usable on
> Windows, you are trying to help them, no?
You're right. Linux is just an example.
>
>
>>
>> + # Check if there are used only windows compatible chars + test
>> $(git diff --cached --name-only --diff-filter=A -z $against | +
>> LC_ALL=C tr -d '[0-9A-Za-z\[\]\{\}_ -)+-.]\0' | wc -c) != 0
>
> Because this is in "elif", we know we are allowing non-ascii
> characters when we come here. So you need to do a quite similar check
> from scratch, which is sensible. I do not offhand know if this covers
> all the characters that Windows users cannot use, though.
Actually the first if checks:
"$allownonascii" != "true" ] &&
test $(git diff --cached --name-only --diff-filter=A -z $against |
LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0

If we come to the elif, we either allow non-ascii characters or we don't
allow them and they don't occur.

Well, it covers the characters, but some reserved names and files with
trailing period or space are missing, as Thomas Braun wrote before.
>>
>> +then + cat <<\EOF +Error: Attempt to add a chars that are not
>> allowed for a windows file name. + +This can cause problems if you
>> want to work with people on other platforms. + +To be portable it is
>> advisable to rename the file. + +Check your filenames for: \ / : * ?
>> " < > | + +If you know what you are doing you can disable this check
>> using: + + git config hooks.allownonwindowschars true +EOF + exit 2
>
> Why 2?
Should be 1.
>>
>> fi # If there are whitespace errors, print the offending file names
>> and fail.
>
> When the user says [hooks] allownonascii = false allownonwindowschars
> = false what happens? The user's intention clearly is that the project
> wants to be usable on Windows and also wants to exclude characters
> from codepages that are not ASCII. I however suspect that the hook
> with your patch will allow people to create a "path>like?this.txt"
> happily.
That would throw an error (on the check for nonwindowschars), because
">" and "?" are not inlcuded in the expression '[0-9A-Za-z\[\]\{\}_
-)+-.]\0'.
This one also checks, if there are only ascii chars, because if
allownonwindowschars = false, non-ascii should be excluded no matter
what "allownonascii" was set to.

It may follow a reroll sometime.
