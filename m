Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01153207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 12:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1170145AbdDXMrC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 08:47:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34936 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170135AbdDXMq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 08:46:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so17041247wmi.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jrhd9uVexKfGayE5hWRvndt45UHfbqiQ5XC4F2hmZOw=;
        b=Ku4q6mYBOymGbKqd5uWmdY/VHOxcbl/T/mB5Cws9q2gRttO6JsB2DfIvdgsY62ssxS
         puXyfv2TWlDeaY0u71WLe6/+Nb2A4sfg5upN5Lk5lXWo2nzO5xU2Ju+JI71nWo4Eo2FB
         f9me8iLYrA5ZL2u6cm+lbsK5c4I2nSOdpE5+ZcMFLShNTpm624U8F4ESqOO2v5guo1za
         l+5/HLVFM2uBN0sPkCoKLOZH4Rxeyn+tNuH9QWoyUl6hWYuCGS/Hbxpty8QUvYtJrZIB
         SiwJmVaVfsquLeyQLaylbd6bjlOtjDfDljE4hhIIlibyyxul2N0W73etHOJA+5Oheqlu
         AYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jrhd9uVexKfGayE5hWRvndt45UHfbqiQ5XC4F2hmZOw=;
        b=YRwEkZWejKxQt8NAs6rf0gSGbhBT2c27VVHVrDRPf2fUhkp+KleShv2kcGvjD9IXsM
         RJLkwEbEdeZtyx8IwXJXtZsVT8UPqFtg+z724YVbpZdfheyKs2q9q6hjxplH5akA8klS
         FXrLRzwGOdUTQesVnlTOH6cXCkyRGcKnBr5dMzaT7KdTR6tElxA1NtR869zV1T08Usb4
         tm/psPBTpFfpHEDzZsWTE9iVpm3+s3VQYU4bez/+HQaSqoYnoSxRxbZMG58qc0Iz2Wjm
         jHJ6/r3/k8ZEXiY9x6RxrG2LUGZyvIJjiMqQtL9yZTwePxsXnBWk9+od8JlzTTjNK64+
         69PA==
X-Gm-Message-State: AN3rC/6ZsAeLIWNxkrYGbXEfLf67kSgNbPKPFHvzItQu4vZpNBKe9nEf
        2hP0QtAxx/yFjQ==
X-Received: by 10.28.141.65 with SMTP id p62mr9386416wmd.122.1493038016126;
        Mon, 24 Apr 2017 05:46:56 -0700 (PDT)
Received: from ?IPv6:2a02:8071:3185:fe00:702f:4591:dd53:870c? ([2a02:8071:3185:fe00:702f:4591:dd53:870c])
        by smtp.googlemail.com with ESMTPSA id q108sm4431123wrb.3.2017.04.24.05.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 05:46:54 -0700 (PDT)
Message-ID: <1493038014.4708.21.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Date:   Mon, 24 Apr 2017 14:46:54 +0200
In-Reply-To: <xmqqo9vm36xg.fsf@gitster.mtv.corp.google.com>
References: <1492287435.14812.2.camel@gmail.com>
         <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>
         <1492347718.19687.14.camel@gmail.com>
         <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>
         <1492368692.22852.9.camel@gmail.com>
         <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>
         <1492380399.19991.13.camel@gmail.com>
         <5EBADDE444D141918F6873BE8456E026@PhilipOakley>
         <1492452173.11708.22.camel@gmail.com>
         <5FD0803E166B4D2F9F64D8D21AC23EB3@PhilipOakley>
         <xmqqa87eimje.fsf@gitster.mtv.corp.google.com>
         <1492518377.5720.47.camel@gmail.com>
         <xmqq1sspdvjk.fsf@gitster.mtv.corp.google.com>
         <1492881136.7368.3.camel@gmail.com>
         <xmqqo9vm36xg.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm sorry, somehow my email client deleted half of your message when I saved it
when replying. I only noticed this when wanting to delete your email and noticed
that it was pretty long.

--------------------------------------------------------------------------------

On Sun, 2017-04-23 at 18:55 -0700, Junio C Hamano wrote:
> Christoph Michelbach <michelbach94@gmail.com> writes:
> > From: Christoph Michelbach <michelbach94@gmail.com>
> > Date: Sat, 22 Apr 2017 18:49:57 +0200
> > Subject: [PATCH] Doc./git-checkout: correct doc. of checkout
> > <pathspec>...
> > 
> > The previous documentation states that the named paths are
> > updated both in the index and the working tree. This is not
> > correct as those paths can point to folders which are not
> > updated to what they are in the given tree-ish. Rather,
> > the files pointed to by the pathspecs are copied from the
> s/pointed to by/that match/

