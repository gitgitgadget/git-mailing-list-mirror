Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3349C1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 20:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbcFUUmx (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 16:42:53 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36270 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbcFUUmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 16:42:50 -0400
Received: by mail-io0-f171.google.com with SMTP id s63so23289856ioi.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 13:42:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jg9up6n4yVNc9Zd9WKNtb81WDSptrXEYqRyGaqoXedg=;
        b=Zpi5buxNHUFj5IIPM6VKWcfhFaEuvqT+6ra4fcUXMf7K+Wzvf/dEwHcTgqxUv+5wHo
         umuoCgkQHTYyYdEYXKUljha9g1dxWwP5qAncXb7KbNgFYjJU5i4O+B92p3ZzwvpD33Ln
         WyF3L/a9T8DYgiXRrLzF8ab3n5e7EQgCtiEqQ9cHwgV6L8bJ448PkWwKF3fHlo2cUXeo
         Jl7jZ50iDsUYBQcG3JD9AWrg1dhARHPChOuJrZba8s4e/o5ia5symkD8G9eafERyVpsP
         AzVKu8X5jqf8N/mGukqbdMbRvXgk5eG8awQBwmilxOcwlWdNTfCu0kW1xJAWtP33FT/d
         ZF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jg9up6n4yVNc9Zd9WKNtb81WDSptrXEYqRyGaqoXedg=;
        b=eyUcChycTz7C2gyukZci50/ODqpG4SvVhomMDgGbJ7f4viQW9QHZhSQ0218d3hZIu9
         LSZ2M4g1UHIyTkgU0YS7rY0vNuNuf0E87fyh4QxoIVhaRkuVaQm/fG999kcqSIrB699Y
         73SMRd0b0cS5Z4zyH+y9rn/u2AIsuQe/DtD9fSMHoTvJCmkkwSqPIRRc3Joul+XbwpKf
         yX1kcTZJ5+35K8+gfh652WGscftucyET24H2IJvuCPkUNYsJ6FclVciRhAt/hyM4cqCU
         qEUby7F7L9bX38Ky+a2tEJ2N7xiP/KTDBYwsG6eL5osbUnBGcfPFeSQIyLNKAAAIG17l
         apOQ==
X-Gm-Message-State: ALyK8tJilCsFM+dkaiEhn9kS8TjD9FQ0cOh4lYm2b58nbeinwclwRktnuAdSyDhrv3ovyVui7wvXsbwVd00V0Nxe
X-Received: by 10.107.186.196 with SMTP id k187mr35662121iof.173.1466541340940;
 Tue, 21 Jun 2016 13:35:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Tue, 21 Jun 2016 13:35:40 -0700 (PDT)
In-Reply-To: <CAPV8XuZvDkcEwxRB0HwaihVo7QzqsoHTRCdV7sqxkT31-RWkmA@mail.gmail.com>
References: <loom.20160620T145755-931@post.gmane.org> <CAGZ79kZyEzp92JP_Bp2te1XO=PB0+fwFn57MrBPuWe25PQKOog@mail.gmail.com>
 <CAPV8XuZvDkcEwxRB0HwaihVo7QzqsoHTRCdV7sqxkT31-RWkmA@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 21 Jun 2016 13:35:40 -0700
Message-ID: <CAGZ79kYvMjDaPnet1J_QrHARYtNqLwRhs7f08cDZ7P6dT8Rs6A@mail.gmail.com>
Subject: Re: Problem with --shallow-submodules option
To:	Istvan Zakar <istvan.zakar@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 11:32 PM, Istvan Zakar <istvan.zakar@gmail.com> wrote:
> Hi,
>
> Thanks for the answer.
> So it means that it is a setting on the server side which can be
> activated? (I guess it depends on the version of the server)
> I did some reading in the topic. Are you talking about this setting
> "uploadpack.allowReachableSHA1InWant", or did I misunderstood what I
> read?

No that's exactly what I meant; sorry for not spelling that out.

Thanks,
Stefan

>
> Thanks,
>     Istvan
>
> On 20 June 2016 at 19:45, Stefan Beller <sbeller@google.com> wrote:
>> On Mon, Jun 20, 2016 at 6:06 AM, Istvan Zakar <istvan.zakar@gmail.com> wrote:
>>> Hello,
>>>
>>> I'm working on a relatively big project with many submodules. During
>>> cloning for testing I tried to decrease the amount of data need to be
>>> fetched from the server by using --shallow-submodules option in the clone
>>> command. It seems to check out the tip of the remote repo, and if it's not
>>> the commit registered in the superproject the submodule update fails
>>> (obviously).
>>
>> Yes that is broken as the depth of a submodule is counted from its own HEAD
>> not from the superprojects sha1 as it should.
>>
>> So it does
>>
>>     git clone --depth=1 <submodule-url> <submodule-path>
>>
>>     if HEAD != recorded gitlink sha1,
>>         git fetch <recorded gitlink sha1>
>>
>>     git checkout <recorded gitlink sha1>
>>
>>> Can I somehow tell to fetch that exact commit I need for my
>>> superproject?
>>
>> Some servers support fetching by direct sha1, which is what we make use
>> of here, then it sort-of works.
>>
>> If the server doesn't support the capability to fetch an arbitrary sha1,
>> the submodule command fails, with a message such as
>>
>>     error: no such remote ref $sha1
>>     Fetched in submodule path '<submodule>', but it did not contain
>> $sha1. Direct fetching of that commit failed.
>>
>> So if it breaks for you now, I would suggest not using that switch, I
>> don't think there is a quick
>> workaround.
>>
>>>
>>> Thanks,
>>>    Istvan
>>
>> Thanks,
>> Stefan
>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
