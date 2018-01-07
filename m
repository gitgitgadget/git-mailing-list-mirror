Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40721F404
	for <e@80x24.org>; Sun,  7 Jan 2018 16:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeAGQg3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 11:36:29 -0500
Received: from relay2.telecom.mipt.ru ([81.5.91.6]:48767 "EHLO
        relay2.telecom.mipt.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754055AbeAGQg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 11:36:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by relay2.telecom.mipt.ru (Postfix) with ESMTP id 4836211F9EE;
        Sun,  7 Jan 2018 19:36:26 +0300 (MSK)
X-Virus-Scanned: Debian amavisd-new at relay2.telecom.mipt.ru
Received: from relay2.telecom.mipt.ru ([127.0.0.1])
        by localhost (relay2.telecom.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id M72XBQLt-Mgw; Sun,  7 Jan 2018 19:36:24 +0300 (MSK)
Received: from mail.mipt.ru (mail.mipt.ru [81.5.91.32])
        by relay2.telecom.mipt.ru (Postfix) with ESMTPS id 973A111FF46;
        Sun,  7 Jan 2018 19:36:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mipt.ru; s=mail;
        t=1515342984; i=@mipt.ru;
        bh=vxoSbUkYz/VJ/tEtKDX4XQXCc5wuDeQQ/fUxI7DTQvU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tP/YtH4dTN2tqrONeQP0u0YGde3GnBZccgKdFENv2ZbYTbqpPf8caFdBYH8u57LG4
         ZxK5uXPNRnB0iJKtkq4ylp7lQ7Xe0WqYwo4v8cginqKdagkLisQitPjCTiKsrRbMLE
         xInHJixnF25Qxn3/ZYTW0KY5/N9Z74r3Kaa+fE9E=
Received: from mail.mipt.ru (localhost [127.0.0.1])
        by mail.mipt.ru (Postfix) with ESMTPS id 50641381536;
        Sun,  7 Jan 2018 19:36:21 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.mipt.ru (Postfix) with ESMTP id 430DA381576;
        Sun,  7 Jan 2018 19:36:21 +0300 (MSK)
Received: from mail.mipt.ru ([127.0.0.1])
        by localhost (mail.mipt.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DVR21ZfRx_LJ; Sun,  7 Jan 2018 19:36:21 +0300 (MSK)
Received: from [192.168.0.134] (81.5.104.8.dhcp.mipt-telecom.ru [81.5.104.8])
        by mail.mipt.ru (Postfix) with ESMTPSA id 1721E381536;
        Sun,  7 Jan 2018 19:36:21 +0300 (MSK)
Subject: Re: [PATCH] Fix confusing wording
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
References: <8da9d436-88b9-7959-dd9c-65bdd376bf54@mail.mipt.ru>
 <xmqqincslzvd.fsf@gitster.mtv.corp.google.com>
From:   Ivan Pozdeev <vano@mail.mipt.ru>
Message-ID: <ea302300-6f42-e6f5-16e2-81329a532788@mail.mipt.ru>
Date:   Sun, 7 Jan 2018 19:36:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqincslzvd.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 27.12.2017 22:44, Junio C Hamano wrote:
> Ivan Pozdeev <vano@mail.mipt.ru> writes:
>
>> Not sure if I should add a CVE-2009-0037 reference as well.
> Not in an end-user facing message like this one, I would say.
To me, as an end user, the current message had no meaning at all. It 
even sounds like I'm better off for having an old version 'cuz git tried 
to apply some limitation to the download, and couldn't.
If it had "see <CVE> for more details", I could quickly find out the 
message's real meaning. Currently, I have to `git blame' the source to 
do that -- certainly something that few users would resort to.
>> ---
> Sign off?
https://github.com/native-api/git/blob/master/Documentation/SubmittingPatches
wasn't clear that this is required (TortoiseGit doesn't add it by 
default). Do I need to remake the patch or something?
>> http.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/http.c b/http.c
>> index 215bebe..26b3386 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -802,7 +802,7 @@ static CURL *get_curl_handle(void)
>> get_curl_allowed_protocols(-1));
>> #else
>> warning("protocol restrictions not applied to curl redirects because\n"
>> - "your curl version is too old (>= 7.19.4)");
>> + "your libcurl version is too old (< 7.19.4)");
>> #endif
> Between 'curl' and 'libcurl', the latter certainly is more
> technically correct.  I have a feeling that it would be better to
> spell out ">=" as "requires at least" than replacing it with equally
> cryptic "<" (it is OK to spell it out as "your libcurl version is
> older than minimum required 7.19.4", too).
I don't see how "your version is too old (less that <version>)" is unclear.
Any wording with "required" would be incorrect because a newer version 
isn't really "required", git can work with an older one, too.
> Thanks.
You're welcome :-)

-- 
Regards,
Ivan

