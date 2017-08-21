Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7914A1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbdHUKoa (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:44:30 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37337 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbdHUKo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:44:28 -0400
Received: by mail-wr0-f196.google.com with SMTP id z91so17200637wrc.4
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=instituut-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcgfy+od8wGSZa/lp8p36PQwjMCdd9bCdtRWUIjbINg=;
        b=uhyDtQHtDWFwAQCrteaxIDlvcl5zwQ9ZkuMlHirc9Q6j0bcSXe5duqfOPOmshKSPK5
         lNFoZ251//Zt73ulFNZvdS98EdEa3w2NUrqtD5tYX5/MqU/DumS9fiatCDUYsiiCaOpG
         ZHosqG6TxenYPZW08yGP9+iIWiWxstb+o0ddo4z2vdvcCFG/umbTPjRyzdRsLp30Jh8E
         o4aa+y3wPFutjnbXuodvgECy/doWSH1yh4EPwSTpd32RgIV6OviHOZzbKnR1e/tNMDwM
         cv/trAQtUfmTlYHcES7jqWdv2ONeSUKCAABP+U83hAy1MkUdi2FRQiC3fXuF5OgVLpcO
         E+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcgfy+od8wGSZa/lp8p36PQwjMCdd9bCdtRWUIjbINg=;
        b=ZzSGiOEoGrqe+xrc4kaCbAuz4nEZTsVx1N6LqJF8F6WfimFw2SgS99s9aDB5lG9pVY
         8QbqeQB40ILi0MKMnZ6pg4Ijqc4oGqnwVR1OwZ9c0Jpx9RRSgCeabsCJguwl00Is8xVB
         Cf7E5MecNMgRXlgNl4xXyLXH/36CKrubdzkmDO+wughJzBDPyDpUBW5J2ic3AUo13oi/
         fnJJqmktBbUsPnSgAY4NIS101tvlfDz9QxP2dHyGzLWO/U578yNT9t4kwDPmrrewaOWH
         PHu01G/UJOdZF0PRC5rEKZ7f2d8lTNpeooK3RJmW3Z2UEaN5cNxofgC08tnBURMGb5hv
         DtCw==
X-Gm-Message-State: AHYfb5jFlYi6aPSXmdO6AeaqRFp9wGvxRBKGyUOrQqd4N9S675TAo0x0
        3N/WLCY4eEeZvdB8
X-Received: by 10.80.147.134 with SMTP id o6mr11775477eda.102.1503312267133;
        Mon, 21 Aug 2017 03:44:27 -0700 (PDT)
Received: from localhost ([2001:67c:208c:10:e13e:5f84:2f59:7e7a])
        by smtp.gmail.com with ESMTPSA id 64sm5511549edy.80.2017.08.21.03.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2017 03:44:26 -0700 (PDT)
Date:   Mon, 21 Aug 2017 12:44:25 +0200
From:   Job Snijders <job@instituut.net>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
Message-ID: <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net>
References: <20170802185901.GA27243@Vurt.local>
 <20170820180332.GC39363@Vurt.local>
 <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 12:19:38PM +0200, Giuseppe Bilotta wrote:
> >> This patch adds a 'raw' blob_plain link in history overview.
> 
> Arguably, the addition of the 'raw' link should be done in the same
> conditional that also adds the 'diff to current' link, before the diff
> to current link.
> This would be more consistent with the tree view (which puts the raw
> link last), while still preserving the alignment of the link position
> independently of the existence of the 'diff to current' link. (Bonus
> extra: smaller patch)

Thank you for your feedback, good point. Please see below:

---

Add a 'raw' blob_plain link in history overview

Signed-off-by: Job Snijders <job@instituut.net>
---
 gitweb/gitweb.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9208f42ed..c43bbe331 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5967,6 +5967,9 @@ sub git_history_body {
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
 
 		if ($ftype eq 'blob') {
+			print " | " .
+				$cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw");
+
 			my $blob_current = $file_hash;
 			my $blob_parent  = git_get_hash_by_path($commit, $file_name);
 			if (defined $blob_current && defined $blob_parent &&
