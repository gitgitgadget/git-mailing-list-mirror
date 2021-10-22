Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B370C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172AC61056
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhJVOWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhJVOWt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:22:49 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92948C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:20:31 -0700 (PDT)
Received: from [192.168.3.156] (unknown [92.173.128.58])
        (Authenticated sender: jn.avila@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id E67125FF96
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 16:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1634912429;
        bh=T1DLGxnbOhuo3yqvQu6E5TAnftbkuG2fOlj3OHVHJGw=;
        h=Subject:References:To:From:Date:In-Reply-To:From;
        b=AZ1ssIPlBGjARMhR/4l4uuVtxb8QLl9k+cOO3f5fcw92JqLdb8DuIx/e/nRvqv3xW
         /nlGWXeHru/nxH+yv+jrLCiXsck2yacWjfWE1L5QweJllummuwgr/Fe/Aj3FX+Qs3n
         abDbXHSPrDZkGnNr98qzzymuew9zumS9zd9dpjywkFpW60xZhFBp3BVzyqEuVEQCoU
         92/eS8OsJ1mDHzwxaFN42e1zsOpyESsbrYUW/VjGcMs7RlgFs+U4oEIG3JBglkILv+
         w63YoWRieFHcn/1bQ8218SX5V6KrPv53139ju/6QUXBaPIJ2gexGVnombIXj7X1NtY
         iFaziqzHIL8ew==
Subject: Re: [Summit topic] Documentation (translations, FAQ updates, new
 user-focused, general improvements, etc.)
References: <nycvar.QRO.7.76.6.2110211149000.56@tvgsbejvaqbjf.bet>
To:     git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <1c9adc5d-21ac-f6c6-8a87-959be5420636@free.fr>
Date:   Fri, 22 Oct 2021 16:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2110211149000.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm sorry that my presence at this meeting could have helped a bit for
some subtopics.

Le 21/10/2021 à 13:56, Johannes Schindelin a écrit :
> This session was led by brian m. carlson. Supporting cast: Jeff "Peff"
> King, Ævar Arnfjörð Bjarmason, Taylor Blau, Philip Oakley, Emily Shaffer,
> CB Bailey, and Jonathan "jrnieder" Nieder.
>
> Notes:
>
>  1. Background: answering on StackOverflow, other avenues for user questions,
>     even users from very large companies
>
>  2. How can we improve documentation?
>
>  3. Maybe even think about translating docs such as FAQs
>
>  4. Peff: there’s an effort to translate manpages
>
>     1. brian: Saw an announcement, haven’t seen what came of it

The effort is still ongoing. Unfortunately, there aren't much outputs
from it, only the inclusion on git-scm.com.

A proposition was sent for Debian packages.

I'm open for any help in packaging what's already available for whatever
useful.


For some statistics

* there are 23 po files, "pt_BR" fully translated, "fr" half translated,
"de" one third; most other languages have not really started (the
portion already translated was made automatically for unmodified strings).

* not all pages are included for translation; most porcelain pages
available on git-scm.com are included, but for instance, not the config
parts or the guides. That's already 10,687 source segments and 206,700
source words, which is a volume similar to "Crime and Punishment" by
Dostoyevsky. And it really looks like an punishment for most apprentice
translators willing to start.

In order to lower the barrier to translators, the project is relying on
weblate: https://hosted.weblate.org/projects/git-manpages/translations/
while still retaining a "Developer's Certificate of Origin".


>
>     2. Peff: Some translated pages are live on git-scm.com (a github repo with
>        translations)

For instance, git init manpages is already available in 8 languages.


>
>     3. Ævar: It uses a third-party tool (po4a) that uses gettext by making each
>        paragraph a translated string. So it’s the same workflow as translating
>        code changes

Asciidoc support is "co-developed" in po4a in parallel with the
translation: I fix bugs when they are found in the po files.

>     4. Taylor: https://github.com/jnavila/git-manpages-l10n


If it looks too personal, it can be moved into the git organization.


>
>  5. Philip Oakley: I see manpages used as reference material instead of
>     educational documents
>
>
>     12. In stackoverflow you can see how people answer questions, how much less
>         existing background they assume

Version control is usually already in the culture of most users
(writers, engineers in other fields have come to use them some 10 years
ago). What their questions usually boil down to is: how can I use and
customize git features for my field of expertise. When software editors
include git support in their applications, it is usually with severed
functions and users quickly have to get back to plain git when they want
a little more.

General rules can help start up with a new customization, but at some
point, the customization is specific to the tool. A library of
application oriented customizations, help files and FAQs may be of
interest. Some customizations already exist, sometimes with errors
(meaning the maintainer of the customization has not fully understood
how git works) but they are scattered.



