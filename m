Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14F7207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 22:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965992AbcIWW0L (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 18:26:11 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35261 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965693AbcIWW0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 18:26:09 -0400
Received: by mail-io0-f176.google.com with SMTP id m186so132048892ioa.2
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=el+PbecBMkhRIVK89lDLvIN8mL93Pwpvb10qqCqObuI=;
        b=OmigGoYuHitPtUsm/DR/zvPc8DrsCFS0aZs4ysPfoiWXeB4866mbaEHmXoknZaH+qt
         pGR8E0+pCnRbcYK/gZKTpz1o688hxuc0RX3Gh6nNnPVTk8xWkuZN+lOCyegLabPIQRDM
         4PU9Msb7XJG6ywRorVwlDXsBsf2SS4Zq3kD6cTnFZmTpnKoTks5qxVCy0Nz2OxJmTiu1
         uVuFjbzmeupzz0sRbLeSTM2EvOvKwEGfcL6QgOwZy1GiqKMdm8zazf8H3Y7s7vK4NBpu
         DHGdz6F/pQGK9iOsL5/0iqdeoP3GHQA0KSAa/aVMdwTNSfjnzKdJZDaazJqeIT9w/JKt
         nonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=el+PbecBMkhRIVK89lDLvIN8mL93Pwpvb10qqCqObuI=;
        b=J3LJfVD4jEWL+oBtHgWfhB3BNG3JX2jdBXlcdaDbEwKQN/B8MNFnX09rnsWhs5oP5y
         dQPBaWWTUtvhsP1RMkA0PlQzimv4b72rpyA9DtPUvrztIehuwSTKJa5jOy5rb3NfqlS9
         yRzTMXyFvhGA3+Y2qtwpUKeWdn9BwDnXL+uJRm+zVuhSIOy/R2wOtFB1LCnFo3V3T6UK
         mpc/qKgHURkRfMOV5qusNeP1qMtq2ec91kHei4S6zZP2i2ZgkbcjXQ5X9toVnxcuTurN
         yE5HT76fTDn77aUkiklyfcd3kVb2JEv4+4vPiwDucQ0O9WCtljbpMSVXuOqzgJiV/ViW
         druQ==
X-Gm-Message-State: AE9vXwPKvf/tIeEA/JBhVaeLfvn/3YIAZKZZ+9qpItSBKAVoBMdiPkgvgHMZXR00eRipzbCZ60UttUZ/41snFsac
X-Received: by 10.107.59.199 with SMTP id i190mr11500973ioa.18.1474669568016;
 Fri, 23 Sep 2016 15:26:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Fri, 23 Sep 2016 15:26:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1609232305590.129229@virtualbox>
References: <1mu0zrn.cs3kf31kttpjkM%lists@haller-berlin.de> <alpine.DEB.2.20.1609232305590.129229@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Sep 2016 15:26:07 -0700
Message-ID: <CAGZ79kY_5FrMNrEBB19c4tZR+vFz-6uBudDtgVpWosL22mPzGg@mail.gmail.com>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Haller <lists@haller-berlin.de>, Kevin Daudt <me@ikke.info>,
        Anatoly Borodin <anatoly.borodin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2016 at 2:13 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Fri, 23 Sep 2016, Stefan Haller wrote:
>
>> Stefan Beller <sbeller@google.com> wrote:
>>
>> > On Thu, Sep 22, 2016 at 12:48 PM, Kevin Daudt <me@ikke.info> wrote:
>> > > On Thu, Sep 22, 2016 at 07:33:11PM +0000, Anatoly Borodin wrote:
>> > >> Hi Stefan,
>> > >>
>> > >> this section was added to the manual in the commit
>> > >> cddb42d2c58a9de9b2b5ef68817778e7afaace3e by "Jonathan Nieder"
>> > >> <jrnieder@gmail.com> 6 years ago. Maybe he remembers better?
>> > >>
>> > >
>> > > Just to make it clear, this section explicitly talks about 'bugs' with
>> > > preserve-merges and interactive rebase.  Without the --preserve-merges
>> > > option, those operations works as expected.
>> > >
>> > > The reason, as that section explains, is that it's not possible to store
>> > > the merge structure in the flat todo list. I assume this means git
>> > > internally remembers where the merge commit was, and then restores it
>> > > while rebasing.
>> > >
>> > > Changing the order, or dropping commits might then give unexpected
>> > > results.
>> > >
>> >
>> > The commit message may help as well:
>> >
>> >     rebase -i -p: document shortcomings
>> >
>> >     The rebase --preserve-merges facility presents a list of commits
>> >     in its instruction sheet and uses a separate table to keep
>> >     track of their parents.  Unfortunately, in practice this means
>> >     that with -p after most attempts to rearrange patches, some
>> >     commits have the "wrong" parent and the resulting history is
>> >     rarely what the caller expected.
>> >
>> >     Yes, it would be nice to fix that.  But first, add a warning to the
>> >     manual to help the uninitiated understand what is going on.
>>
>> Thanks, but all of this still talks about the issues in very generic
>> terms ("most attempts to rearrange patches"). I'm interested in more
>> details as to exactly what kind of attempts do or don't work. In
>> particular, I'm interested in fixup/squash commands (without reordering
>> anything else), or dropping (non-merge) commits.
>>
>> I could of course experiment with these and try to find out myself, but
>> I was hoping someone would just know the answer off the top of their
>> head, saving me some time.
>
> The fundamental problem here is the underlying design of bolting on the
> "recreate a merge" functionality onto the "pick" command.
>
> That is, if you try to rebase non-linear commit history, it will still
> generate a linear list of "pick <commit-name>" lines, as if it were
> linear, except that it will include the merge commits, too.

Which on a more fundamental design level would be ok.
(C.f. your shell history is a linear list of git commands, but it
deals just fine
with non linear DAGSs)

>
> It then will try to guess what you want to do by recording which commit
> was rewritten as which commit. And when it encounters a "pick" with a
> merge commit, it will try to merge the *rewritten* commit.

Instead of guessing we'd need to differentiate between "pick" and "pickmerge",
whereas the later describes creating commits with more than one parent (i.e.
the prior pick line).

I could imagine the "pickmerge" to list all additional parents (The
first parent being
the previously picked commit) via symbolic naming:

    pick 1234affe implement foo
    pickmerge 3456feed origin/js/new-feature-1 # Merge origin/js/new-feature-1
    pick 45678ead implement feature-2

The "pickmerge" would have first the merge tips, and then the old
subject line after
a # character.

>
> In other words, the design does not allow for changing the tip of any
> merged branch. Not reordering, not dropping.

I see how the current design is problematic as there is no argument
possible that
allows the user to correct the wrong guess.

>
> And I do not think that there is a way to fix that design. That is why I
> came up with the Git garden shears (see the link I sent elsewhere in this
> thread).

I'll look into that.

Thanks,
Stefan
