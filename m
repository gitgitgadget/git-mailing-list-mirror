From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Thu, 30 Apr 2015 08:55:12 +0200
Message-ID: <5541D1D0.8070407@alum.mit.edu>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com> <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Koosha Khajehmoogahi <koosha@posteo.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
	=?UTF-8?B?Tmd1?= =?UTF-8?B?eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 08:55:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YniNi-00075m-6T
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 08:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbbD3GzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 02:55:23 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50605 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750710AbbD3GzW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2015 02:55:22 -0400
X-AuditID: 1207440d-f79976d000005643-ac-5541d1d370d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 59.9E.22083.3D1D1455; Thu, 30 Apr 2015 02:55:15 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97A01.dip0.t-ipconnect.de [79.201.122.1])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3U6tC0P023554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 30 Apr 2015 02:55:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqbni64kum.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsUixO6iqHv5omOowbb51hZrXpxmtui60s1k
	0dB7hdlixdU5zBb9y7vYLLbNWcVq0T3lLaPFj5YeZovWD3eYHDg9WidPYvbYOesuu8eHj3Ee
	z3r3MHpcvKTs8euwqMfnTXIB7FHcNkmJJWXBmel5+nYJ3Bk33qQUfOCvOLbuE2MD4weeLkZO
	DgkBE4ltmycxQdhiEhfurWfrYuTiEBK4zCix+fsHKOcck8S6E6fAqngFtCX6di5iBbFZBFQl
	lk0/xAxiswnoSizqaQarERUIkmi9NpURol5Q4uTMJywgtoiAtcTvn9+ZQIYyC/xmkvh7dBs7
	SEJYwF7i7/ffYEOFBDIlHh+ZBNbMCdTQtbcfqJkDqEFdYv08IZAws4C8RPPW2cwTGAVmIVkx
	C6FqFpKqBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFCIoN3B+P/dTKH
	GAU4GJV4eGe0OoYKsSaWFVfmHmKU5GBSEuW9tQooxJeUn1KZkVicEV9UmpNafIhRgoNZSYRX
	Yj1QjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbvwAlCjYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChO44uBkQqS4gHa6wXSzltckJgLFIVoPcWoyzHn
	5u9FTEIsefl5qVLivM0gRQIgRRmleXArYGnwFaM40MfCvPNAqniAKRRu0iugJUxAS87fcgBZ
	UpKIkJJqYKy9Y/R+6audss/XpHk9bdm2LlTHsUdyiX3Cuye3nfjXcjQv2qr/SjSh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268058>

On 04/30/2015 12:42 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>> ...
> 
> There are a handful of topics that are almost there but not
> finished.  Could the topic owners and area submaintainers who are
> involved in them report their current status soonish, please, to
> help me decide to keep or discard them?
> [...]
>> * mh/numparse (2015-03-19) 14 commits
>>  - diff_opt_parse(): use convert_i() when handling --abbrev=<num>
>>  - diff_opt_parse(): use convert_i() when handling "-l<num>"
>>  - opt_arg(): simplify pointer handling
>>  - opt_arg(): report errors parsing option values
>>  - opt_arg(): use convert_i() in implementation
>>  - opt_arg(): val is always non-NULL
>>  - builtin_diff(): detect errors when parsing --unified argument
>>  - handle_revision_opt(): use convert_ui() when handling "--abbrev="
>>  - strtoul_ui(), strtol_i(): remove functions
>>  - handle_revision_opt(): use convert_i() when handling "-<digit>"
>>  - handle_revision_opt(): use skip_prefix() in many places
>>  - write_subdirectory(): use convert_ui() for parsing mode
>>  - cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
>>  - numparse: new module for parsing integral numbers
>>
>>  Many codepaths use unchecked use of strtol() and friends (or even
>>  worse, atoi()).  Introduce a set of wrappers that try to be more
>>  careful.
>>
>>  Waiting for a reroll ($gmane/266209).

Yes, I've started rerolling this series a bit less ambitiously; i.e.,
introduce the numparse API but in the first iteration avoid changing the
behavior of the code that is doing the parsing. No ETA, I'm afraid.

Feel free to drop v1 from your repository unless you think it might be
useful as a reminder or object for discussion or something.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
