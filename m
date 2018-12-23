Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DE51F405
	for <e@80x24.org>; Sun, 23 Dec 2018 22:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLWWFu (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 17:05:50 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:36710 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeLWWFu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 17:05:50 -0500
Received: by mail-ed1-f53.google.com with SMTP id f23so8947791edb.3
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=SyVQIR7uBsS9zHuLMxHpqSk8qP+wZAn7zYzMdXRgchY=;
        b=AD2s1W75URBuFqmN+05bRGsQ5xCXirbCkibvwj5q+RAEMuy2nF4OTaS8jlZND8m+/X
         L6Vc8r6g/LP0z8E6+v8CYTbkStDHcm9pQaIz6JAXndP2N9fLaIWDozq5IN4IjMXK6xGH
         m7d19UxFSjp/ss1OlMYTB+7KCEmNoztn2OSVEojA6BcTzA2vGoT7rva57p4smaPomrfy
         UufFXvSgIXw3pQewCLtqHZA6+ZaZxL2dfMuZ7NCzSU0uIzQYqEVif4usCDzT9tiPbxVu
         AMewJhEg2F6sxGiTWQAziUYKfkmba7yJzIGahrYm6SZVELoaCTprOGX/Nsa2eXOWCuVg
         MQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=SyVQIR7uBsS9zHuLMxHpqSk8qP+wZAn7zYzMdXRgchY=;
        b=kNOZU+OOU96rgGyvI7beUFet6S4jAwapsmp37BU0HB1nDRtrUNu+mEe5MQZ8b/QvDF
         yllDeO7khVEP7ikEwORBETSi3upmo9I51BRPv6f+csoQQN7imTzCZG84KNCoagZWA7ps
         PkffOMCIN2CY6XP7aNIg0CrfnNLW10TaULYbKY5J/LtvvhSSQTJROjycF8dgJclNRFRA
         VYcIe12hGqgV+RQYgr6EfO5kGimBfFdy42Rk0oqFCcPZ+bpDVD+5zMJZxuorffVg0EKu
         ulNJXqAy3JS1nk5aCpzIXh0tUaNtV4gdnxU+PNS6VcdpVJmdftezNL+9WDGdRrYP1ZWI
         dDAA==
X-Gm-Message-State: AA+aEWZg9Is1Ct6hDSlchUkNhLFjSWUrEC7EQThk7Mjb44GXYL3KsXRC
        BqAL97ak7VjJ8QcaQZqbFYY=
X-Google-Smtp-Source: AFSGD/U0QWvUDuyg7IbLP5bXWxTqrpqKTFsGQkaGLnJkYSy86p/btWonmt8BAnTvfGXrXp1kapWl9w==
X-Received: by 2002:a17:906:b1b:: with SMTP id u27-v6mr7382113ejg.67.1545602748062;
        Sun, 23 Dec 2018 14:05:48 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id p21sm8399732edr.67.2018.12.23.14.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 14:05:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
Subject: Re: Can git choose perl at runtime?
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com> <20181221234231.GB10611@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181221234231.GB10611@genre.crustytoothpaste.net>
Date:   Sun, 23 Dec 2018 23:05:46 +0100
Message-ID: <87y38few5h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 21 2018, brian m. carlson wrote:

> On Tue, Dec 18, 2018 at 10:09:14PM -0500, John Passaro wrote:
>> I recently submitted my first patch using OSX and found the experience
>> frustrating, for reasons that have come up on the list before,
>> concerning git-send-email and perl dependencies that you need to be
>> root to update.
>>
>> Last seen here:
>> https://public-inbox.org/git/878t55qga6.fsf@evledraar.gmail.com/
>>
>> The struggle is that Mac's package manager Homebrew has opted,
>> apparently with some finality, to no longer support linking to a user
>> perl at build time. PERL_PATH is hard-coded to link to the system
>> perl, which means the user needs sudo to install the SSL libraries
>> required for send-email. So for send-email to work, you need to either
>> sudo cpan or build git yourself. The obvious solution here would be to
>> do /usr/bin/env perl, but in the above message Aevar pointed out
>> pitfalls with that.
>>
>> It seems that choosing perl at compile time necessarily comes with
>> tradeoffs. So I wonder if there is a way we can support choosing a
>> perl at runtime without breaking the existing mechanism of linking to
>> perl at compile time.
>>
>> I'm picturing adding an executable "git-perl" to libexec that checks
>> config core.perlPath and envvar GIT_PERL_PATH, in some order. Having
>> chosen one of these or the build-time PERL_PATH as a last resort, it
>> exec's the correct perl executable.
>>
>> Then relevant scripts (e.g. git-add--interactive, git-send-email)
>> invoke git-perl instead of /usr/bin/perl, and the makefile no longer
>> replaces that with PERL_PATH -- instead that will be used at runtime
>> via git-perl when we can be sure the user does not explicitly prefer
>> something different.
>
> How do git send-email and git svn work in such a case? They depend on
> the Git and Git::SVN modules being in place, so if you use a Perl other
> than the one you built Git with, they won't be present (or they'll be
> present, but potentially with the wrong version).

Yeah this is one of the things I was alluding to in
<87a7l1fx8x.fsf@evledraar.gmail.com>.

We don't ship any C bindings, so our libs end up in
e.g. /usr/share/perl5, some custom-built perls will have that in their
@INC still, no idea if any of this OSX stuff does.

But otherwise we'd either need to give the user a way to override
PERL5LIB (or they can do it themselves...), or better yet continue what
I started in 20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple
make rules", 2017-12-10) and make our perl stuff entirely decoupled from
the system install.

E.g. Linux distros would probably still override that and install our
*.pm stuff in their usual Perl places, but by default we could just have
a libexec/perl directory with all this stuff, and find our libraries
there, then it won't matter if we chainload to a new Perl interpreter,
we'll still find the libs in the same place.

We could also turn RUNTIME_PREFIX on by default, it already fixes this
by proxy.
