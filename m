Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE381F597
	for <e@80x24.org>; Tue, 17 Jul 2018 23:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeGRAAo (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 20:00:44 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35207 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeGRAAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 20:00:44 -0400
Received: by mail-yb0-f193.google.com with SMTP id x15-v6so1124641ybm.2
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OzRIzEa86b4qiYYBu6J23DkkeQVN8Yzzc/zHDKdcNw=;
        b=B/ozBUHo0D8KZfTNHlgmeyn9ZqHZjolYHRMJIw8V3cnC4f+Rm80P/YTQ/VBgaVAJO6
         6ZleCncaMMkf4H9qPI8QEEI9Ct8opftD2Gfi/v+6NSMkXIDmb96CpJzAOBkuP1j9bcT8
         d700+T5dFnpA4UvB3sl/huQo2IepTCXg0psQsEaOZ3RtvkL/nfhDkSDAzCmegVzJrCVf
         MJNv5lEJXvh+alsBHI1uhJgE4X6wbIqGIiREvpKKkiKQdqIRVw2kmHfGYLaLDelVUP36
         QWQXUbjLuq88mMRegrHbQLT1c/MKjRnB2BlBsIIyI82HBt86OfUJ2wyX0mKa2PnSKKfU
         NOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OzRIzEa86b4qiYYBu6J23DkkeQVN8Yzzc/zHDKdcNw=;
        b=GgIMU8HrlLHRB04dXcNIIrnWgk0rEp9a6/BCN1Vgk5f2SQrKelCXpbHP9HWw/EnKr4
         YdxfAD9+0nixc33SfJqfSahXOmCeNsw0kkvY/tfcX5Po1V5OnmFXEW9fftG949Q8e6sw
         zN6SE64xAs6DmN6b35piCZOJO251g7xR6J9HAPbb8TeV2cQFMKF68WJq+si3VKzQKamx
         OH7EwPWJLEkVUpQoRqZhPYsnxkupzEVvfiTBI7ff/wS0Y8fy1Bu7TtgVIU8U7xGImN+9
         bFR93snf9GH9r14k6fJYXqaEAXUI/0uF5dB4AXmDKfGBA6dGG3VfqZP7EbyQZq2lB7Gl
         15gA==
X-Gm-Message-State: AOUpUlE/Nrq+WU9S2kJY4CQcRiG5kQLK3rGRsfOg265Zz8LIzXU3mfIG
        mrxawhzGbk9hOBVBBARzN3kfnE0aXNEA+Rd+98o6KY/jTGI=
X-Google-Smtp-Source: AAOMgpeNXHeZ43j5XuY2MhDtKWBGRB3+vm7CduyY7IzN7PeownwhfJR9FA80qt6aoC/SjvCKYRWmxHmTU+nsrkKB2wQ=
X-Received: by 2002:a25:dc47:: with SMTP id y68-v6mr1920556ybe.515.1531869946542;
 Tue, 17 Jul 2018 16:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180717210915.139521-1-bmwill@google.com>
In-Reply-To: <20180717210915.139521-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jul 2018 16:25:35 -0700
Message-ID: <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
Subject: Re: [RFC] push: add documentation on push v2
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 2:09 PM Brandon Williams <bmwill@google.com> wrote:
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> Since introducing protocol v2 and enabling fetch I've been thinking
> about what its inverse 'push' would look like.  After talking with a
> number of people I have a longish list of things that could be done to
> improve push and I think I've been able to distill the core features we
> want in push v2.

It would be nice to know which things you want to improve.

>  Thankfully (due to the capability system) most of the
> other features/improvements can be added later with ease.
>
> What I've got now is a rough design for a more flexible push, more
> flexible because it allows for the server to do what it wants with the
> refs that are pushed and has the ability to communicate back what was
> done to the client.  The main motivation for this is to work around
> issues when working with Gerrit and other code-review systems where you
> need to have Change-Ids in the commit messages (now the server can just
> insert them for you and send back new commits) and you need to push to
> magic refs to get around various limitations (now a Gerrit server should
> be able to communicate that pushing to 'master' doesn't update master
> but instead creates a refs/changes/<id> ref).

Well Gerrit is our main motivation, but this allows for other workflows as well.
For example Facebook uses hg internally and they have a
"rebase-on-the-server-after-push" workflow IIRC as pushing to a single repo
brings up quite some contention. The protocol outlined below would allow
for such a workflow as well? (This might be an easier sell to the Git
community as most are not quite familiar with Gerrit)

> Before actually moving to write any code I'm hoping to get some feedback
> on if we think this is an acceptable base design for push (other
> features like atomic-push, signed-push, etc can be added as
> capabilities), so any comments are appreciated.
>
>  Documentation/technical/protocol-v2.txt | 76 +++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 49bda76d23..16c1ce60dd 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -403,6 +403,82 @@ header.
>                 2 - progress messages
>                 3 - fatal error message just before stream aborts
>
> + push
> +~~~~~~
> +
> +`push` is the command used to push ref-updates and a packfile to a remote
> +server in v2.
> +
> +Additional features not supported in the base command will be advertised
> +as the value of the command in the capability advertisement in the form
> +of a space separated list of features: "<command>=<feature 1> <feature 2>"
> +
> +The format of a push request is as follows:
> +
> +    request = *section
> +    section = (ref-updates | packfile)

This reads as if a request consists of sections, which
each can be a "ref-updates" or a packfile, no order given,
such that multiple ref-update sections mixed with packfiles
are possible.

I would assume we'd only want to allow for ref-updates
followed by the packfile.

Given the example above for "rebase-on-push" though
it is better to first send the packfile (as that is assumed to
take longer) and then send the ref updates, such that the
rebasing could be faster and has no bottleneck.

> +              (delim-pkt | flush-pkt)



> +
> +    ref-updates = PKT-LINE("ref-updates" LF)
> +                 *PKT-Line(update/force-update LF)
> +
> +    update = txn_id SP action SP refname SP old_oid SP new_oid
> +    force-update = txn_id SP "force" SP action SP refname SP new_oid

So we insert "force" after the transaction id if we want to force it.
When adding the atomic capability later we could imagine another insert here

  1 atomic create refs/heads/new-ref <0-hash> <hash>
  1 atomic delete refs/heads/old-ref <hash> <0-hash>

which would look like a "rename" that we could also add instead.
The transaction numbers are an interesting concept, how do you
envision them to be used? In the example I put them both in the same
transaction to demonstrate the "atomic-ness", but one could also
imagine different transactions numbers per ref (i.e. exactly one
ref per txn_id) to have a better understanding of what the server did
to each individual ref.

> +    action = ("create" | "delete" | "update")
> +    txn_id = 1*DIGIT
> +
> +    packfile = PKT-LINE("packfile" LF)
> +              *PKT-LINE(*%x00-ff)
> +
> +    ref-updates section
> +       * Transaction id's allow for mapping what was requested to what the
> +         server actually did with the ref-update.

this would imply the client ought to have at most one ref per transaction id.
Is the client allowed to put multiple refs per id?

Are new capabilities attached to ref updates or transactions?
Unlike the example above, stating "atomic" on each line, you could just
say "transaction 1 should be atomic" in another line, that would address
all refs in that transaction.

> +       * Normal ref-updates require that the old value of a ref is supplied so
> +         that the server can verify that the reference that is being updated
> +         hasn't changed while the request was being processed.

create/delete assume <00..00> for either old or new ? (We could also
omit the second hash for create delete, which is more appealing to me)

> +       * Forced ref-updates only include the new value of a ref as we don't
> +         care what the old value was.

How are you implementing force-with-lease then?

> +    packfile section
> +       * A packfile MAY not be included if only delete commands are used or if
> +         an update only incorperates objects the server already has

Or rather: "An empty pack SHALL be omitted" ?

> +The server will receive the packfile, unpack it, then validate each ref-update,
> +and it will run any update hooks to make sure that the update is acceptable.
> +If all of that is fine, the server will then update the references.
> +
> +The format of a push response is as follows:
> +
> +    response = *section
> +    section = (unpack-error | ref-update-status | packfile)

As above, I assume they ought to go in the order as written,
or would it make sense to allow for any order?

> +             (delim-pkt | flush-pkt)
> +
> +    unpack-error = PKT-LINE("ERR" SP error-msg LF)
> +
> +    ref-update-status = *(update-result | update-error)
> +    update-result = *PKT-LINE(txn_id SP result LF)
> +    result = ("created" | "deleted" | "updated") SP refname SP old_oid SP new_oid
> +    update-error = PKT-LINE(txn_id SP "error" SP error-msg LF)

Can we unify "ERR" and "error" ?

> +    packfile = PKT-LINE("packfile" LF)
> +              *PKT-LINE(*%x00-ff)
> +
> +    ref-update-status section
> +       * This section is always included unless there was an error unpacking
> +         the packfile sent in the request.
> +       * The server is given the freedom to do what it wants with the
> +         ref-updates provided in the reqeust.  This means that an update sent
> +         from the server may result in the creation of a ref or rebasing the
> +         update on the server.
> +       * If a server creates any new objects due to a ref-update, a packfile
> +         MUST be sent back in the response.
> +
> +    packfile section
> +       * This section is included if the server decided to do something with
> +         the ref-updates that involved creating new objects.
> +
>   server-option
>  ~~~~~~~~~~~~~~~
>
> --
> 2.18.0.203.gfac676dfb9-goog
>
