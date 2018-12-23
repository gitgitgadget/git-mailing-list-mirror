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
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A1220A1E
	for <e@80x24.org>; Sun, 23 Dec 2018 23:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbeLWXeS (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 18:34:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34278 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeLWXeS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 18:34:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so9045288ede.1
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 15:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BRtVaP7AnrYy10TyeyRWCLw6o8L4EcpllwAMk1qQZcI=;
        b=gkFsMArW3VoCbGd9N3z+d5AuIGV8HcTb299k2heI6H68nMTbF4JJlXuWFX1a3goIZa
         CbLGysQfJ0KwB6L71PzZkWTLRDYmYJwA/yHqGsnDU1MkjUD9S3d+x/VYfIxjT073QyK5
         Sl0KSQUq0PxiFCXv25QeE5sDUypucKmxYkvDRj/2AV3JMNpAWJFl5G8d/vv+8M+LrpSH
         wh4IeDBrM2C63dQSbMgUr8guWq7Si6Zp2kQxCQ2CXyjYtfXBpmLsEsJY2olNqX4TZTY1
         RCt9bOESC3pc9xeP2inxg2yoXmUyTtbxhBDmik5j0qiqMRgThJa/SMr9U2x+CuLI18Xd
         SZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BRtVaP7AnrYy10TyeyRWCLw6o8L4EcpllwAMk1qQZcI=;
        b=L+gsz+H2Br75oTC50Pl8lhHGLdjdLpxWmGOc/iKJGVZ8UryxH59scGYaLkLTl1RZCM
         f2JY5b3xBMCWOVCgQqzC9wDTGqRRiWxDpJblGf/CCReYualQ5RL9f9HKB8faJyxLnU3B
         deXJTHAimY5+59nvHWhVkbFSECHBtM58YZ7J5lZbEyGvjkAUNEu75fWgPaPUQOhj6zFO
         Xza3om3yjsU+BMvxRi4F+WEbeA908Ae0my7VS8IMRnzMiFV6Omd8WyOfHh789zSp2n36
         EmaZll4cC4jgSkKb2uQ2eauHa4zF725ZLmPFSOT2/qkK2aEEfqifEkx/boYh2UxHTqUs
         mhrw==
X-Gm-Message-State: AA+aEWaA0pFcIp4gTxzhsOGUXtHnlfLDiL3SGautGquj/T6jjL80aKDZ
        cBYX1fFvX4z7ytbH7FIqkZc=
X-Google-Smtp-Source: AFSGD/UbhzjJ50eBaDcejfRfxgzZH6Xie6eJ6CfGLjy55jmzNXNXfItnBlITWoM/xYsaIfnZM3/Jzg==
X-Received: by 2002:a50:b205:: with SMTP id o5mr8590134edd.245.1545608054577;
        Sun, 23 Dec 2018 15:34:14 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id i46sm8746648eda.37.2018.12.23.15.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 15:34:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
Subject: Re: Can git choose perl at runtime?
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
        <20181221234231.GB10611@genre.crustytoothpaste.net>
        <87y38few5h.fsf@evledraar.gmail.com>
        <20181223231834.GD26554@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181223231834.GD26554@genre.crustytoothpaste.net>
Date:   Mon, 24 Dec 2018 00:34:12 +0100
Message-ID: <87wonzes23.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 23 2018, brian m. carlson wrote:

> On Sun, Dec 23, 2018 at 11:05:46PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Fri, Dec 21 2018, brian m. carlson wrote:
>> > How do git send-email and git svn work in such a case? They depend on
>> > the Git and Git::SVN modules being in place, so if you use a Perl other
>> > than the one you built Git with, they won't be present (or they'll be
>> > present, but potentially with the wrong version).
>>
>> Yeah this is one of the things I was alluding to in
>> <87a7l1fx8x.fsf@evledraar.gmail.com>.
>>
>> We don't ship any C bindings, so our libs end up in
>> e.g. /usr/share/perl5, some custom-built perls will have that in their
>> @INC still, no idea if any of this OSX stuff does.
>>
>> But otherwise we'd either need to give the user a way to override
>> PERL5LIB (or they can do it themselves...), or better yet continue what
>> I started in 20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple
>> make rules", 2017-12-10) and make our perl stuff entirely decoupled from
>> the system install.
>>
>> E.g. Linux distros would probably still override that and install our
>> *.pm stuff in their usual Perl places, but by default we could just have
>> a libexec/perl directory with all this stuff, and find our libraries
>> there, then it won't matter if we chainload to a new Perl interpreter,
>> we'll still find the libs in the same place.
>
> This wouldn't fix the fact that we still need modules like Net::SMTP,
> Authen::SASL, and IO::Socket::SSL (because these days every provider
> forces TLS on the submission port). Since those are going to come from
> the distributor, letting people override the Perl path to some arbitrary
> path will mean that those modules may not be installed.

Yeah, but my reading (which may be wrong) of John Passaro's E-Mail
upthread
(<CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>)
is that for some users this is the path of least resistance to getting
git-send-email et al working for whatever reason.

I.e. they'd like to install a git version that's compiled against
/usr/bin/perl, and then after the fact ask git to point to some other
better working perl installation with all of the above compiled.

> I also think that the situation you want with relocatable modules is
> only going to be useful for people who custom-install their own Git,
> which is not most people. Nobody shipping a packaged version of Git is
> going to install modules in a custom Git-specific path (since they can't
> be loaded by other software), so everyone who want to use a custom Perl
> will already be compiling a custom Git and can just specify the Perl
> they want to use.

I mean that we could just make RUNTIME_PREFIX our default behavior, it
would simplify things by only carrying one "how do we find stuff" mode,
and in this case nicely solve this whole problem of your custom perl not
having git's perl modules in its @INC (but having everything else,
e.g. Authen::SASL available).

> My concern is, more generally, that this situation is going to lead to
> hard-to-troubleshoot user support issues. I routinely answer questions
> on Stack Overflow and I see all sorts of cases where users who may be
> great programmers but are mostly unfamiliar with Git end up in bad
> situations.
>
> For example, at a previous job, we shipped a newer Git and Perl, which
> were installed in a custom path (so definitely not using relocatable
> modules). If this option were enabled and user used the newer Git, which
> was installed in a custom path, but the system Perl, things would
> definitely be broken, since the system Perl would almost certainly have
> none of the right modules (or, if it did, they'd be grossly out of
> date). A lot of the users who would run into this issue are less
> technical, and so wouldn't know how to fix it.

No comment on this other than: "whoever's itch this actually is and who
picks up my POC patch will need to address this to brian's satisfaction"
:)

> We've traditionally shied away from specifying things like
> "#!/usr/bin/env perl" specifically for this reason: because people will
> often have custom-compiled versions of interpreters that don't meet our
> needs. I'm not seeing how this is significantly different.

Because "#!/usr/bin/env perl" would break git if you were just playing
around with a custom perl for some other reason, e.g. perl web
development. I agree that this wouldn't be acceptable (as see in my
https://public-inbox.org/git/878t55qga6.fsf@evledraar.gmail.com/ that
John linked to).

Whereas what's being proposed here is some way to specifically tell git
via configuration that it should use a runtime configured perl instead
of the compile-time one.
