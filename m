Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC73A20357
	for <e@80x24.org>; Mon, 17 Jul 2017 17:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdGQRzG (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 13:55:06 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34582 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdGQRzE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 13:55:04 -0400
Received: by mail-pg0-f50.google.com with SMTP id 123so10555465pgj.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=j6Vf9LfGW7I5EV1b9+S25GrZWLclSeLik2U10N48Fj4=;
        b=mCzO+LrFX8GagVV2KWAOIsoX5JTrZw7zCpUMrtu2++WqD2PMxYS7BODprhjDx6B8uv
         axktTZ5l4m71mo6k6T1Dsdfj2dINCfJR6DiAau//ccaveYzMt1O61Xx+h6qswmnL6lIE
         4J0a7udWNu/yINToBtcdAW/ZhIj4AsaXtlPfTQ6A00KOkvAl/RjDtaXZLscRjJPMPD0s
         cK+rcujOlaEGzbRChsMwuzqc88rrQes3oWrg8Kbqv+7lxXquvuiQaG9v+AVV6I00Uftl
         t1sdwBwzQvtWm3cEAFtMBd9wwuLgsvlLiY8kqGjqveJG8XVLCKb2JKEbdauq7n2gNkq5
         QjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=j6Vf9LfGW7I5EV1b9+S25GrZWLclSeLik2U10N48Fj4=;
        b=pVvfupMM7LD85IKu8/mb3z9+LayyJ4v837ozwhgIw+7WcLAJu4vJNKe+PwYj0CvbMn
         euGqXBHG5G3k/rEGV1y1bH1UjUXxRdIQoLUbPHh+wpgerV8MxiirROZMcnRPO16Vb0q1
         bPrGOwXeKtuTq7hqKDUR9+rmXsER1iAi9kk0GDcCZXMMTNhyZmdk5dtxALobCJF0V5+C
         Kzpl6HtPkerdOS8ayhyTVopKkzobigbMCWvSdjg5GUg5FUj3txTXxNH0/VrRut+RTXPc
         Ld4Zi5M/7cfq8/s+zqLkTDHv7Eg9uvb6dklgTC26SPAm0dn74suuqd2w3YrXAbHJh96n
         LYjg==
X-Gm-Message-State: AIVw1135BRwWhYmguUPfEoNTJZvhmUx12FxRk3ggDzEttCdbyOvqkCeY
        xvseLw3l5ZlYxiOeuP0=
X-Received: by 10.98.153.196 with SMTP id t65mr20520202pfk.160.1500314102954;
        Mon, 17 Jul 2017 10:55:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id 68sm41857757pfi.69.2017.07.17.10.55.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 10:55:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
        <87iniu2bty.fsf@gmail.com>
Date:   Mon, 17 Jul 2017 10:55:01 -0700
In-Reply-To: <87iniu2bty.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Sat, 15 Jul 2017 13:12:25 +0200")
Message-ID: <xmqqtw2bgd8q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Let's see what *nix does:
>
>     $ rm -rf /tmp/{master,backup}; mkdir /tmp/master && cd /tmp/master && mv /tmp/{master,backup} ; file /tmp/{master,backup}
>
> Similarly to that, when you're on "master" "git branch --move backup"
> could have left you on an orphan branch, but it doesn't, it's the
> equivalent of "mv && cd" in *nix terms.

And with the same analogy,

	mkdir /tmp/master
	cd /tmp/master
	cp -R /tmp/master /tmp/backup
	pwd

would show you that you are still in /tmp/master.  Which is quite
different from what happens with "mv".  So what's your point?

In any case, you already realize that it is a crazy and convoluted
example nobody does in real life to go in to one directory *and*
rename it while you are inside it, don't you?

The reason why I do not think it is wise to move to the backup
branch when you did

	git checkout master
	git branch --copy master backup

is not because of that crazy analogy, though.  It is primarily that
I think one of the major reasons people want to do a "copy" to a
backup is to keep the pre-modification state of a thing that they
may be able to later come back to when it turns out to be needed.
For that workflow, with the above "branch --copy", your user is
planning to make a change that is not usually kept track of by Git
to the "master" branch (perhaps branch.*.description is changed,
perhaps the remote-tracking branch it is set to integrate with is
changed, etc.), but the user is unsuare, and preparing a backup that
can be used with "gir branch -M backup master" to come back to.  

You can do all that even if your "branch --copy" initially takes you
to the "backup" branch you just created, but then the user has to
immediately come back to "master" to start doing the major surgery
on "master", for which the "copy" was a preparation to recover.

> So since our --move is really --move-and-checkout I think it would be
> confusing to introduce a --copy sister option that has the semantics of
> --copy-no-checkout instead of a corresponding --copy-and-checkout.

Our --move is *NOT* --move-and-checkout.

	git chekckout master
	git branch naster
	git branch -m naster aster

will *not* move "naster" to "aster" and check it out.  During the
whole exercise, you will stay on "master".  

When you rename the current branch so that the name of the current
branch will no longer exist in the system, you _could_ detach the
HEAD, or you _could_ move the current branch to the new name.  There
is no sensible alternative other than these two, but either way, you
need to have a special case for renaming the current branch.  It's
just the latter is more useful in practice and that is the only
reason why it moves _you_ along with the current branch if you
happen to be on that branch being renamed.

I do not see much reason why such a special case has to apply to
"copy".  The source of the copy is not going away, and in the
"backup" scenario, moving away from the thing that is backed up, in
preparation for further work that may have to be reverted, is
actively counter-productive.

There however _is_ an opposite use case.  You may want to start
working on a _new_ branch that is more similarly set up to what your
current branch is, _and_ you want the new branch to start at your
current branch.  But I think that should be done by adding an
enhanced mode of "checkout -b".  IOW, I think

	git checkout master
	git checkout -b --with-configuration naster [master]

is a very sensible thing to desire; if "master" is set to integrate
with refs/remotes/origin/master, the new "naster" branch may want to
integrate with refs/remotes/origin/naster (instead of the local
"master", which is what the traditional "checkout -b" would do), for
example.  Or you could do the same thing with

	git branch --copy master naster
	git checkout naster

if your "branch --copy" does not switch out of the current branch.




