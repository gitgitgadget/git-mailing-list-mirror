Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171AF1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbcHISgj (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:36:39 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35014 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234AbcHISgi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:36:38 -0400
Received: by mail-it0-f44.google.com with SMTP id u186so19869855ita.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 11:36:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MGkBIUdIItPKlreu5sNlO8mg3RYULbXtTsxsrQxNQ3E=;
        b=J+qTKlhzKKlkdEAB9m5sKEevz5GWpRDRg80sHULI+AFVw9eexqH2288TwOAUDdAGET
         +NIuZVMmoECSSIjvd8Dshc6aAzxpKw6KGDbMwBfA1f5ZBiBdV9LMCF05R9lF/BfTz3jL
         kBT6CwHqcnXDKiDYffiDzaupafpB+YnErQvs9q9NB5OIx+70Tx7CF9Zuc+H/5slVOlTs
         DXqNXsnRqoIezxufxWAt7oMJJtnFnawieyLPgpsxnln7zoNmMG+lcy0c05LjSuKeip7w
         zl2fT/2eImZGZhd9xUYJzRC++DCvkTMjpPZxIV5o+GydaKTJomibkIGHsQn4f6FDjcId
         IFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MGkBIUdIItPKlreu5sNlO8mg3RYULbXtTsxsrQxNQ3E=;
        b=GufsUd55T8+zG4eEOov8mrubn09W53TJisqmV9nDwoSRyktrIc13utToyjdPPrc+Ja
         voMYxT4HxpyffkYuQLTmZtpK9Axpu+1gSzFEVMzhvQ6j2IkjFIGvPEB1D9cMvvEIDT5N
         72q892Pqm17EIWev3475N0PU9iyrSU7Jrwl5gxkte9ugAu6W0fCUxkpcFVYUc4++S5u8
         m81K089UPnuz+0w6S3Z9qKWRK1NYfyZ+oi7xum35mDFbnRW7rBisZyvqsBHSFI5vYK+h
         ulN5SXrAcRJVMPK9DMO9Dmc6H0a3iSzNjKhDQFl1gfweaFsMWjj9pD87t1i8HAGaG476
         gWbA==
X-Gm-Message-State: AEkooutlNgWFdizBo6lxDwXcPhsoeOexDBV0B0K453KYFTDg/uXgpk4nOpzrm7TqGECcy7fdtl4fmMMIYXp50Q==
X-Received: by 10.36.43.88 with SMTP id h85mr27284888ita.57.1470767797123;
 Tue, 09 Aug 2016 11:36:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Tue, 9 Aug 2016 11:36:06 -0700 (PDT)
In-Reply-To: <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com> <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 9 Aug 2016 20:36:06 +0200
Message-ID: <CACsJy8DA7b9EYTDUMA5+kfk2Xg6hQGAuNTa5ghKH3zMiuvTRbw@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 1:20 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Could you elaborate why you would expect quality and/or quantity of
> reviews to suffer? I'm really curious, and I'd be happy to pass your
> feedback along to my colleagues.

Since I have been using github at work for a couple months, I do have
a few complaints if it will ever become the way of reviewing things in
git. Some of these may be covered by other people already (I haven't
read all new mails in this thread yet)

 - Github PRs seem to encourage seeing changes as a whole, not a
separate commits. Or at least it's not so convenient to view separate
commits (e.g. not easy to go to the next commit)

 - The ability to show all outdated comments, in case I want to search
through them.

 - I have a feeling that commits in PRs are sorted by authordate, not
in topological order. The order of commits being committed is
important sometimes.

 - Not showing leading spaces mixing with TABs, or trailing spaces

 - I would love to have all patches numbered so can refer to them as
1/7, 2/5... instead of just short sha1 (and I think you have the
ability to refer to "1/7 of iteration 2", see next bullet point)

 -I guess you can manage multiple iterations of a topic with one
iteration per PR, then linking them together. It would be nicer to
somehow bake the iteration concept directly to a PR so we can switch
between them, or do interdiff. I know, this is more of a improvement
request than complaint because ML is not really better.

 - Offline support would be very nice. I'm only most of the time, but
sometimes I do work on git stuff offline.

 - We lose the integration with ML, I think. Sometimes the user
reports a bug here, then we reply back with a patch. With github, I
guess we reply back with a PR number, then further discussion may go
there, some discussion may still be on ML.

> * It is easy to summon somebody else into the review conversation by
> @-mentioning them. That person immediately can see the whole history of
> the PR. (This is an improvement on the status quo, where a new entrant
> to a conversation might have to dig through the email trash or an email
> archive to see emails that they overlooked before they were added to the
> CC list.)

On the other hand, we can't just CC anybody anymore because we don't
know if they have a github account (or the account name for that
matter). Or does github allow @-ing email addresses too? We record
people's email address, not github account names.

> * It is possible to search old issues and PRs for additional context.
> (Granted, the history of the project from its ML era would have to be
> searched separately.)

To me searching in email is still better. Maybe I haven't fully
explored github search capabilities
-- 
Duy
