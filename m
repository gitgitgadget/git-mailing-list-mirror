Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B478520D0A
	for <e@80x24.org>; Sun, 16 Apr 2017 13:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755204AbdDPNCC (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 09:02:02 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34602 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbdDPNCB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 09:02:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id u18so17572384wrc.1
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 06:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oy8KGwqHXArKInN5yef3Xor/k8r6wHdPIP0MSn2En1I=;
        b=k1VZckUS/CbXVIPXgzOPbRLqXmfozuIJjywH9u11pVPmJQ/9pvpW81hz4Nj+Ewy/mQ
         mz2oUtOMLr60golExCDs4/Z3s3Oj1GCqD5A0z9H1CsQzgo+Vv1QOHV8wJW1Bj736UaWs
         fwsJbUh11ZqCDqknEOjmFI99EJSWTQGf7pkBo4/kF9yw8fKKgTvFpIhdUHN3FdUAVG0Y
         JcY+L6ybCLDhPkMkf/iUJ4Ba/Qlymx0mIuSTeUmRd+0fcorrrawnA9RYGrfXARrIDJ54
         pDxxeqJjPgfAdckfFzHv1f2BF/vZV4slznvvFxmjmubL2vNV3Cd/opWRFCHlytVzpJdW
         +4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oy8KGwqHXArKInN5yef3Xor/k8r6wHdPIP0MSn2En1I=;
        b=Czj6ZqgF74z24nywMXeRi4ZF+wOygxdCvGP5Hb/Tz9rRMPmkn7pWE/iuPRsINHiJOG
         APaK7gkw4N8mZgU18rgLugpBjJN7DinnTRx5GYeARepX+u3pGVDCTksPbV8HaUvLEsCB
         vcbdv5RFhCFp4q8hyUNAYlhu7vENDz41eTmIRY0XH3wBSXt08JPtWxXY5OIOn1gu6fQH
         KqEGAz72Lqh/bwItuhCEPHH77SQbAft6oZji4i71J56ii3dOuvLJtAxBwOigsXxLwORk
         Jya37JqgTy+EwNb9FAMg8P/wWMkwtzfBbTiscMOsF93NurFfags1mN7Ti/iMAvrBJlUF
         Xobg==
X-Gm-Message-State: AN3rC/5nZrgkbMo+1iAzWkFjY2eiD5HTd+ewSHy9EbKExl04Jb9bezWr
        q9ca23Qd/Q1pNk4n
X-Received: by 10.223.135.234 with SMTP id c39mr15004625wrc.16.1492347720162;
        Sun, 16 Apr 2017 06:02:00 -0700 (PDT)
Received: from christoph-laptop-16-04-2.fritz.box ([93.211.10.202])
        by smtp.googlemail.com with ESMTPSA id b42sm10267088wra.10.2017.04.16.06.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 06:01:59 -0700 (PDT)
Message-ID: <1492347718.19687.14.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.org>
Date:   Sun, 16 Apr 2017 15:01:58 +0200
In-Reply-To: <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
References: <1492287435.14812.2.camel@gmail.com>
         <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-04-16 at 00:28 +0100, Philip Oakley wrote:
> From: "Christoph Michelbach" <michelbach94@gmail.com>
> > 
> > While technically in the documentation, the fact that changes
> > introduced by a checkout <tree-ish> are staged automatically, was
> > not obvious when reading its documentation. It is now specifically
> > pointed out.
> > 
> > Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
> > ---
> > Documentation/git-checkout.txt | 7 ++++---
> > 1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/git-checkout.txt 
> > b/Documentation/git-checkout.txt
> > index 8e2c066..cfd7b18 100644
> > --- a/Documentation/git-checkout.txt
> > +++ b/Documentation/git-checkout.txt
> > @@ -85,9 +85,10 @@ Omitting <branch> detaches HEAD at the tip of the 
> > current branch.
> > from the index file or from a named <tree-ish> (most often a
> > commit). In this case, the `-b` and `--track` options are
> > meaningless and giving either of them results in an error. The
> > - <tree-ish> argument can be used to specify a specific tree-ish
> > - (i.e. commit, tag or tree) to update the index for the given
> Do these lines above actually need reflowing? Their content hasn't changed 
> making it more difficult to spot the significant changes below here.

They're just part of the context of the automatically created patch.


> > +                               Note that this means
> > + that the changes this command introduces are staged automatically.
> Does this actually capture the intent of the user confusion it's meant to 
> cover? I may have missed the original discussions.

There is no original discussion in this mailing list. I got surprised the command
automatically modified my staging area even though I didn't remember to have read it in
the corresponding man page. Upon reading the relevant part of the man page again, I
noticed that it in fact can be inferred from the half sentence "to update the index for
the given paths before updating the working tree." but it isn't pointed out explicitly.
Doing so doesn't take a lot more text and can avoid such surprises. So yes, if it's
pointed out explicitly, the confusion is removed.


> For a clean commit checkout my mental model is not one of anything new being 
> actively staged i.e. different from what was in the commit.

Note that this is not about something like `git checkout 925b29` but about something like
`git checkout 925b29 src`.


> I can see that 
> if a particular tree is checkout then it's implicit staging could well be a 
> surprise.

And it is actually documented. Just not explicitly mentioned / pointed out.

--
Christoph

