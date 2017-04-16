Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BD920D09
	for <e@80x24.org>; Sun, 16 Apr 2017 18:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756599AbdDPSDM (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 14:03:12 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:36527 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756258AbdDPSDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 14:03:10 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id zoVvcePxi0KuvzoVvccHtM; Sun, 16 Apr 2017 19:03:08 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=o7m9u0tXK3e188W8vv0A:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christoph Michelbach" <michelbach94@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <1492287435.14812.2.camel@gmail.com>         <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley> <1492347718.19687.14.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout <tree-ish> clearer
Date:   Sun, 16 Apr 2017 19:03:08 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDuu6HUO+DjkabpkrBJb4RJ4CJx2n/wRKe4yDS4ntyGTV0ZQvMxCGUDpvP5T5+0AbN8PCgwXBV0Bh4cc4E1p3bW+gSmJYVvdZKWRJ4mhNhjNqOPv1gvz
 m4hgo6oWOLs/g2YGPZLOb2PiS+f65syDnzT0FniW6d19F4TxFpEfp4i8AurpUrFVa3xJ6qslFMY/ZWH/rr6Ra0spgtuP52cdJ4A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christoph Michelbach" <michelbach94@gmail.com>
> On Sun, 2017-04-16 at 00:28 +0100, Philip Oakley wrote:
>> From: "Christoph Michelbach" <michelbach94@gmail.com>
>> >
>> > While technically in the documentation, the fact that changes
>> > introduced by a checkout <tree-ish> are staged automatically, was
>> > not obvious when reading its documentation. It is now specifically
>> > pointed out.
>> >
>> > Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
>> > ---
>> > Documentation/git-checkout.txt | 7 ++++---
>> > 1 file changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Documentation/git-checkout.txt
>> > b/Documentation/git-checkout.txt
>> > index 8e2c066..cfd7b18 100644
>> > --- a/Documentation/git-checkout.txt
>> > +++ b/Documentation/git-checkout.txt
>> > @@ -85,9 +85,10 @@ Omitting <branch> detaches HEAD at the tip of the
>> > current branch.
>> > from the index file or from a named <tree-ish> (most often a
>> > commit). In this case, the `-b` and `--track` options are
>> > meaningless and giving either of them results in an error. The
>> > - <tree-ish> argument can be used to specify a specific tree-ish
>> > - (i.e. commit, tag or tree) to update the index for the given
>> Do these lines above actually need reflowing? Their content hasn't
>> changed
>> making it more difficult to spot the significant changes below here.
>
> They're just part of the context of the automatically created patch.

The lines with +/- markings are the actual change lines. It's the lines
without them that are the context lines.

It does sound like an accidental reflow where the "(i.e." moved between
lines, and the "paths" moved for the following lines.

If reflowing is required it's normal to put it in a separate patch so that 
each type of change gets its own commit message.
>
>
>> > + Note that this means
>> > + that the changes this command introduces are staged automatically.
>> Does this actually capture the intent of the user confusion it's meant to
>> cover? I may have missed the original discussions.
>
> There is no original discussion in this mailing list. I got surprised the
> command
> automatically modified my staging area even though I didn't remember to
> have read it in
> the corresponding man page. Upon reading the relevant part of the man page
> again, I
> noticed that it in fact can be inferred from the half sentence "to update
> the index for
> the given paths before updating the working tree." but it isn't pointed
> out explicitly.
> Doing so doesn't take a lot more text and can avoid such surprises. So
> yes, if it's
> pointed out explicitly, the confusion is removed.
>
>
>> For a clean commit checkout my mental model is not one of anything new
>> being
>> actively staged i.e. different from what was in the commit.
>
> Note that this is not about something like `git checkout 925b29` but about
> something like
> `git checkout 925b29 src`.

Yes, that was the part I was getting at.

The commit message (and the patch context) doesn't quite give enough to see 
that is is particular to the -

git checkout [-p|--patch] [<tree-ish>] [--] [<paths>…​]invocation.

>> I can see that
>> if a particular tree is checkout then it's implicit staging could well be 
>> a
>> surprise.

> And it is actually documented. Just not explicitly mentioned / pointed 
> out.

It maybe worth thinking a bit more about how such a mental model may happen.

To those in the know it sounds obvious that the path content replaces the 
old path. It's that this implies a *change* within the commit that may not 
be.

Explaining that it at the heart of the documentation change.

> > --
> Christoph
> >
--
Philip 

