Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC862095B
	for <e@80x24.org>; Fri, 17 Mar 2017 11:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbdCQLba (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 07:31:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56662 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751087AbdCQLb2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Mar 2017 07:31:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6FC5020B89;
        Fri, 17 Mar 2017 06:54:31 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Mar 2017 06:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=tYeg3z8x43snkxSzyi
        Gf9N+aQpc=; b=lRjNVJuYmAvOgSdva3bE/9UuGb8wIQ7GW/ExT9y40SM1YqhQav
        PVmhoJsjKJ/BHkaIbQtTGZgoX1piL4qbdzMwYj8GgqXX9ZiaqmHA8vwAJfX4l/E5
        ENVHgtes17nu7CGzQwJlk6nfP1H8Y2lgQ74L5cPZt0bjAKn7QfRiH2KSB7TLNx9t
        RDYZxS/uUgRZzk0GK5T9vpOM5Yt06/wXrbgs5csISFXj3BsFhHaSpZATasX3qIY9
        ka74IYWoxKV7wbqjwxm2uPcRj556sjoF3XTowOwFi/1k+Yw86EceXifdVQwYur3I
        4yF8QB8va97xloQJ0LBfNdYj9b4SL2ydsV8w==
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=tYeg3z8x43snkxSzyiGf9N+aQpc=; b=Nx47u3e3k/30pAdausVIiZbj
        nKGZdx4MJt7Uwz7fNn+c1h6vektgan7A/ZS1jGIkXnop23G9faVmRGmsm592dh3i
        dN/lBlAsACy+btL008xqRt2B3JpSs74ew1Dr8Xro2obrPf0INci0qJVIIO1nT8IE
        KQHUdVKQE76Y/U36lHErk+p9GjtlA6QiqxuOwC7QcqTEe0nHFbphs74xMfZkUnYV
        IU62dQ4yPTP7L/mK9rB+Q6MsYNlgNms9GPMjgN1y0zs0TsYVkaaFx+yIES1FKFhx
        zBoQEeCHqTobhFQJOPtnDCVI4xVz+KkF79Tah3iki+OJcWef9iOA8srCIvbNgQ==
X-ME-Sender: <xms:Z8DLWPrclzNpKKEEocEqV5XRlS0fng5EGOGIixB7rTYNFX4GPHbcYA>
X-Sasl-enc: iK0rmthKj21LqceH3OI105rpHdTu2BxsjA8wta65BbWo 1489748071
Received: from UltraSam.fritz.box (dslb-178-011-152-175.178.011.pools.vodafone-ip.de [178.11.152.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id D069324526;
        Fri, 17 Mar 2017 06:54:30 -0400 (EDT)
Subject: Re: [PATCH 1/3] describe: debug is incompatible with contains
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1489581340.git.git@drmicha.warpmail.net>
 <d8477234d20fe3b4db43b23cc192c18af1ecdaff.1489581340.git.git@drmicha.warpmail.net>
 <xmqqzigme474.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <a76bd1ae-74a8-a85c-852a-e36514cd05d5@drmicha.warpmail.net>
Date:   Fri, 17 Mar 2017 11:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqzigme474.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 15.03.2017 20:21:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> `git describe --contains` calls into `git name-rev` which does not have
>> any searching to do and thus does not display any debug information.
>>
>> Say so in the documentation and catch the incompatible arguments.
> 
> I am not sure if this is worth it.  Those who are really doing the
> debugging would be staring at the code while running it anyway, so
> it is not like this new error condition would help anybody from
> wasting time scratching her head before viewing the source and
> realize that the underlying name-rev does not honor the option.

The story was: I tried to understand why git describe --contains did not
do what I expected. The documentation said that --debug would output
candidates, but it did not do anything.

So, instead of learning how git describe --contains works, I got
side-tracked into understanding why git describe --contains does not do
what the documentation says. That was a waste of time that we can avoid.

"viewing the source" should not be necessary to understand what is going
on, should it?

> If "--debug" is truly valuable, "name-rev" can gain "--debug" later
> and then we can pass it down if we want.
> 
> Also, it is not like "--debug" is incompatible.  It is just the
> "--contains" codepath is overly silent and does not give any useful
> information when run in the debug mode.  "incompatible" is more like
> "would not work correctly when both are given", which is not the
> case here.

Well, thee notion of giving debug output is certainly not incompatible.
But if the "--debug" does not output anything with "--contains" then it
is not working, which I would call incompatible (implementation, not
concept).

>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  Documentation/git-describe.txt | 2 +-
>>  builtin/describe.c             | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
>> index 8755f3af7b..0f9adb6e9a 100644
>> --- a/Documentation/git-describe.txt
>> +++ b/Documentation/git-describe.txt
>> @@ -69,7 +69,7 @@ OPTIONS
>>  --debug::
>>  	Verbosely display information about the searching strategy
>>  	being employed to standard error.  The tag name will still
>> -	be printed to standard out.
>> +	be printed to standard out. This is incompatible with --contains.
>>  
>>  --long::
>>  	Always output the long format (the tag, the number of commits
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index 76c18059bf..01a6d159a0 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -462,6 +462,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>>  
>>  	if (longformat && abbrev == 0)
>>  		die(_("--long is incompatible with --abbrev=0"));
>> +	if (contains && debug)
>> +		die(_("--debug is incompatible with --contains"));
>>  
>>  	if (contains) {
>>  		struct string_list_item *item;
