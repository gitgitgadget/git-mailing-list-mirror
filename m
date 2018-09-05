Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02221F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeIEXe1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:34:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:49075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeIEXe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:34:27 -0400
Received: from [10.24.110.212] ([185.190.160.130]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0Ppl-1fjoBN05uf-00uZrp; Wed, 05
 Sep 2018 21:02:52 +0200
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <CACsJy8BLEtBWyAuRBphv_PVisKao0YaBewKJXECEuCVzvk9qXg@mail.gmail.com>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <5c618de8-6676-8fa4-fe19-4db44befd73c@gmx.de>
Date:   Wed, 5 Sep 2018 21:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BLEtBWyAuRBphv_PVisKao0YaBewKJXECEuCVzvk9qXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vw/QlpMj3n98N5Kq/Hn1rNhg5vghvXJY4FO01FZWLD4OTpKt3qi
 Pe3yOg3SUOqfKeBZuAM9YoHloVwd1cqALzxodbBiBd+iezQHU0ol5tvRu9DO1kUqD/WmuIk
 OgtpDtOiZA/d6edyLhgAkUt1jY3Ti0ALX2nLjh/gvmzUSlcldJsl152SsMPHk8Kx5zmZq5B
 8durrIw99eo5U4LXi8k2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LMv8KsITFCI=:2Ff3a8e6noJsJ+Gw0ynM1E
 qE/Ws0LfCPAgo6raiWny85Vzz0eEZwa8S4vh6W280N5wkOpev4ZYkelUzjczH7Y7kYir+QN9w
 k0Vphn6/5oqAYeiB57tLyf1RpQ9Y9ysiD9+tUpYgvQLPEmFglAZhAWI0OX3VpF11//PKrQnoO
 hxgvP22e6QhaiKzm1mhXAVdwITOrNDOZ2jVKWorr1EA2jFUkCEMWjU81172iy/Tz+8LfxAPfG
 /MN3bvw1zRJGk7DMXVwnCgQfBxFOTcJc2XJvOEq8LiaOdXQgxxoWSth66+LLLb5cPfsYfBXL/
 6WnDABLfdHKwAeSRHLCpowRY0QFx9Hu+7m47GszORd03Db6mJ+ov4iAX8Pu9GnLB07qrwyhOb
 TZrNhVU05i29yJVNxsgqQSjExzaw9XJXnMkjIdwjW7/STw6aJaJckMp9fMDO+POrpTh75eApg
 VOW4o5dTTwSeNg8em/eTfkIKSQ8dcxYCFVlZ5clHaSUE0LpFnV0CYJ/0s9jq+9qj9ItDi8pXl
 mH6tK3DCugem9CQFGfrjPM0DpUdZluzE5hsXj57NI8xXFnHqrQqi0ltqM85a6vrMZTPl3b6Dr
 XYYQDMe06IwpFwDx1IR3Cwv8kLST+RuyLn8yjD1Yz3DwIDRW6bCenTQgfcMjsz+NbNteQyHjl
 RcqKaVDAq7FzqyvL07KAXgt/py232ibHBD4MNF+gWKxXEJKF0tWOav5CFa6femdgE8t2n2Yxq
 Cu8kEicz+Y0pBx6zREUmTy9qgLql6wMidY+eGmvVnuwkvjFnrO9oTPFRlnrl9/JqO2M2rCIU4
 uMzSvPP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.09.18 17:48, Duy Nguyen wrote:
> On Wed, Sep 5, 2018 at 10:56 AM Tim Schumacher <timschumi@gmx.de> wrote:
>>
>> Aliases can only contain non-alias git commands and their
>> arguments, not other user-defined aliases. Resolving further
>> (nested) aliases is prevented by breaking the loop after the
>> first alias was processed. Git then fails with a command-not-found
>> error.
>>
>> Allow resolving nested aliases by not breaking the loop in
>> run_argv() after the first alias was processed. Instead, continue
>> incrementing `done_alias` until `handle_alias()` fails, which means that
>> there are no further aliases that can be processed. Prevent looping
>> aliases by storing substituted commands in `cmd_list` and checking if
>> a command has been substituted previously.
>> ---
>>
>> This is what I've come up with to prevent looping aliases. I'm not too
>> happy with the number of indentations needed, but this seemed to be the
>> easiest way to search an array for a value.
> 
> You can just make all the new code a separate function, which reduces
> indentation.

That would solve the issue, but I'm not sure if it is worth introducing
a new function exclusively for that. I didn't find anything about a
maximum indentation level in the code guidelines and since the new
parts stay within the width limit (and is imo still readable), would it
be ok to keep it like that?

> 
> There's another thing I wanted (but probably a wrong thing to want):
> if I define alias 'foo' in ~/.gitconfig, then I'd like to modify it in
> some project by redefining it as alias.foo='foo --something' in
> $GIT_DIR/config. This results in alias loop, but the loop is broken by
> looking up 'foo' from a higher level config file instead.
> 
> This is not easy to do, and as I mentioned, I'm not even sure if it's
> a sane thing to do.

The alias system is using the default functions of the config system,
I assume that adding such a functionality is not possible, at least not
without breaking compatibility.

> 
>> +               /* Increase the array size and add the current
>> +                * command to it.
>> +                */
> 
> I think this is pretty clear from the code, you don't need to add a
> comment to explain how the next few lines work. Same comment for the
> next comment block.

I'll remove them in v3.

> 
>> +               cmd_list_alloc += strlen(*argv[0]) + 1;
>> +               REALLOC_ARRAY(cmd_list, cmd_list_alloc);
>> +               cmd_list[done_alias] = *argv[0];
>> +
>> +               /* Search the array for occurrences of that command,
>> +                * abort if something has been found.
>> +                */
>> +               for (int i = 0; i < done_alias; i++) {
>> +                       if (!strcmp(cmd_list[i], *argv[0])) {
>> +                               die("loop alias: %s is called twice",
> 
> Please wrap the string in _() so that it can be translated in
> different languages.

I'll do that in v3 as well.

> 
>> +                                   cmd_list[done_alias]);
>> +                       }
>> +               }
>> +

Thanks for reviewing!

Tim
