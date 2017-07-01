Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E3820209
	for <e@80x24.org>; Sat,  1 Jul 2017 20:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbdGAUZc (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 16:25:32 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34075 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdGAUZc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 16:25:32 -0400
Received: by mail-pf0-f177.google.com with SMTP id s66so82273055pfs.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g8JnZ5AkqtVHvIGmXtuQlgKPKXWtCk8D8f1z7bFi/G0=;
        b=a5Or55sR/IOY0mX8L35uGP0N+ZmLmENtrN33up4uspRXQQuqyHn+thIqAe3HUdnyfc
         oMtoZxSdiyF+6jlo49OEvTwvB3rF3PP/G/J62b7RKJ/PgPQdbs6gt/kmEcEv1PsNnV0R
         UHZAmbPIdcU26YiQE+llMycbcQZ5fo1gmxpzYVB+tgJukrXUANCJ/Fo7tzUP//xZ/ZAe
         RidCM/TX+hJ6oAUNibn2TaPrCBtTzZj8perXiUoIsoeYeczcP5eV738vp84TT13lL8Tl
         DFaIwNoFGPI5dggVyFcZYJ7KqJOJ57xvc+oYXE8iXdQuxNrC4WhREQ+Y1AgHM4dPIFBB
         np1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g8JnZ5AkqtVHvIGmXtuQlgKPKXWtCk8D8f1z7bFi/G0=;
        b=QSl8Bkf7k+vy4d3fLvcLdweq5pvlxbrrjXkyndasmPWiNTXe5Zs2pUgx67smzqDtSW
         cfd1IT5aJ0oZ66DFh3vVIDjvN5B6szeWDFthPSeHbW4HOmIWNumRMyDgwnM+qdtXsBAI
         ImOzNcWV8j0VZkT1HtMg+6X03gRlYoj7yCopdgIZ5dpeJtQOnI9jjAJQ9xnOjMd2bC7l
         D5WSOtwuz//j8WIq6fhKP/DGQrK9kqyFPbeia+tfRLduESrsY2qDLkscnflmyy9924oa
         CL92BGsDTonILZfr0HqUGlNcQ8Vcvlwm5PGwWRYNXNGwa26PrABHDN/qpE+X5aLcRNPq
         b+Dg==
X-Gm-Message-State: AIVw110cPhYjy7vG4NtHNUB/a9/0xyOMlda5LvNyJ0JZ/Ot6Aoiq+85H
        4BgwOe9eGP6qnscakRY=
X-Received: by 10.84.215.138 with SMTP id l10mr2221598pli.165.1498940731373;
        Sat, 01 Jul 2017 13:25:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id y72sm25950664pfk.72.2017.07.01.13.25.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 13:25:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Kohn <dan@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Request for git merge --signoff
References: <CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com>
        <xmqqbmp4nj9u.fsf@gitster.mtv.corp.google.com>
        <CAHv71zJZfG3AGNL_J5KqYiut6AyyNdUyBG-sZ9aZ-zoGVdOr+w@mail.gmail.com>
Date:   Sat, 01 Jul 2017 13:25:29 -0700
In-Reply-To: <CAHv71zJZfG3AGNL_J5KqYiut6AyyNdUyBG-sZ9aZ-zoGVdOr+w@mail.gmail.com>
        (Dan Kohn's message of "Sat, 1 Jul 2017 14:15:57 -0400")
Message-ID: <xmqq7ezroqfa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Kohn <dan@linuxfoundation.org> writes:

> On Sat, Jul 1, 2017 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Dan Kohn <dan@linuxfoundation.org> writes:
>
>>> Could you please add a `--signoff` option to `git merge`?
>
>> The reason why we changed the default for "git merge" to start an
>> editor at around v1.7.10 was because we wanted to encourage people
>> to write log message that more meaningfully documents the change,
>> and adding sign-off is probably in line with that.
>
>> I've done that "commit --amend" on a merge to tweak its message
>> myself number of times, but I have to admit that I never did so for
>> sign-off, but why not? ;-)
>
> I'm not opposed to starting the editor, although ...
> ...
> Even if you turn down my request for a new flag here,...

Was I a bit too oblique?  I said that do think "merge --signoff" is
in line with the latest philosophy, i.e. not rejecting the idea of
add such an option.  IOW, patches welcome (either from you or other
people).

