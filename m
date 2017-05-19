Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75802023D
	for <e@80x24.org>; Fri, 19 May 2017 14:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdESOfi (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 10:35:38 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:58487 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdESOfh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 10:35:37 -0400
Received: from [192.168.2.240] ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id Bj0AdXU78gKstBj0BdqpQu; Fri, 19 May 2017 15:35:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495204535; bh=Ac5sqt2gDDdvTog56zd/ROPZLwgB/tOM4U57QjUF2Yo=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iI65IfYuJdj6K3QdkApOYdI/SNx747CIdsxro5srI1A8urtHwXRP+orbc1NGFewJK
         j0QhUFyI46VImjWWTjaxKfdNutRm4Q741DEG8B76Lz0fiGzuc9PZD6WoIjj8XQPPKN
         1eJCMzvEkKkFSYvB4DzREwjtmWrcjzHXcIL3J2iA=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=2k7HBh22tWAeqlqzya8A:9 a=DlOjBtYJaRt2OZ_J:21
 a=OHclPLkPwnzoH1Jg:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: Add missing newline to end of message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <20170518134154.12771-1-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1705182321030.3610@virtualbox>
 <406d017b-b138-72db-d5ad-14ccf5d1f3d4@talktalk.net>
 <CACBZZX5yyD-EA0obHKGGueUgf4xO9o=sBAsBOrrPipx3vNPmsA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a0912474-0d79-df10-80a8-5866398926a2@talktalk.net>
Date:   Fri, 19 May 2017 15:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX5yyD-EA0obHKGGueUgf4xO9o=sBAsBOrrPipx3vNPmsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFF3+J2bZsaw+uIJWk9CkiMkuMRar498YuOpOKfl/c6pvG4IJV58nvyEihxOirhSWS2DivlekDIQmUcWH5vb0+1Dfau0gT9Rn+u1AoiHa6hsIA8C9khN
 CjZPizMzWAKfflgils42+esupdfU/OYDEKJk5ulOECZwr8RMGXR/HJw4ILKpjcgwBVF8MB57r72QiH9nman3EZ4JjrB35vBITSVWXHGSbZEu+V0rgBi+jXwC
 9UwyzfXR5/kEXc2HBNacg2Ete3rLGpsyqftGx5dH13OaemgBxAxz45flioMRaQq0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/05/17 12:24, Ævar Arnfjörð Bjarmason wrote:
> On Fri, May 19, 2017 at 12:13 PM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
>> On 18/05/17 22:21, Johannes Schindelin wrote:
>>> Hi Phillip,
>>>
>>> On Thu, 18 May 2017, Phillip Wood wrote:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> The message that's printed when auto-stashed changes are successfully
>>>> restored was missing '\n' at the end.
>>>> ---
>>>
>>> Please add your Signed-off-by:, and my Acked-by:
>>
>> Will do (I forgot to add --signoff to git commit). Do I need to resend
>> the other patches with your Acked-by: or will that happen when Junio
>> applies them?
>>
>> I was thinking about this last night and wonder if it would be better to do
>>
>> -               printf(_("Applied autostash."));
>> +               printf("%s\n", _("Applied autostash."));
>>
>> rather than
>>
>> -               printf(_("Applied autostash."));
>> +               printf(_("Applied autostash.\n"));
>>
>> as it would avoid changing the translated string and also mean that the
>> newline couldn't be accidentally removed any typos in the translation.
>>
>> Best Wishes
>>
>> Phillip
> 
> Just having the \n in the message is fine. Stuff like this is already
> checked for as part of the build process by msgfmt, e.g.:
> 
>      $ git diff -U0
>      diff --git a/po/de.po b/po/de.po
>      index 679f8f4720..b9a7d417ac 100644
>      --- a/po/de.po
>      +++ b/po/de.po
>      @@ -23 +23 @@ msgid "hint: %.*s\n"
>      -msgstr "Hinweis: %.*s\n"
>      +msgstr "Hinweis: %.*s"
> 
> Errors with:
> 
>      po/de.po:23: 'msgid' and 'msgstr' entries do not both end with '\n'
> 
> And if you change the format specifier:
> 
>      po/de.po:23: number of format specifications in 'msgid' and
> 'msgstr' does not match
> 
Hi Ævar

Thanks for clarifying that, I've left the patch unchanged

Thanks again

Phillip
