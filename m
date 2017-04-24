Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD09207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 12:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1169817AbdDXMY7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 08:24:59 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33430 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169803AbdDXMYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 08:24:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so16124609wrc.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeLUXdRaoTYhL6r5WG/iIZvZGCE2KJzhcxaGvCK65Wg=;
        b=eY7/tb7TKO0lDtUGf1WWswRIdDtPafWthrt2Pknn4zrDa/buVRnoetUZY6hnuFyyCb
         3Vy7Vc/9d6IzjRwt/PmHuokUAi+GFM3bniAXlUtmcJZ/ef03BMJM976cDnits62zrMW1
         rwcyIbfstgKkJdWm1EvLMrIWyZktoy7VoCTUevKiHK6/mZ9tO7rTtQ35KII5Fx5qsUkS
         8OdynQKI1fgBB73h3TfTrY3o/1HB2Q8KRA23740sVx0LsXU3mYanm+5tXBQtdV/HOpxC
         lPScoYh7OsW9U6Q18hdZK4rl4jQ8nt1YRXG6BVm9JzEWqzEwA629106KrjWIE8jXQCkx
         OPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeLUXdRaoTYhL6r5WG/iIZvZGCE2KJzhcxaGvCK65Wg=;
        b=D3S9ZI5dwyDSBQlCnVKYCBXZBLLNTx8GYBCd55czXdwSi647vj7ZVV2CQU0Yq2ddqS
         qqb8NdSl6kBXiiXgEfNnWg3fsTS6wzTUDjwTEzjtYEfjrQA4uNgEHlr9+TYZCgAm7QUd
         qqSU1zJNdUXZjVFdzYnJWC04fCHcKllZIpFVO0qPcB5e3g/6nzZmrcswQtjxwqa+2RFW
         L7yVjdvaSuMe/ZeapLc4wPB8U4SYmbOMC2gRvddHJiBHjmc/OCBbHui29EJ5lVxA8gLK
         PlgfkNlt0zuAPkuAN2v9j2d8nAjLC1GYeKRqd19UMxh6keRZPrRPuWxPdu/rJEBX8DaA
         Sepg==
X-Gm-Message-State: AN3rC/6M94vP/+Vctxq1XL8hsolLjgqI/D3hajssC5IvT5k5q4ehyvCf
        OvYtUADXaeTM5Q==
X-Received: by 10.223.151.6 with SMTP id r6mr5837240wrb.189.1493036685331;
        Mon, 24 Apr 2017 05:24:45 -0700 (PDT)
Received: from ?IPv6:2a02:8071:3185:fe00:702f:4591:dd53:870c? ([2a02:8071:3185:fe00:702f:4591:dd53:870c])
        by smtp.googlemail.com with ESMTPSA id s81sm264026wms.6.2017.04.24.05.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 05:24:43 -0700 (PDT)
Message-ID: <1493036682.4708.9.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Date:   Mon, 24 Apr 2017 14:24:42 +0200
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


From 24a5ca5affbe8a09413b72ceb3cb50ae2fe9fd2b Mon Sep 17 00:00:00 2001
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
 Documentation/git-checkout.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8e2c066..306b9d2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -81,13 +81,15 @@ Omitting <branch> detaches HEAD at the tip of the
current branch.
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
+	<tree-is> (i.e. a commit, tag, or tree) to the index and
+	subsequently to the working tree, overwriting changes
+	(including deletion of files) in those files.  In this case, the
+	-b and --track options are meaningless and giving either of them
+	results in an error.  Note that because the index is updated, the
+	changes introduced by this command are automatically staged.  If
+	no tree-ish is provided, the current index is used and remains
+	unchanged, modifying only the working tree.
 +
 'git checkout' with <paths> or `--patch` is used to restore modified or
 deleted paths to their original contents from the index or replace paths
-- 
2.7.4

