Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA475201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 07:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdBWHSi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 02:18:38 -0500
Received: from smtpq5.tb.mail.iss.as9143.net ([212.54.42.168]:40111 "EHLO
        smtpq5.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750828AbdBWHSh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Feb 2017 02:18:37 -0500
X-Greylist: delayed 1894 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Feb 2017 02:18:37 EST
Received: from [212.54.42.133] (helo=smtp9.tb.mail.iss.as9143.net)
        by smtpq5.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1cgnB7-0000MD-2v
        for git@vger.kernel.org; Thu, 23 Feb 2017 07:47:01 +0100
Received: from 53546d64.cm-6-5b.dynamic.ziggo.nl ([83.84.109.100] helo=jessiehernandez.com)
        by smtp9.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1cgnB7-0001OE-0R
        for git@vger.kernel.org; Thu, 23 Feb 2017 07:47:01 +0100
Received: by jessiehernandez.com (Postfix, from userid 112)
        id 4CD50223D8; Thu, 23 Feb 2017 07:47:00 +0100 (CET)
Received: from jessiehernandez.com (localhost [127.0.0.1])
        by jessiehernandez.com (Postfix) with ESMTP id 17835223D5;
        Thu, 23 Feb 2017 07:46:42 +0100 (CET)
Received: from 217.150.190.17
        (SquirrelMail authenticated user jessie)
        by jessiehernandez.com with HTTP;
        Thu, 23 Feb 2017 07:46:42 +0100
Message-ID: <72adf5223518cc9d95088471886ab992.squirrel@jessiehernandez.com>
In-Reply-To: <59ab152c-62d1-a2ec-eee5-0bd909674988@xiplink.com>
References: <44fd4dce451fb0783de02c0a8c4a14aa.squirrel@mail.jessiehernandez.com>
    <CAKPyHN3f0NwMt1aXx6keSrhaiqRqH6s_xQFdKv5rZ+pL7fmXFw@mail.gmail.com>
    <dfcc54b406d9f46cf358b7ead128bf65.squirrel@mail.jessiehernandez.com>
    <59ab152c-62d1-a2ec-eee5-0bd909674988@xiplink.com>
Date:   Thu, 23 Feb 2017 07:46:42 +0100
Subject: Re: [RFC][Git GUI] Make Commit message field in git GUI re sizable.
From:   "Jessie Hernandez" <git@jessiehernandez.com>
To:     "Marc Branchaud" <marcnarc@xiplink.com>
Cc:     "Bert Wesarg" <bert.wesarg@googlemail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Pat Thoyts" <patthoyts@users.sourceforge.net>
Reply-To: git@jessiehernandez.com
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-SourceIP: 83.84.109.100
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.2 cv=I5QVfJog c=1 sm=1 tr=0 a=O0j+lLEKKvAiBX9A7DJArw==:17 a=8nJEP1OIZ-IA:10 a=n2v9WMKugxEA:10 a=CdBCPKDxAAAA:8 a=SjKmM18lqorzjPJA2IoA:9 a=wPNLvfGTeEIA:10 a=lDjxF1AZmdN7bNtopFhl:22
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 2017-02-22 06:59 AM, Jessie Hernandez wrote:
>>> HI,
>>>
>>> the reason why it is fixed, is because commit messages should be
>>> wrapped at 76 characters to be used in mails. So it helps you with the
>>> wrapping.
>>>
>>> Bert
>>
>> Right ok. I understand.
>> Knowing this I think I might start writing my commit messages
>> differently
>> then.
>
> You can configure gui.commitMsgWidth if you don't like the default
> (which is 75, not 76).
>
> 		M.

Hi Marc,

Yeah I did that in my local version and got my desired effect.
But knowing it was designed like this and and not a bug,
I am happy to use the designed behavior and adjust my way of working.

-----------------
Jessie Hernandez

>
>
>> Thank you for this.
>>
>> Regards
>>
>> -----------------
>> Jessie Hernandez
>>
>>>
>>>
>>> On Wed, Feb 22, 2017 at 10:27 AM, Jessie Hernandez
>>> <jessie@jessiehernandez.com> wrote:
>>>> Hi all,
>>>>
>>>> I have been using git for a few years now and really like the
>>>> software.
>>>> I have a small annoyance and was wondering if I could get the
>>>> communities
>>>> view on this.
>>>>
>>>> When using git GUI I find it handy to be able to re-size the "Unstaged
>>>> Changes" and the "Staged Changed" fields.
>>>>
>>>> I would like the same thing for the "Commit Message" field, or to have
>>>> it
>>>> re-size with the git GUI window.
>>>>
>>>> I can re-size the "Commit Message" vertically when making the
>>>> "Modified"
>>>> panel smaller.
>>>>
>>>> Does this make sense?
>>>> I would be happy to get into more detail if that is necessary or if
>>>> something is not clear.
>>>>
>>>> Thank you.
>>>>
>>>> -----------------
>>>> Jessie Hernandez
>>>>
>>>>
>>>
>>
>>
>


