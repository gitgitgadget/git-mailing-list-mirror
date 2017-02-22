Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08862023D
	for <e@80x24.org>; Wed, 22 Feb 2017 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbdBVRV5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:21:57 -0500
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:52334 "EHLO
        smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932498AbdBVRV4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 12:21:56 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Feb 2017 12:21:55 EST
Received: from smtp26.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp26.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id A7CE8E03B0;
        Wed, 22 Feb 2017 12:15:34 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp26.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 624DCE0265;
        Wed, 22 Feb 2017 12:15:34 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 22 Feb 2017 12:15:34 -0500
Subject: Re: [RFC][Git GUI] Make Commit message field in git GUI re sizable.
To:     Jessie Hernandez <jessie@jessiehernandez.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
References: <44fd4dce451fb0783de02c0a8c4a14aa.squirrel@mail.jessiehernandez.com>
 <CAKPyHN3f0NwMt1aXx6keSrhaiqRqH6s_xQFdKv5rZ+pL7fmXFw@mail.gmail.com>
 <dfcc54b406d9f46cf358b7ead128bf65.squirrel@mail.jessiehernandez.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <59ab152c-62d1-a2ec-eee5-0bd909674988@xiplink.com>
Date:   Wed, 22 Feb 2017 12:15:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <dfcc54b406d9f46cf358b7ead128bf65.squirrel@mail.jessiehernandez.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-02-22 06:59 AM, Jessie Hernandez wrote:
>> HI,
>>
>> the reason why it is fixed, is because commit messages should be
>> wrapped at 76 characters to be used in mails. So it helps you with the
>> wrapping.
>>
>> Bert
>
> Right ok. I understand.
> Knowing this I think I might start writing my commit messages differently
> then.

You can configure gui.commitMsgWidth if you don't like the default 
(which is 75, not 76).

		M.


> Thank you for this.
>
> Regards
>
> -----------------
> Jessie Hernandez
>
>>
>>
>> On Wed, Feb 22, 2017 at 10:27 AM, Jessie Hernandez
>> <jessie@jessiehernandez.com> wrote:
>>> Hi all,
>>>
>>> I have been using git for a few years now and really like the software.
>>> I have a small annoyance and was wondering if I could get the
>>> communities
>>> view on this.
>>>
>>> When using git GUI I find it handy to be able to re-size the "Unstaged
>>> Changes" and the "Staged Changed" fields.
>>>
>>> I would like the same thing for the "Commit Message" field, or to have
>>> it
>>> re-size with the git GUI window.
>>>
>>> I can re-size the "Commit Message" vertically when making the "Modified"
>>> panel smaller.
>>>
>>> Does this make sense?
>>> I would be happy to get into more detail if that is necessary or if
>>> something is not clear.
>>>
>>> Thank you.
>>>
>>> -----------------
>>> Jessie Hernandez
>>>
>>>
>>
>
>
