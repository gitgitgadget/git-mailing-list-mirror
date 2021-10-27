Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18229C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF18861151
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhJ0HEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 03:04:35 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:49702 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240217AbhJ0HEe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 03:04:34 -0400
Received: from [192.168.3.156] (unknown [92.173.128.58])
        (Authenticated sender: jn.avila@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 8537C5FFA1;
        Wed, 27 Oct 2021 09:02:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1635318128;
        bh=nzUlTJ4UUTKBTJeswiJs/4qwIlCLP4QS4KqO8ILprRQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hw0XMYAZ6ZgFv9+X/f6/M8EtqRW/tJ/gOb9t0DAFr8PvwYm9B9QlQ/WWjVNHTLih+
         VKceTNE7t+RKxttR9UmUDYnAJeI0bjy8XIInGxnqULEfR5+8wgFuI6W6TLlMqRWl2e
         LyNczMYTqr92Kf/REzIcvbYG4fe79QKBDPCbgF0Bu2j5AcGpSrcCTnc77BZrubn6sH
         BZSHqLqr8jUFG5X+tUtrHdEHZfN2t5XDgj8epaYSweVYctVorHSEHmLtbCJMeronds
         rFPLMUu4c3V5nCb+JcJMxW81KaFYBkjEXNgDJv6yew84NpPvWX2vLVkgxtBPM2jCfd
         NDuaR627YZo0g==
Subject: Re: [Summit topic] Documentation (translations, FAQ updates, new
 user-focused, general improvements, etc.)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <nycvar.QRO.7.76.6.2110211149000.56@tvgsbejvaqbjf.bet>
 <1c9adc5d-21ac-f6c6-8a87-959be5420636@free.fr>
 <211022.86r1cdjfe2.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <88515746-6c6c-1341-993f-e079d23e67f6@free.fr>
Date:   Wed, 27 Oct 2021 09:02:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <211022.86r1cdjfe2.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22 2021, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 22 2021, Jean-Noël Avila wrote:
> 
>> I'm sorry that my presence at this meeting could have helped a bit for
>> some subtopics.
>>
>> Le 21/10/2021 à 13:56, Johannes Schindelin a écrit :
>>> This session was led by brian m. carlson. Supporting cast: Jeff "Peff"
>>> King, Ævar Arnfjörð Bjarmason, Taylor Blau, Philip Oakley, Emily Shaffer,
>>> CB Bailey, and Jonathan "jrnieder" Nieder.
>>>
>>> Notes:
>>>
>>>  1. Background: answering on StackOverflow, other avenues for user questions,
>>>     even users from very large companies
>>>
>>>  2. How can we improve documentation?
>>>
>>>  3. Maybe even think about translating docs such as FAQs
>>>
>>>  4. Peff: there’s an effort to translate manpages
>>>
>>>     1. brian: Saw an announcement, haven’t seen what came of it
>>
>> The effort is still ongoing. Unfortunately, there aren't much outputs
>> from it, only the inclusion on git-scm.com.
>>
>> A proposition was sent for Debian packages.
>>
>> I'm open for any help in packaging what's already available for whatever
>> useful.
>>
>>
>> For some statistics
>>
>> * there are 23 po files, "pt_BR" fully translated, "fr" half translated,
>> "de" one third; most other languages have not really started (the
>> portion already translated was made automatically for unmodified strings).
>>
>> * not all pages are included for translation; most porcelain pages
>> available on git-scm.com are included, but for instance, not the config
>> parts or the guides. That's already 10,687 source segments and 206,700
>> source words, which is a volume similar to "Crime and Punishment" by
>> Dostoyevsky. And it really looks like an punishment for most apprentice
>> translators willing to start.
>>
>> In order to lower the barrier to translators, the project is relying on
>> weblate: https://hosted.weblate.org/projects/git-manpages/translations/
>> while still retaining a "Developer's Certificate of Origin".
>>
>>
>>>
>>>     2. Peff: Some translated pages are live on git-scm.com (a github repo with
>>>        translations)
>>
>> For instance, git init manpages is already available in 8 languages.
>>
>>
>>>
>>>     3. Ævar: It uses a third-party tool (po4a) that uses gettext by making each
>>>        paragraph a translated string. So it’s the same workflow as translating
>>>        code changes
>>
>> Asciidoc support is "co-developed" in po4a in parallel with the
>> translation: I fix bugs when they are found in the po files.
>>
>>>     4. Taylor: https://github.com/jnavila/git-manpages-l10n
>>
>>
>> If it looks too personal, it can be moved into the git organization.
>>
>>
>>>
>>>  5. Philip Oakley: I see manpages used as reference material instead of
>>>     educational documents
>>>
>>>
>>>     12. In stackoverflow you can see how people answer questions, how much less
>>>         existing background they assume
>>
>> Version control is usually already in the culture of most users
>> (writers, engineers in other fields have come to use them some 10 years
>> ago). What their questions usually boil down to is: how can I use and
>> customize git features for my field of expertise. When software editors
>> include git support in their applications, it is usually with severed
>> functions and users quickly have to get back to plain git when they want
>> a little more.
>>
>> General rules can help start up with a new customization, but at some
>> point, the customization is specific to the tool. A library of
>> application oriented customizations, help files and FAQs may be of
>> interest. Some customizations already exist, sometimes with errors
>> (meaning the maintainer of the customization has not fully understood
>> how git works) but they are scattered.
> 
> I'd very much support this living in-tree just as the po/* directory
> already does. I.e. periodically pulled down.
> 
> There are many OS's that have something like "apt install
> manpages-<lang>", so if we had these available they could be much more
> useful to users.
> 
> E.g. I see I can "apt install manpages-pt", but if you're a Portuguese
> speaker you probably won't chase down some third-party addition of
> Portuguese manpages, and even if they're in Debian other package
> maintainers might not add them if they're not in the "main" package etc.
> 
> What's standing in the way of us treating this in the same way as the
> po/* directory, if anything?
> 

 * I'm using Asciidoctor to process manpages, because it processes
directly the asciidoc source, whereas using the intermediate docbook
stage stops when some included files are missing (very common problem
with such long running translations and included files are not yet
translated).
 * I had understood from my initial presentation that adding this
content to "common" Git was not desirable. The question was more to make
the repo appear under the git organization on GitHub, not a full
integration.

