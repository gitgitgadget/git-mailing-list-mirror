Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14DB91F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeGRSqd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:46:33 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:42707 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeGRSqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:46:32 -0400
Received: by mail-yb0-f181.google.com with SMTP id c10-v6so2194928ybf.9
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBTF4CS2wfI7YBOABxMfOkwT9xDp1LiLh7Cac5GuXXc=;
        b=u2Er/b6A6r3pGSvpzoadM01ryr4TW25+hS9Hhy6D/GG776FFm7eW+Hfkrt5iKXKfzi
         BYCCuJt4UnHRV2saggBhomYBCmzr95KbUaICE0uRZREe0MPnMgGxxlLdVv87CmuQPrw4
         CUsfdTK522hEc32N2j047xcdh6RIaIunussiGN0gqqhfofbhZRRdrPmesxLD8DAIw93D
         WlNk6bk4P3FvuGHjhD+O0ZkgJGj8pwdM9d7cBLfEthMpZeR1xE9cLvWSBFAd17G1Slc/
         JBb3gAx4eJKqikoGUHOeE5Fw/QC0hxjbxGbQDcnMO8N2QN24FMooJGxX4H7+Nqm7SqWD
         XD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBTF4CS2wfI7YBOABxMfOkwT9xDp1LiLh7Cac5GuXXc=;
        b=Dc8D5VUY+0n8ZbuchzbBNU2NQahUhELiem358C4Guq5lJaPim4NEsDhW3ZHd5akQ/X
         bGr50c+ZNrMADD5bYOEdz1qVB1z8m2flPFEIuuKPR5P2UT8C1e4sK9UWnjajwqpUKYnb
         MhquY6F4TwGPK8wxrQzg9Wly45C0rDufh1JSqf9fvAgu+Z//lOl0sfcjf8Dlf89ne6LY
         WXfdbfiKiSko3Zmq7NeSh5X8U/4ya+szwEhXYs94TNjYeyE0kidlxcpi3vhpicWAQ8+C
         3e0cgSTSkESI7rkdyAqq49ZI4J1gaeV53R9v2vafN3go9hlobh3rWmMSVCSBlDkJUaas
         EwKQ==
X-Gm-Message-State: AOUpUlGrCGWLHBTgZqVzZXnb9Dq5oPDjBuVYuHsAHUzigUbl2d53QMz/
        12CN+W5b9zNb19luKL7GBxoGSX9UaklheIcESQsUJhqV7jU=
X-Google-Smtp-Source: AAOMgpf9MRvbcOTBg9amj+yzN7RVwFjnQCJ6zCIJMRGFXRSD3uSbn2mHyEH/3ItMXZycuo8nsto6bVK4zvgozpQttKs=
X-Received: by 2002:a25:b091:: with SMTP id f17-v6mr3693795ybj.167.1531937248377;
 Wed, 18 Jul 2018 11:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180717210915.139521-1-bmwill@google.com> <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <20180718170846.GA17137@google.com>
In-Reply-To: <20180718170846.GA17137@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 11:07:17 -0700
Message-ID: <CAGZ79kZ4HOvo-xaDK=USveJ5zaLdJSddh8XNxsOsFHQuu7KcZQ@mail.gmail.com>
Subject: Re: [RFC] push: add documentation on push v2
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Given the example above for "rebase-on-push" though
> > it is better to first send the packfile (as that is assumed to
> > take longer) and then send the ref updates, such that the
> > rebasing could be faster and has no bottleneck.
>
> I don't really follow this logic.  I don't think it would change
> anything much considering the ref-updates section would usually be
> much smaller than the packfile itself, course I don't have any data so
> idk.

The server would need to serialize all incoming requests and apply
them in order. The receiving of the packfile and the response to the client
are not part of the critical section that needs to happen serialized but
can be spread out to threads. So for that use case it would make
sense to allow sending the packfile first.

> > > +    update = txn_id SP action SP refname SP old_oid SP new_oid
> > > +    force-update = txn_id SP "force" SP action SP refname SP new_oid
> >
> > So we insert "force" after the transaction id if we want to force it.
> > When adding the atomic capability later we could imagine another insert here
> >
> >   1 atomic create refs/heads/new-ref <0-hash> <hash>
> >   1 atomic delete refs/heads/old-ref <hash> <0-hash>
> >
> > which would look like a "rename" that we could also add instead.
> > The transaction numbers are an interesting concept, how do you
> > envision them to be used? In the example I put them both in the same
> > transaction to demonstrate the "atomic-ness", but one could also
> > imagine different transactions numbers per ref (i.e. exactly one
> > ref per txn_id) to have a better understanding of what the server did
> > to each individual ref.
>
> I believe I outlined their use later.  Basically if you give the server
> free reign to do what it wants with the updates you send it, then you
> need a way for the client to be able to map the result back to what it
> requested.  Since now i could push to "master" but instead of updating
> master the server creates a refs/changes/1 ref and puts my changes there
> instead of updating master.  The client needs to know that the ref
> update it requested to master is what caused the creation of the
> refs/changes/1 ref.

