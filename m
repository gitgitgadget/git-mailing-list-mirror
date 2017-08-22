Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B075B1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdHVUHd (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 16:07:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35756 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbdHVUHc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 16:07:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id r77so193004wmd.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=instituut-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rLUdGXCoKju4y2yAY/0RSaleRocqe3PydU7nPPBxoh8=;
        b=DWY8F8DiTh0ck+4nv3if5KuKyLXDnpoXobkXpS0mZ37PHe05MjTcq93QWxMBK7iaWi
         d3u9kb9ZRY3p4noj/tfQq820qjgqtdEmMOx2ip0dw9Xf9EZUopbHU6SUl/nE74/8UKJm
         p/UWhzqyQMc7RM10CM5GofDNp1V4LLaNt5OaunqWCng88afWluKuJDiuRO4FwHxoaUns
         EWX4C5StpItm9x8JXqSS6Snw6ZhuZQjHd0sTYVT+W2H/Oq9Wg3pWZTnpvQ+0TrFbKYie
         FE160RUNIVb3f6LQe1pH4DXaIILdG7Gi4ZCP4sDWAdq4+NDUwRHDj1Rxx79pWHPGrxqN
         DV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLUdGXCoKju4y2yAY/0RSaleRocqe3PydU7nPPBxoh8=;
        b=Pg6pNrnnXs4nk6ZnkHDItLZetBV+qZXYvSWBXm1vmiAkt2nmtQ5WPh5+96Rd+ACoIX
         aDigCOfvt+JeSGoo720SEhXJ9xN0FGtCNaiiiTb6D7VrZTBWCkG1kVTaIKUfwwSArUoF
         nsnjTQJvFg0/ZyadAr8ZZwTRS8T+2m6skaEnA1FGmr6G9KoX/2tJVAZUJNdA7kywRUiE
         5IxeMIuYoz2nXig7E8z12fgpQtG4D0dqLONGCIkvPuSji+0xAL6bf4b52tOAv2BOe8Ub
         NYsXWqrUrOJzeK0/XBTlud9VIn8nEHv0Te8reSNTqLn/TMrYSOIWdg30w8RzkCL+76qB
         9PiA==
X-Gm-Message-State: AHYfb5j9dkpbnWfjLfskQPn8krJEIUHzBBW1wcolGlVLZTpOZ4m+d+gm
        cclCePeyQxNP80IZ
X-Received: by 10.80.130.2 with SMTP id 2mr1009110edf.233.1503432451479;
        Tue, 22 Aug 2017 13:07:31 -0700 (PDT)
Received: from localhost ([2001:67c:208c:10:105e:203f:f35f:c921])
        by smtp.gmail.com with ESMTPSA id j6sm61334edb.14.2017.08.22.13.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2017 13:07:30 -0700 (PDT)
Date:   Tue, 22 Aug 2017 22:07:29 +0200
From:   Job Snijders <job@instituut.net>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
Message-ID: <20170822200729.GL39363@Vurt.local>
References: <20170802185901.GA27243@Vurt.local>
 <20170820180332.GC39363@Vurt.local>
 <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
 <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net>
 <CAOxFTcxaxRjdsd0OSQX9E9ncEnO4XFLoa-0puXm2AByv6dZUow@mail.gmail.com>
 <20170821141306.wnlfn5a4hmgnj3yn@hanna.meerval.net>
 <xmqqo9r72yrg.fsf@gitster.mtv.corp.google.com>
 <20170822193520.GJ39363@Vurt.local>
 <CAOxFTczs6Z8qKw_X2USpG0bSKq-XXhfLyg21Nsm196QaxfN7EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOxFTczs6Z8qKw_X2USpG0bSKq-XXhfLyg21Nsm196QaxfN7EQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For people that work with very large plain text files it may be easier
if one can bypass viewing the htmlized blob and instead click directly
to the raw file (rather then click through 'blob' and then to 'raw').

Reviewed-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Signed-off-by: Job Snijders <job@instituut.net>

---
 gitweb/gitweb.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9208f42ed..959f04b49 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5967,6 +5967,9 @@ sub git_history_body {
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
 
 		if ($ftype eq 'blob') {
+			print " | " .
+			      $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw");
+
 			my $blob_current = $file_hash;
 			my $blob_parent  = git_get_hash_by_path($commit, $file_name);
 			if (defined $blob_current && defined $blob_parent &&
