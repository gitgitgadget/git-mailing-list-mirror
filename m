Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B611F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfGYRmP (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:42:15 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:33195 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfGYRmO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:42:14 -0400
Received: by mail-lj1-f172.google.com with SMTP id h10so48829401ljg.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1hrBWe2QTMuv44fqYzrQYm8nidKLO+0Nt4tC0CFGT5Q=;
        b=i6r6DSaMAgqeCuw1OXxv8cRtPDTpI3oqfxbNmudRL2gVKutK2t2fosbDHzvItaah3R
         kQ3g0WffCHhkWCdb7bVYH754qXxK+O+fCrr1xhay6M4w6TcwA84BgCWYH7qTDtTQj4dX
         qrNqHxyaT/8+u6U8seIM6jyhy75QeqMiCDSCp8BPGaIs6/NJtlA8LQVTd/4rJzyPLK29
         ZootpE7I4VL1dIhcLxd6l8qVn6sVaNEIEaaqeCUUpffAWDVj71S/XHV2KGwXi5AEbOfp
         5dnsT1yvPso/PO6EIDyHeTI79FQWw/oZaFeZZfT2mnPrn3/E9SyrLUfWuXZJY1LMiD4d
         HLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1hrBWe2QTMuv44fqYzrQYm8nidKLO+0Nt4tC0CFGT5Q=;
        b=sdVtO0aWzWFA8vXdPgD0LeHFi5kdIL8NCGsRHJBxn+o0F2w0HXumRF9j0MCQ+Jiait
         JADisD0C5P6Q6+rZw2v4qFmM7MNkphFrNia/b4C8Q6KNVfmW3iPZhxS6z9G/yeOkYru6
         QaF+BS3h8hjSS60FYlRBqa4lQsUrUwYHIhPqAA23aM2guJRXHXHEOjDOsbVNbmTVkby3
         E63GSCvzzLiGKrB3di0dCzqS9XPcjfnqTVXpHD55I4Y6vPDcSGbrGtPBvpTezUSgv/1P
         +VyNMji8PFi2y/nLNn9wH9EWj/Hhc87KAVTy1pRMahK8rpCv8fPAh0UsabiYTED139iQ
         Ex+A==
X-Gm-Message-State: APjAAAUgFjXczaELtQvSv6IfZWU5LI4kx77Y8KpqC+iuIfgBC+44oPLg
        9NwQFhghHOCGqGgipPIGjOWheKVnlwWCZg==
X-Google-Smtp-Source: APXvYqzjlvEyf8yXZyezvRkkZ73gtxWCT0k7bkJSATIxiWJ+peiAjs49rKZEJM8tmGTr99zD2YsQRA==
X-Received: by 2002:a2e:a16c:: with SMTP id u12mr44790458ljl.59.1564076533064;
        Thu, 25 Jul 2019 10:42:13 -0700 (PDT)
Received: from [192.168.2.33] ([109.197.31.38])
        by smtp.gmail.com with ESMTPSA id w21sm7679608lfl.84.2019.07.25.10.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 10:42:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [git for translators] How to always generate conflicts for
 merges?
From:   Ilya Kantor <iliakan@gmail.com>
In-Reply-To: <xmqqtvbaoysd.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 25 Jul 2019 20:42:09 +0300
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <15314A71-8121-428D-A62D-08E1C1AC0E1B@gmail.com>
References: <C9A27ED4-CBD9-4FCD-B78F-8A1010D24D06@gmail.com>
 <xmqqtvbaoysd.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

There's a repo for each language, with the same file structure.

For example, English version (upstream):
=
https://github.com/javascript-tutorial/en.javascript.info/blob/master/1-js=
/01-getting-started/1-intro/article.md

Japanese:
=
https://github.com/javascript-tutorial/ja.javascript.info/blob/master/1-js=
/01-getting-started/1-intro/article.md

As English version is updated, changes need to be delivered to =
translations.
That's done with "git pull upstream master" from translations.

As the text structure (paragraphs) is the same, usually merges give =
conflicts exactly in the places where English version changed.

Sometimes though, e.g. when a new chapter is added to upstream, the =
merge just goes through "successfully".

That's what I'd like to avoid, as all changes need to be =
human-controlled.

---
Ilya Kantor
https://javascript.info

> On 25 Jul 2019, at 19:37, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Ilya Kantor <iliakan@gmail.com> writes:
>=20
>> We're using Git to manage translations of an open-source book, and
>> most of time it works well. But there's also a problem.
>>=20
>> When we pull changes from upstream (English) to translation
>> (e.g. Japanese), git auto-merges them.
>>=20
>> Sometimes there conflicts, but not all the time.
>>=20
>> For example, when a new file is added to English, it just gets
>> auto-merged into Japanese.  But all new changes must be
>> human-controlled, translated.
>>=20
>> Is there a way to force git always generate a conflict, even if
>> changes could be auto-merged?
>=20
> I am not sure what the workflow here and if it makes sense.  When
> you have a file, "chapter47.txt", whose original is in English, the
> translation projects (there are N of them, one for each language)
> will have their own "chapter47.txt" that has translated text in the
> same place?  It looks to me that, working that way, the project for
> translating into e.g. Japanese have no way to keep any of the
> original English version, in which case why are you even "merging"
> the English version in the first place?
>=20
> I would have understood if the original "chapter47.txt" is translated
> into "chapter47_ja.txt" and friends, like "chapter47_fr.txt", all of
> which sit next to the original "chapter47.txt".  Then merging an
> updated version of the original from time to time would make perfect
> sense to me---that would give you a way to see what changed in the
> original (e.g. "git show --first-parent -m -p master chapter47.txt")
> to guide you find the places you would need to make corresponding
> changes to the variant of your language, e.g. "chapter47_??.txt".
>=20

