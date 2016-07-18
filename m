Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D2D2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 20:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbcGRUCz (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 16:02:55 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36082 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbcGRUCy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 16:02:54 -0400
Received: by mail-qk0-f170.google.com with SMTP id x1so82769046qkb.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 13:02:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YXlr7x8gQPGeZzhObAdfeCxwMPzrAMJZGXUUJKAowbU=;
        b=MHoIVzewlwwnDKbvlmFGJxMzmw7ZKPVVPHY6brFgWHvS4cgSvimketJBjP7NIhSHPl
         DxImrOlAnhoX7OxZrGlXg8vXsKMMPupJ4rOB5T0Qx7gG1fi5ZekEye0hc0lZG8Yr6q9y
         C2UkYpwJ0PdagskzevRskVNngX2lr/4eyDt+Eq3Xo0AKojyS24m8FRsvipDZszLWETMD
         /tm+7NSRcmQlaQGmPNOSfu4P7YWyMBlD/dJVHZMrVpwXd2dRpGyZcE8PbYekNy+eNznj
         FY0yTf8WXJAU0il2ep5Ndd566DrHHHKneg0RQTuwOE4t2amtb785XXJZj7bGkNg+Rx07
         ZBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YXlr7x8gQPGeZzhObAdfeCxwMPzrAMJZGXUUJKAowbU=;
        b=EdDv0KD379qHOfLpcvYBnsWlyeFaRoKmQSWML7ix6jqLp3NJa7DxC7dJO5CSW8N8uq
         MZl+k5g9EFWaA2sbDykI3tZ0gnzBjlUy8r/r/ztSBHbHxSMK3UYupjH7F2iUZ2gZJFOp
         m05GKL7nJkWD/tCYQv+W+U197QO728nNKJHT+oEr2cM7xkA+6E0+8obhRU7G01WmPAMg
         pqeXEO7SK1DC0HRj6Q/TTogbITNaYI2OD1MBGmsVrdJN8NRfpCuvobnTDspGmyfXLePo
         h8mzwmwYeKgDn52Y5s941ak8w4EOM4gg+azApfh/3CySbNkeQPIx1vU8xai3XlUP4+B/
         f7wg==
X-Gm-Message-State: ALyK8tI+FG5fxWtZG+tM3+Y51Kz574fAiV34JcJpZsxBEJ4NeLFvTHj0O+X09OddnDn05w/EFhuHEjUVSFkTEw==
X-Received: by 10.55.170.141 with SMTP id t135mr47641064qke.112.1468872160798;
 Mon, 18 Jul 2016 13:02:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.36.77 with HTTP; Mon, 18 Jul 2016 13:02:21 -0700 (PDT)
In-Reply-To: <CAPp-Vra5ri7V03SSkU6=UnWrsq-jk0XcNpQuzGH8kQxE-TkPjA@mail.gmail.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <CACBZZX5wjhYosupW=-n7UbbXAQug+sgSNS+jm_uUn6QwC8p6Aw@mail.gmail.com> <CAPp-Vra5ri7V03SSkU6=UnWrsq-jk0XcNpQuzGH8kQxE-TkPjA@mail.gmail.com>
From:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:	Mon, 18 Jul 2016 22:02:21 +0200
Message-ID: <CACBZZX4N37Ty2yZosHA+PexscLc_Y4_QDZNktVM8bza_5cGu+g@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Herczeg Zsolt <zsolt94@gmail.com>
Cc:	Git <git@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 7:48 PM, Herczeg Zsolt <zsolt94@gmail.com> wrote:
>> In particular, as far as I know and as Theodore Ts'o's post describes
>> better than I could[1], you seem to be confusing preimage attacks with
>> collision attacks, and then concluding that because SHA1 is vulnerable
>> to collision attacks that use-cases that would need a preimage attack
>> to be compromised (which as far is I can tell, includes all your
>> examples) are also "broken".
>
> I understand the differences between the collision and preimage
> attacks.

Fair enough. The rest of your E-Mail certainly shows that you do, and
I didn't know enough anything about GitTorrent and this case where
it's vulnerable to collission attacks.

But I didn't get that impression from your initial E-Mail which
outright said said:

    Git signed tags and signed commits are cryptographically
    insecure, they're useless at the moment.

It's important that those of us who *do* understand the difference
between collision and preimage attacks carefully phrase things, least
they turn into FUD.

Your initial E-Mail does *not* make it sound like you're just talking
about the cases where someone's provided you with a crafted blob that
you've been tricked into signing, but rather makes it sound like
signed tags & commits are just categorically broken, even for preimage
attacks, which is not the case.

The reality of the current situation is that it's largely mitigated in
practice because:

a) it's hard to hand someone a crafted blob to begin with for reasons
that have nothing to do with SHA-1 (they'll go "wtf is this garbage?")

b) even in that case it's *very* hard to come up with two colliding
blobs that are *useful* for some nefarious purpose, e.g. a program A
that looks normal being replaced by an evil program B with the same
SHA-1.
