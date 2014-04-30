From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Wed, 30 Apr 2014 02:38:57 -0700
Message-ID: <5360C4B1.10701@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>	<1398154767-1276-2-git-send-email-ilya.bobyr@gmail.com> <xmqqr44nzyx6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 11:39:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfQyv-00056C-KS
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 11:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758747AbaD3JjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 05:39:09 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:49085 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758744AbaD3JjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 05:39:07 -0400
Received: by mail-ig0-f170.google.com with SMTP id uq10so7061271igb.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GZfMhdpzg7HYMojkoEbnhxgpVq2NJszUrlV4SUzuo5I=;
        b=z3SSPoIMOBSHGMQi8nXxLyMzfrAQLwFCeprUuih2FOT6tQTvasaYpfr5tjzCBtXPmT
         QjhPhcZU394TOeuterqMJpcAVAzNNRmcijYB9AbwFklo3CbZzHA5aDILAPbJolkTnicG
         70jHPog34mJ7UAd6oop7PMAQtI7D8Xm4BktNJOq6ugqIcwTdMfSrCwfp0od3Rl5y+XJJ
         UP/bPBtBWJjutsDkwUdkm8I4YgnKBZSkMkSDDdEPUXXvylk/l4S8PKwHiSTBCpBCnmtf
         7MMBwxYVJS39gaAoDGjhI3hQHWeVOaPxNwzehr9NeEP7uY5ipL3+sonc5L5N2SDhzTVo
         TZgQ==
X-Received: by 10.43.94.9 with SMTP id bw9mr2484159icc.19.1398850745410;
        Wed, 30 Apr 2014 02:39:05 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id h7sm4296302igy.2.2014.04.30.02.39.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 02:39:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:29.0) Gecko/20100101 Thunderbird/29.0
In-Reply-To: <xmqqr44nzyx6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247688>

On 4/23/2014 11:24 AM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>> Most arguments that could be provided to a test have short forms.
>> Unless documented, the only way to learn them is to read the code.
>>
>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>> ---
>>  t/README |    8 ++++----
>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/README b/t/README
>> index caeeb9d..6b93aca 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -71,7 +71,7 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
>>  (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
>>  appropriately before running "make".
>>  
>> ---verbose::
>> +-v,--verbose::
>>  	This makes the test more verbose.  Specifically, the
>>  	command being run and their output if any are also
>>  	output.
> I was debating myself if the result should look more like this:
>
> 	-v::
> 	--verbose::
> 		This makes the test more verbose.  Specifically, the
> 		command being run and their output if any are also
> 		output.
>
> As a straight text file, your version is certainly a lot easier to
> read, but at the same time, the entire file is written in more or
> less AsciiDoc format (the list of prerequisites and the list of
> harness library functions need to be converted to the "item::" form
> for the text to format well, though) and I've seen some efforts by
> others to run text files in Documentation/ that were originally
> meant to be consumed as straight text thru AsciiDoc, so the latter
> form might be a small step for futureproofing.
>
> My conclusion at this point is that the original is good for the
> current need of the project; if somebody wants to include this file
> from somewhere in Documentation/technical, a conversion to use
> multiple "item1::<newline>item2::<newline>description" headers can
> be done by that person as part of the "make it fully AsciiDoc"
> effort.
>
> Thanks.

I've changed it.
It is a trivial change and it does not seem to be that bad in plain text
form either.

I do not know the AsciiDoc conventions as  have not read its spec.  If
there are any other conventions I am breaking - let me know.
I will read the spec if I will be contributing more to the documentation.

P.S.  Sorry it takes me this long to reply %)