understood, the question was more related to how you envision what
the client/server SHOULD be doing here, (and I think a one txn_id per
ref is what SHOULD be done is how this is best to implement the
thoughts above, also the client is ALLOWED to put many refs in one
txn, or would we just disallow that already at this stage to not confuse
the server?)

>
> >
> > Are new capabilities attached to ref updates or transactions?
> > Unlike the example above, stating "atomic" on each line, you could just
> > say "transaction 1 should be atomic" in another line, that would address
> > all refs in that transaction.
>
> I haven't thought through "atomic" so i have no idea what you'd want
> that to look like.

Yeah I have not really thought about them either, I just see two ways:
(A) adding more keywords in each ref-update (like "force") or
(B) adding new subsections somewhere where we talk about the capabilities
  instead.

Depending on why way we want to go this might have impact on the
design how to write the code.

> > > +       * Normal ref-updates require that the old value of a ref is supplied so
> > > +         that the server can verify that the reference that is being updated
> > > +         hasn't changed while the request was being processed.
> >
> > create/delete assume <00..00> for either old or new ? (We could also
> > omit the second hash for create delete, which is more appealing to me)
>
> Well that depends, in the case of a create you want to ensure that no
> ref with that name exists and would want it to fail if one already
> existed.  If you want to force it then you don't care if one existed or
> not, you just want the ref to have a certain value.

What I was trying to say is to have

    update = txn_id SP (modifier SP) action
    modifier = "force" | "atomic"
    action = (create | delete | update)
    create = "create" SP <hash>
    update = "update" SP <hash> SP <hash>
    delete = "delete" SP <hash>

i.e. only one hash for the create and delete action.
(I added the "atomic" modifier to demonstrate (A) from above, not needed here)

> >
> > > +       * Forced ref-updates only include the new value of a ref as we don't
> > > +         care what the old value was.
> >
> > How are you implementing force-with-lease then?
>
> Currently force-with-lease/force is implemented 100% on the client side,

Uh? That would be bad. Reading 631b5ef219c (push --force-with-lease: tie
it all together, 2013-07-08) I think that send-pack is done server-side?

> this proposal extends these two to be implemented on the server as well.
> non-forced variant are basically the "with-lease" case and "force" now
> actually forces an update.

I think we have 3 modes:
(1) standard push, where both client and server check for a fast-forward
(2) "force" that blindly overwrites the ref, but as that has a race condition
    in case multiple people can push to the remove we have
(3) "with-lease", disables the fast forward check both on client and server
    but still takes out a lock on the server to ensure no races happen

Now you propose to have only 2, making (1) and (3) the same, deferring
the check to have "fast forwards only" to be client only?
The server surely wants to ensure that, too (maybe you need
special permission for non-ff; depends on the server implementation).

I am not sure I like it, as on the protocol level this indeed looks the same
and the server and client need to care in their implementation how/when
the ff-check is done. Though it would be nice for the client UX that you
need to give a flag to check for ff (both client and server side? or can we rely
on the client alone then?)

> > > +             (delim-pkt | flush-pkt)
> > > +
> > > +    unpack-error = PKT-LINE("ERR" SP error-msg LF)
> > > +
> > > +    ref-update-status = *(update-result | update-error)
> > > +    update-result = *PKT-LINE(txn_id SP result LF)
> > > +    result = ("created" | "deleted" | "updated") SP refname SP old_oid SP new_oid
> > > +    update-error = PKT-LINE(txn_id SP "error" SP error-msg LF)
> >
> > Can we unify "ERR" and "error" ?
>
> No, these are very different.  You could have one ref update succeed
> while another doesn't for some reason, unless you want everything to be
> atomic.

I did not mean to unify them on the semantic level, but on the
representation level, i.e. have both of them spelled the same,
as they can still be differentiated by the leading txn id?


Thanks,
Stefan

P.S.: another feature that just came to mind is localisation of error messages.
But that is also easy to do with capabilities (the client sends a capability
such as "preferred-i18n=DE" and the server may translate all its errors
if it can.

That brings me to another point: do we assume all errors to be read
by humans? or do we want some markup things in there, too, similar to
EAGAIN?
