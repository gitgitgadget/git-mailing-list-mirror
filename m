Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4661F858
	for <e@80x24.org>; Thu, 28 Jul 2016 12:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757744AbcG1MzZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 08:55:25 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:54515 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711AbcG1MzV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 08:55:21 -0400
Received: from [62.224.174.160] (helo=sandbox)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bSkqJ-0006OK-SY; Thu, 28 Jul 2016 14:55:15 +0200
Date:	Thu, 28 Jul 2016 14:55:14 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH] document how to reference previous commits
Message-ID: <20160728125514.GA2813@sandbox>
References: <578E7A07.8080006@web.de>
 <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de>
 <20160725143706.GA4872@sandbox>
 <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094913.GA3347@book.hvoigt.net>
 <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
 <20160728111636.GA7760@sandbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160728111636.GA7760@sandbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To reference previous commits people used to put just the abbreviated
SHA-1 into commit messages. This is what has evolved as a more
stable format for referencing commits. So lets document it for everyone
to lookup when needed.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Thu, Jul 28, 2016 at 01:16:36PM +0200, Heiko Voigt wrote:
> On Tue, Jul 26, 2016 at 10:22:07AM -0700, Stefan Beller wrote:
> > Usually we refer to the commit by a triple of "abbrev. sha1 (date, subject).
> > See d201a1ecd (2015-05-21, test_bitmap_walk: free bitmap with bitmap_free)
> > for an example. Or ce41720ca (2015-04-02, blame, log: format usage strings
> > similarly to those in documentation).
> > 
> > Apparently we put the subject first and then the date. I always did it
> > the other way
> > round, to there is no strict coding guide line, though it helps a lot to have an
> > understanding for a) how long are we in the "broken" state already as well as
> > b) what was the rationale for introducing it.
> 
> Ah ok did not know about this format. Will change that. I also will
> follow-up with a patch to document this in SubmittingPatches so we can
> point others to that...

Here we go. Made this a seperate patch, since it is not really connected
to the submodule-config-fix series.

Cheers Heiko

 Documentation/SubmittingPatches | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e8ad978..500230c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -121,6 +121,11 @@ its behaviour.  Try to make sure your explanation can be understood
 without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
 
+If you want to reference a previous commit in the history of a stable
+branch use the format "abbreviated sha1 (subject, date)". So for example
+like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
+noticed [...]".
+
 
 (3) Generate your patch using Git tools out of your commits.
 
-- 
2.0.2.832.g083c931

