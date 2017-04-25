Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3902207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 09:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428560AbdDYJLb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 05:11:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36323 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428519AbdDYJL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 05:11:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so15848155wrc.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9J89T1ywRbBmmAyt0LHojpaeUA6Z4jdp64vaGceE8U=;
        b=X66JEUBpjeW7nylcxRnPmMhqeWyEylPcaPibgYhPiq2hIlghDiYb+hzCmssh6fFNxv
         AE94Osle2ePw+aZZIm4U3gSnlmesWiuW2eaLKr4geFBq5qWm+g9fIguDDG/iqI+xnGTX
         zIIffFnPtajUT8qlIS9f+w6e5PYkgHnTT+m7PD968lWeRqzvK30sBmMpsi6Mpb0vTbwd
         dAEwxH46qSj3+naFwKPEQZj13UhF12rqkgsRv5ueTmc8pTv7P6Msd4hJYY+N4jozioO9
         aQbl7sSC1vztuSLfvZBGaM3gopZmcIIZf4e8LVHsbKh8/igk7IZLUloX6Vys5nCxWC9n
         d64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T9J89T1ywRbBmmAyt0LHojpaeUA6Z4jdp64vaGceE8U=;
        b=gjGyb6Xs5WqJiVFkML1KSA4P6mtVSpNg3iKyTzSYyJd0Ta0+HDKwP5Gj+qozD0sBSK
         9hiB/XIEUZ15xXqm+0ESoskWlABK0sebJUZCj8LI2YtW3z4U1hhFN627Kzfc9hYMqmpS
         PXxqI8ukNnMy5qeyAT7bZn8hSYLN7S2mlMhSjn9n/bT9Cquxm6Sg1HoM0DiBmGw4UykX
         HL4RKIsLdP/S9TVdT5IWWkgqC0JgoqqJ5qp6LZelCnXlBUIfGk2GZhKabbxLr3hFfEjb
         jFioSPR0IzSa8VYTiOSCKUjyX31v360N4RAvtAsuonI0iPtaTQrVSBnuCCkuVH5Uvd//
         LeHw==
X-Gm-Message-State: AN3rC/40TWyPAJJShMR76TzoK0ItE/WwJjJrwYnxMBd27PSl7YQHzA+G
        32gX08CG+2e3PRm6
X-Received: by 10.223.163.211 with SMTP id m19mr8598853wrb.56.1493111485975;
        Tue, 25 Apr 2017 02:11:25 -0700 (PDT)
Received: from ?IPv6:2a02:8071:3185:fe00:ac3c:9df3:cefe:1bc? ([2a02:8071:3185:fe00:ac3c:9df3:cefe:1bc])
        by smtp.googlemail.com with ESMTPSA id u9sm2987423wme.8.2017.04.25.02.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:11:24 -0700 (PDT)
Message-ID: <1493111483.18809.0.camel@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Date:   Tue, 25 Apr 2017 11:11:23 +0200
In-Reply-To: <xmqqzif5xo9m.fsf@gitster.mtv.corp.google.com>
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
         <1493038014.4708.21.camel@gmail.com>
         <xmqqzif5xo9m.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I give up. Bye.
