From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Mon, 24 Mar 2014 10:19:12 -0700
Message-ID: <53306910.3090807@gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com> <1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com> <5330196A.3030101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 18:19:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS8X1-0006CA-TK
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbaCXRTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:19:23 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:43295 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbaCXRTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 13:19:21 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so5771931pad.3
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MiYpbvWUCVCgQdswY6BGYOHF6psTLCxBhQwyBGQPnGc=;
        b=e4YK+R9Ltf87UO+5gGzXBqk6Fz1l5sTxqHVxatn5MNuoq2zdWl/wOlZHuxm/4TjKVZ
         OXVb4+J8FXO0Xv/erbKs/R+qTo1OkInw+/9TD+GCeWh2Z/th9iL00JUco+FSM04uhG7D
         mqBVNx8dXSw5Chimm6evQCqInWGzjpvIrBw14LHWPyDgcIu5OQEbZqQALWcfQ/KLqcG6
         mUBAjP/d1bUUdljEpiUviILPepPB02Q4AN1yT6bVfgVEb67dnzT2lq61TUTG26uTD/DY
         awshLlC+qOCubCrEAhzWoG0g0jxScpar7/8/oO7jXKb5jrZjdTG0ERzkkQqZIsSor3uW
         3uGQ==
X-Received: by 10.66.66.202 with SMTP id h10mr72748705pat.70.1395681561108;
        Mon, 24 Mar 2014 10:19:21 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id yx3sm34310939pbb.6.2014.03.24.10.19.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Mar 2014 10:19:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <5330196A.3030101@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244825>

On 3/24/2014 4:39 AM, Ramsay Jones wrote:
> On 24/03/14 08:49, Ilya Bobyr wrote:
>> Most arguments that could be provided to a test have short forms.
>> Unless documented the only way to learn then is to read the code.
>>
>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>> ---
>>  t/README |   10 +++++-----
>>  1 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/t/README b/t/README
>> index caeeb9d..ccb5989 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -71,7 +71,7 @@ You can pass --verbose (or -v), --debug (or -d), and --immediate
>>  (or -i) command line argument to the test, or by setting GIT_TEST_OPTS
>>  appropriately before running "make".
>>  
>> ---verbose::
>> +-v,--verbose::
> OK
>
>> [...]
>>  
>> ---valgrind=<tool>::
>> +-v,--valgrind=<tool>::
> The -v short option is taken, above ... :-P

Right %)
Thanks :)
This one starts only with "--va", will fix it.
