Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6356520D09
	for <e@80x24.org>; Sun, 16 Apr 2017 21:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756712AbdDPVZ5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 17:25:57 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:59219 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756700AbdDPVZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 17:25:57 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id zrgAc6AY9HGLwzrgBciWu8; Sun, 16 Apr 2017 22:25:55 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=jQKBkN1mUw8veKzq5ycA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christoph Michelbach" <michelbach94@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <1492287435.14812.2.camel@gmail.com>                 <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>         <1492347718.19687.14.camel@gmail.com>         <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley> <1492368692.22852.9.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout <tree-ish> clearer
Date:   Sun, 16 Apr 2017 22:25:56 +0100
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
X-CMAE-Envelope: MS4wfBhLorgoTXWMDm3Y7ElM32DO2UebhBXUL9q+WS1sqKjg0BqrMKrJJc3TE4Nc9EKI9j8VarL/EFuqxrdiIq3btwbF4Z7epuGIcO0zIpMqFqdGc4aBB7m3
 6wZGSWw/vmnvo4pUc52YOUMxb64Bg516OwrtEwPGEpSiC3d9Moms51SJgjbCgTsegbLMAfLby/RIL6tNUO6W1uBb3w7lRGOw/T4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christoph Michelbach" <michelbach94@gmail.com>
> On Sun, 2017-04-16 at 19:03 +0100, Philip Oakley wrote:
>> From: "Christoph Michelbach" <michelbach94@gmail.com>
>> >
>> > On Sun, 2017-04-16 at 00:28 +0100, Philip Oakley wrote:
>> > >
>> > > From: "Christoph Michelbach" <michelbach94@gmail.com>
>> > > >
>> > > >
>> > > > While technically in the documentation, the fact that changes
>> > > > introduced by a checkout <tree-ish> are staged automatically,
>> > > > was
>> > > > not obvious when reading its documentation. It is now
>> > > > specifically
>> > > > pointed out.
>> > > >
>> > > > Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
>> > > > ---
>> > > > Documentation/git-checkout.txt | 7 ++++---
>> > > > 1 file changed, 4 insertions(+), 3 deletions(-)
>> > > >
>> > > > diff --git a/Documentation/git-checkout.txt
>> > > > b/Documentation/git-checkout.txt
>> > > > index 8e2c066..cfd7b18 100644
>> > > > --- a/Documentation/git-checkout.txt
>> > > > +++ b/Documentation/git-checkout.txt
>> > > > @@ -85,9 +85,10 @@ Omitting <branch> detaches HEAD at the tip of
>> > > > the
>> > > > current branch.
>> > > > from the index file or from a named <tree-ish> (most often a
>> > > > commit). In this case, the `-b` and `--track` options are
>> > > > meaningless and giving either of them results in an error. The
>> > > > - <tree-ish> argument can be used to specify a specific tree-ish
>> > > > - (i.e. commit, tag or tree) to update the index for the given
>> > > Do these lines above actually need reflowing? Their content hasn't
>> > > changed
>> > > making it more difficult to spot the significant changes below
>> > > here.
>> > They're just part of the context of the automatically created patch.
>> The lines with +/- markings are the actual change lines. It's the
>> lines
>> without them that are the context lines.
>>
>> It does sound like an accidental reflow where the "(i.e." moved
>> between
>> lines, and the "paths" moved for the following lines.
>>
>> If reflowing is required it's normal to put it in a separate patch so
>> that
>> each type of change gets its own commit message.
>
> Ah, right. I added a missing "to" and changed "to specify a specific".
>
>
>> > > For a clean commit checkout my mental model is not one of anything
>> > > new
>> > > being
>> > > actively staged i.e. different from what was in the commit.
>> > Note that this is not about something like `git checkout 925b29` but
>> > about
>> > something like
>> > `git checkout 925b29 src`.
>> Yes, that was the part I was getting at.
>>
>> The commit message (and the patch context) doesn't quite give enough
>> to see
>> that is is particular to the -
>>
>> git checkout [-p|--patch] [<tree-ish>] [--] [<paths>…]
>> invocation.
>
> It's: git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

The one I quoted is direct from the Synopsis, which does indicate there are 
potentially more aspects to resolve, such as the influence of using the 
[-p|--patch] options.

It maybe that the paragraph / sentence that needs adjusting is;

'git checkout' with <paths> or `--patch` is used to restore modified or
deleted paths to their original contents from the index or replace paths
with the contents from a named <tree-ish> (most often a commit-ish).

and split it at the "or replace paths" option to pick out your specific 
case.

>
> The paths aren't optional. Added it to the commit message:
>
>
> While technically in the documentation, the fact that changes
> introduced by a `git checkout [-p|--patch] [<tree-ish>] [--]
> <pathspec>...` are staged automatically, was not obvious when
> reading its documentation. It is now specifically pointed out.
>
> Related sentence cleaned up.
>
> Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
> ---
> Documentation/git-checkout.txt | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-
> checkout.txt
> index 8e2c066..cfd7b18 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -85,9 +85,10 @@ Omitting <branch> detaches HEAD at the tip of the
> current branch.
> from the index file or from a named <tree-ish> (most often a
> commit). In this case, the `-b` and `--track` options are
> meaningless and giving either of them results in an error. The
> - <tree-ish> argument can be used to specify a specific tree-ish

Ah yes, "specify a specific" does sound a bit tautological.

> - (i.e. commit, tag or tree) to update the index for the given
> - paths before updating the working tree.
> + <tree-ish> argument can be used to specify the tree-ish (i.e.
> + commit, tag, or tree) to update the index to for the given paths
> + before updating the working tree accordingly. Note that this
> means
> + that the changes this command introduces are staged
> automatically.
> +
> 'git checkout' with <paths> or `--patch` is used to restore modified or
> deleted paths to their original contents from the index or replace
> paths
> -- 
> 2.7.4
>
>
> --
> Christoph
> 