On Mon, 2017-04-24 at 18:35 -0700, Junio C Hamano wrote:
> Christoph Michelbach <michelbach94@gmail.com> writes:
> 
> > 
> > I'm sorry, somehow my email client deleted half of your message when I saved
> > it
> > when replying. I only noticed this when wanting to delete your email and
> > noticed
> > that it was pretty long.
> Please separate your discussion from the patch proper.  Check
> Documentation/SubmittingPatches and send a proper patch like other
> people do.
> 
> 
> > 
> > From fe0d1298cf4de841af994f4d9f72d49e25edea00 Mon Sep 17 00:00:00 2001
> > From: Christoph Michelbach <michelbach94@gmail.com>
> > Date: Sat, 22 Apr 2017 18:49:57 +0200
> > Subject: [PATCH] Doc./git-checkout: correct doc. of checkout <pathspec>...
> These we take from the e-mail header.  You usually remove them from
> the body of the message (and move the Subject: to e-mail subject), hence
> 
> > 
> > The previous documentation states that the named paths are
> this line will become the first line in the body of the message.
> 
> > 
> > A hint alerting the users that changes introduced by this
> > command when naming a tree-ish are automatically staged has
> > been introduced.
> We are still saying automatically here?
> 
> > 
> > Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
> > ---
> >  Documentation/git-checkout.txt | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> This is not limited to your message, but from time to time, I see
> messages with SP substituted with non-breaking space like the above
> two lines (and they appear in the patch text).  I can still read and
> comment on the patch, but it is unusuable as an input to "git am" to
> be applied.  I wonder where these NBSP come from---perhaps some
> commmon MUAs corrupt text messages like this?
> 
> > 
> > 
> > diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> > index 8e2c066..ea3b4df 100644
> > --- a/Documentation/git-checkout.txt
> > +++ b/Documentation/git-checkout.txt
> > @@ -81,13 +81,14 @@ Omitting <branch> detaches HEAD at the tip of the
> > current
> > branch.
> >  'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
> >  
> >  	When <paths> or `--patch` are given, 'git checkout' does *not*
> > -	switch branches.  It updates the named paths in the working tree
> > -	from the index file or from a named <tree-ish> (most often a
> > -	commit).  In this case, the `-b` and `--track` options are
> > -	meaningless and giving either of them results in an error.  The
> > -	<tree-ish> argument can be used to specify a specific tree-ish
> > -	(i.e.  commit, tag or tree) to update the index for the given
> > -	paths before updating the working tree.
> > +	switch branches.  It copies the files matching the pathspecs in
> I am debating myself if rephrasing "in <tree-ish>" to "from
> <tree-ish>" makes the result clearer to understand.  When we say
> "Copy files from T to I and W", it would be obvious that what does
> not exist in T will not be copied.
> 
> I also wonder "If no-tree-ish is provided" at the end of this
> paragraph you have is a bit too far from the above primary point of
> the description, because you have an unrelated "In this case,
> -b/-t...", in between.  
> 
> 	The blobs matching the pathspecs are checked out from the
> 	index to the working tree.  Optionally, when <tree-ish> is
> 	given, the blobs matching the pathspecs from the <tree-ish>
> 	is copied to the index before that happens.
> 
> is what I would want to say, but obviously that does not describe
> what happens in the chronological order, so it is the most clear
> description for people who understand what is written, but it will
> take two reading until the reader gets to that stage X-<.
> 
> Perhaps the unrelated "In this case, the -b..." should go first; it
> is part of "does *not* switch branches".  Also even with your patch,
> it starts with "X is not Y" and does not clearly say "X is Z".
> 
> 	When <paths> or `--patch` ar given, 'git checkout' does
> 	*not* switch branches (giving the `-b` and `--track` options
> 	will cause an error, as they are meaningless).  It checks
> 	out paths out of the <tree-ish> (if given) and the index to
> 	the to working tree.  When an optional <tree-ish> is given
> 	blobs in the <tree-ish> that match <pathspec> are copied to
> 	the index.  The blobs that match <pathspec> are then copied
> 	from the index to the working tree, overwriting what is in
> 	(or missing from) the working tree.
> 
> May be an improvement (i.e. say what Z is: checking out paths from
> tree-ish and/or index to the working tree).  By explicitly phrasing
> that <tree-ish>, from which the index is updated, is optional, it is
> clear that without <tree-ish> there is no update to the index.
> "missing from" covers two cases: (1) the user removed the file from
> the working tree and <tree-ish>, e.g. HEAD, has the file, hence
> removed one is resurrected; (2) the user didn't touch the file and
> HEAD didn't have it, but by checking out from <tree-ish> that has
> the file, the user added that new file to the set of files the user
> is working with.
> 
> Hmm?
> 
