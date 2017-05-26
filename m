Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BCD1FA14
	for <e@80x24.org>; Fri, 26 May 2017 16:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765065AbdEZQCZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 12:02:25 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35725 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbdEZQCX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 12:02:23 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so1817829qtb.2
        for <git@vger.kernel.org>; Fri, 26 May 2017 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eJ52H88qLztlsfz9JlAqnHwFvzIIveVFMABqaO+8oUw=;
        b=a3g4NLzET8XMAfAzdfUPqeSTdFAwmW+TS/pRWQqLi5k2+YFRQR6Y8aiHbYsHq/mpNG
         aQr5twdGf7fkOxOt5sMhtgtc7zazWn5HNNadyseJb4+/QtYDZH1BEpe5koaV4VK1lagY
         CW7Mbbf5ut0vkrPyDXz0p5c91q0gR2hKxXrOdNSHNUL5jixCi3cLQe2FToG/oWZRJ5x5
         LO06/9RR2b8T7B55GmhcmYWouOtp51vl1bUHhjQVKQex0ZcPmww4a/QxFGjie1/eM0IK
         m0sY16VffRH+SET8oUwFA9VX8IOqsjXGaaUNsC5Z4vssjL8mIDlssLnqrY6EqXKj711F
         L4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eJ52H88qLztlsfz9JlAqnHwFvzIIveVFMABqaO+8oUw=;
        b=MC8xFlXgibqrp4sNh77FcJEbGpcUf/NH/2cUEu4jhNfANS1QPpqHjEOpDPobIq2qMW
         qtLdcR09oXS1OxDfupvz8csAOKfT0N2ONnK+U8RMv7524n/C36bccMZKTG4oTEIp0AsS
         DTbVaTBmIvsICs7s8mBRJPCjIXSiDu5LRBabouWLHtYxz3SObrTg/Ax3Kacbz9YBZTF+
         oZb2VGyhNEN7NOfQM1YykglNJ3bF1UCRpLsBZiaf8DvJNcQcddKJfhNwROlA8/1OJJHu
         TxZOgMedMLSPBVFo9ISpg5XF7EsDs2bBh0BNlEF7fpp8nrwqT4kDgXXC7cp4uyGzCmLO
         bgXA==
X-Gm-Message-State: AODbwcDd6kwPwpinusyd3r6i4zkU0Jg7wxEdHqGVYNbvPu//FMSmeLCs
        avlNdg/+9/vYVQ==
X-Received: by 10.200.43.120 with SMTP id 53mr3461405qtv.109.1495814542613;
        Fri, 26 May 2017 09:02:22 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id q41sm758596qtc.8.2017.05.26.09.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 May 2017 09:02:21 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] fsmonitor: add a sample query-fsmonitor hook
 script for Watchman
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <20170518201333.13088-7-benpeart@microsoft.com>
 <CAP8UFD340yndvkT8=F9zdzX9QtbuPspn8rfiK8q7f8c=kGeWQg@mail.gmail.com>
 <CACBZZX4X9v5S6EQaX0tX71sK6c5kriaCTMoXqUx0Fg6WO9Wmiw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1a55f46e-7642-587b-3547-7f7b406d2be8@gmail.com>
Date:   Fri, 26 May 2017 12:02:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX4X9v5S6EQaX0tX71sK6c5kriaCTMoXqUx0Fg6WO9Wmiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/26/2017 5:47 AM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, May 24, 2017 at 3:12 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Thu, May 18, 2017 at 10:13 PM, Ben Peart <peartben@gmail.com> wrote:
>>> This hook script integrates the new fsmonitor capabilities of git with
>>> the cross platform Watchman file watching service. To use the script:
>>>
>>> Download and install Watchman from https://facebook.github.io/watchman/
>>> and instruct Watchman to watch your working directory for changes
>>> ('watchman watch-project /usr/src/git').
>>>
>>> Rename the sample integration hook from query-fsmonitor.sample to
>>> query-fsmonitor.
>>>
>>> Configure git to use the extension ('git config core.fsmonitor true')
>>> and optionally turn on the untracked cache for optimal performance
>>> ('git config core.untrackedcache true').
>>
>> Ok, it looks like the untracked cache can be used, but it could work without it.
>>
>>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>   templates/hooks--query-fsmonitor.sample | 27 +++++++++++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>   create mode 100644 templates/hooks--query-fsmonitor.sample
>>>
>>> diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
>>> new file mode 100644
>>> index 0000000000..4bd22f21d8
>>> --- /dev/null
>>> +++ b/templates/hooks--query-fsmonitor.sample
>>> @@ -0,0 +1,27 @@
>>> +#!/bin/sh
>>> +#
>>> +# An example hook script to integrate Watchman
>>> +# (https://facebook.github.io/watchman/) with git to provide fast
>>> +# git status.
>>> +#
>>> +# The hook is passed a time_t formatted as a string and outputs to
>>> +# stdout all files that have been modified since the given time.
>>> +# Paths must be relative to the root of the working tree and
>>> +# separated by a single NUL.
>>> +#
>>> +# To enable this hook, rename this file to "query-fsmonitor"
>>> +
>>> +# Convert unix style paths to escaped Windows style paths
>>> +case "$(uname -s)" in
>>> +MINGW*|MSYS_NT*)
>>> +  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,\\\\,g')"
>>> +  ;;
>>> +*)
>>> +  GIT_WORK_TREE="$PWD"
>>> +  ;;
>>> +esac
>>> +
>>> +# Query Watchman for all the changes since the requested time
>>> +echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1, \"fields\":[\"name\"]}]" | \
>>> +watchman -j | \
>>> +perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"}); print(join("\0", @{$o->{"files"}}));'
>>
>> Maybe put the above small perl script on multiple lines for improved
>> readability.
>>

I'll pick up the suggestions from Ævar on the perl script.  I believe 
that fixes all the issues you have raised.

I've also tested the various error cases of watchman not installed and 
when watchman returns an error and they are all properly handled by 1) 
giving an error message and 2) falling back to the git codepath without 
fsmonitor so that the git command succeeds.

>> Is JSON::PP always available in Perl >= 5.8?
> 
> No, it's shipped with perl as of 5.14.0, which came out in May 2011.
> 
> I think depending on that is fine. FWIW we bumped the required core
> dependency (but you might still need to install modules) in 2010 in my
> d48b284183 ("perl: bump the required Perl version to 5.8 from
> 5.6.[21]", 2010-09-24). Maybe we should be bumping that again...
> 
>> What happens if watchman is not installed or not in the PATH?
>> It seems to me that the git process will not die, and will just work
>> as if the hook does not exist, except that it will call the hook which
>> will probably output error messages.
> 
> I think a good solution to this is to just add "set -euo pipefail" to
> that script.
> 
> Then we'll print out on stderr that we couldn't find the watchman
> command. Right now (with my patch) it'll make its way to the perl
> program and get empty input.
> 

With or without "set -euo pipefail" the output if watchman is not 
installed is:

.git/hooks/query-fsmonitor: line 37: watchman: command not found
Watchman: command returned no output.
Falling back to scanning...
On branch fsmonitor
Your branch is up-to-date with 'benpeart/fsmonitor'.


To try this out on Mac, you can install the package maintained by 
MacPorts by running "sudo port install watchman"

https://facebook.github.io/watchman/docs/install.html

