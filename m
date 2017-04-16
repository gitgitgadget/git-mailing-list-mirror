Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F95120D09
	for <e@80x24.org>; Sun, 16 Apr 2017 18:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756616AbdDPSvi (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 14:51:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34972 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756557AbdDPSvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 14:51:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id l44so18115469wrc.2
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6cWIjVI91lnlmnwJCl5mHiuNiaQr9053/cox0c3JXFw=;
        b=D34+BWAz68uB4l7zHV4Py0O6itOCjl8Dbzk31Erk06OPVELfmahlkcD36HndudOa+n
         yWRU1BBEj5lYe4GczV4WQdkCkYci1/wltX8Qw34CsbSXgCzUIyPLe/HJ39+J0LGGwHp0
         zSafFBM4XpoVEpxUsUrS+cZqmLHXCp4OxZdKI/FQU78o8SyY1FEEkI/XIFf+/NvxlW5D
         ZuQNrge4GZiNXoHuxmZUt4WsEw2+UMKkoSckx9axD4ieKkT+tm/RaqVq7O/OAogJJtfb
         Ey3XPbvrKEVY4icoZa0tk6RpbqrZD+ypAYnzWJsfPc6tobH4WaMvMw/6haqTOhqtkcb5
         JSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cWIjVI91lnlmnwJCl5mHiuNiaQr9053/cox0c3JXFw=;
        b=I7nHnd6bAyuMGAmAGkIfAT+58Uw0Cclh19qKHxjEGlFqd42+t6gKTzOE1j0d/0faLS
         NW54fLsVOHzSbmGKHYLWVCb/NLWdE3bpzZKUIQSKF2YZ0njbP55WSfo/Sd57ST7MoMhn
         0DIPH3oI5s/8UjonDSVLol1FznnqPYDXzDe9Dr65gR3SrAqT77S3lo15Hv+OIKuyJKvt
         7fhueVSUYZ+ElJNrJzUYzTlqpNLk5qC8Aig2FxnEj4n+YGNWPl/8kALe/MQI2jd6DNNF
         Heyto5wEhAnyNa51Nc025uSOF1AmVa8uc0GeDKYrObbRto5MwzjvGK2l7bX43gbcA8FJ
         xM+Q==
X-Gm-Message-State: AN3rC/5gAT5cqn8F2y+CcN8jjSuY1zd1pgeNHiixQos8GSJ6u2f9FyP1
        gVFN8pTF46QRPSks
X-Received: by 10.223.142.45 with SMTP id n42mr17432667wrb.131.1492368695068;
        Sun, 16 Apr 2017 11:51:35 -0700 (PDT)
Received: from christoph-laptop-16-04-2.fritz.box (p5DD30ACA.dip0.t-ipconnect.de. [93.211.10.202])
        by smtp.googlemail.com with ESMTPSA id e202sm7386966wmf.16.2017.04.16.11.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 11:51:34 -0700 (PDT)
Message-ID: <1492368692.22852.9.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Date:   Sun, 16 Apr 2017 20:51:32 +0200
In-Reply-To: <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
References: <1492287435.14812.2.camel@gmail.com>
                 <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
         <1492347718.19687.14.camel@gmail.com>
         <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-04-16 at 19:03 +0100, Philip Oakley wrote:
> From: "Christoph Michelbach" <michelbach94@gmail.com>
> > 
> > On Sun, 2017-04-16 at 00:28 +0100, Philip Oakley wrote:
> > > 
> > > From: "Christoph Michelbach" <michelbach94@gmail.com>
> > > > 
> > > > 
> > > > While technically in the documentation, the fact that changes
> > > > introduced by a checkout <tree-ish> are staged automatically,
> > > > was
> > > > not obvious when reading its documentation. It is now
> > > > specifically
> > > > pointed out.
> > > > 
> > > > Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
> > > > ---
> > > > Documentation/git-checkout.txt | 7 ++++---
> > > > 1 file changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Documentation/git-checkout.txt
> > > > b/Documentation/git-checkout.txt
> > > > index 8e2c066..cfd7b18 100644
> > > > --- a/Documentation/git-checkout.txt
> > > > +++ b/Documentation/git-checkout.txt
> > > > @@ -85,9 +85,10 @@ Omitting <branch> detaches HEAD at the tip of
> > > > the
> > > > current branch.
> > > > from the index file or from a named <tree-ish> (most often a
> > > > commit). In this case, the `-b` and `--track` options are
> > > > meaningless and giving either of them results in an error. The
> > > > - <tree-ish> argument can be used to specify a specific tree-ish
> > > > - (i.e. commit, tag or tree) to update the index for the given
> > > Do these lines above actually need reflowing? Their content hasn't
> > > changed
> > > making it more difficult to spot the significant changes below
> > > here.
> > They're just part of the context of the automatically created patch.
> The lines with +/- markings are the actual change lines. It's the
> lines
> without them that are the context lines.
> 
> It does sound like an accidental reflow where the "(i.e." moved
> between
> lines, and the "paths" moved for the following lines.
> 
> If reflowing is required it's normal to put it in a separate patch so
> that 
> each type of change gets its own commit message.

Ah, right. I added a missing "to" and changed "to specify a specific".


> > > For a clean commit checkout my mental model is not one of anything
> > > new
> > > being
> > > actively staged i.e. different from what was in the commit.
> > Note that this is not about something like `git checkout 925b29` but
> > about
> > something like
> > `git checkout 925b29 src`.
> Yes, that was the part I was getting at.
> 
> The commit message (and the patch context) doesn't quite give enough
> to see 
> that is is particular to the -
> 
> git checkout [-p|--patch] [<tree-ish>] [--] [<paths>…]invocation.

It's: git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

The paths aren't optional. Added it to the commit message:


While technically in the documentation, the fact that changes
introduced by a `git checkout [-p|--patch] [<tree-ish>] [--]
<pathspec>...` are staged automatically, was not obvious when
reading its documentation. It is now specifically pointed out.

Related sentence cleaned up.

Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
---
 Documentation/git-checkout.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-
checkout.txt
index 8e2c066..cfd7b18 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -85,9 +85,10 @@ Omitting <branch> detaches HEAD at the tip of the
current branch.
        from the index file or from a named <tree-ish> (most often a
        commit).  In this case, the `-b` and `--track` options are
        meaningless and giving either of them results in an error.  The
-       <tree-ish> argument can be used to specify a specific tree-ish
-       (i.e.  commit, tag or tree) to update the index for the given
-       paths before updating the working tree.
+       <tree-ish> argument can be used to specify the tree-ish (i.e.
+       commit, tag, or tree) to update the index to for the given paths
+       before updating the working tree accordingly.  Note that this
means
+       that the changes this command introduces are staged
automatically.
 +
 'git checkout' with <paths> or `--patch` is used to restore modified or
 deleted paths to their original contents from the index or replace
paths
-- 
2.7.4


--
Christoph