Ok.


> > 
> > tree-ish to the index and working tree One difference being
> Missing full-stop after "tree".

Oops.


> > 
> > that one can name paths which are not present in the working
> > tree ...
> That one is not a difference, I would think.  If your current index
> and working tree lack F, you give pathspec that match F, and the
> tree-ish has that path F, that named path _is_ updated both in the
> index and in the working tree.

I don't think it's inherently obvious that you can name paths which don't
occur in the working tree if it's stated that those are updated. For
something to be updated, I suppose it has to exist in the first place. But I
don't really want to discuss the commit message as everyone even reading it
already knows how the command works so I just removed it.
> >  	When <paths> or `--patch` are given, 'git checkout' does *not*
> > +	switch branches.  It copies the files matching the pathspecs in
> > +	<tree-is> (i.e. a commit, tag, or tree) to the index and
> <tree-ish> is misspelled here.  Drop (i.e. ...) as (1) it is not
> correct (a tag may not point at a tree-ish) and (2) "checkout" is
> not a place to learn what a tree-ish is (glossary is).

Done.

> 
> > 
> > +	subsequently to the working directory, overwriting changes
> Do we need to say "subsequently" when we are aiming to be more
> intelligible by not describing the order of execution?  The end
> result is that the blobs named by the pathspecs from the tree-ish
> are checked out to the index and to the working tree at the same
> time.

I agree. Done.


> 
> > 
> > +...	Note that because the index is updated, the
> > +	changes introduced by this command are automatically staged.
> This is redundant and unnecessary, I would say.  If you absolutely
> need to say this, at least drop "automatically".  There is nothing
> automatic about it.  The user is asking to checkout the named blobs
> out of the tree-ish to the index and to the working tree, and Git is
> merely doing as it was told.

Done.


> In addition the description is fuzzy; what are "changes introduced
> by this command" relative to?  If you did "checkout HEAD path" after
> editing path in the working tree, is "reverting my edit" the
> "changes introduced by this command"?

All of those no changes which could possibly be staged are immediately staged.
All statements about all elements of the empty set are true.


> If you did "checkout HEAD
> path" after editing path, "git add path" and then editing path
> further, what are the "changes introduced by this command"?

The command can't introduce any further changes just because you edit files
after it has already terminated execution.



From fe0d1298cf4de841af994f4d9f72d49e25edea00 Mon Sep 17 00:00:00 2001
From: Christoph Michelbach <michelbach94@gmail.com>
Date: Sat, 22 Apr 2017 18:49:57 +0200
Subject: [PATCH] Doc./git-checkout: correct doc. of checkout <pathspec>...

The previous documentation states that the named paths are
updated both in the index and the working tree. This is not
correct as those paths can point to folders which are not
updated to what they are in the given tree-ish. Rather,
the files which match the pathspecs are copied from the
tree-ish to the index and working tree. The difference being
that only files which are already present in the given
tree-ish are affected.

Furthermore, the changed text is intended to be more
intelligible as it is written in a way which is easy to
follow, rather than describing the technical process in
order of execution.

A hint alerting the users that changes introduced by this
command when naming a tree-ish are automatically staged has
been introduced.

Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
---
 Documentation/git-checkout.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8e2c066..ea3b4df 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -81,13 +81,14 @@ Omitting <branch> detaches HEAD at the tip of the current
branch.
 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
 
 	When <paths> or `--patch` are given, 'git checkout' does *not*
-	switch branches.  It updates the named paths in the working tree
-	from the index file or from a named <tree-ish> (most often a
-	commit).  In this case, the `-b` and `--track` options are
-	meaningless and giving either of them results in an error.  The
-	<tree-ish> argument can be used to specify a specific tree-ish
-	(i.e.  commit, tag or tree) to update the index for the given
-	paths before updating the working tree.
+	switch branches.  It copies the files matching the pathspecs in
+	<tree-ish> to the index and to the working tree, overwriting
+	changes	(including deletion of files) in those files.  In this
+	case, the -b and --track options are meaningless and giving either
+	of them results in an error.  Note that because the index is updated,
+	the changes introduced by this command are staged.  If no tree-ish is
+	provided, the current index is used and remains unchanged, modifying
+	only the working tree.
 +
 'git checkout' with <paths> or `--patch` is used to restore modified or
 deleted paths to their original contents from the index or replace paths
-- 
2.7.4

