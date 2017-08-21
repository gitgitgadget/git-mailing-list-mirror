Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABDE208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 14:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754328AbdHUONL (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 10:13:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33280 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754068AbdHUONJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 10:13:09 -0400
Received: by mail-wr0-f194.google.com with SMTP id 30so5694010wrk.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=instituut-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4z2xKXvSS6M2vDCqLxvfV54qcVvG2suyeJvSyyuIHBM=;
        b=S3OL3FzdzOzZn3vz90OGRT0UkVn1/sqWvo2KRX8A5mD+uqMxkkJ4w9mD7duYlwpIFb
         A3c3vfkhKy/bb2sCvSt4dt0OvMK6JWSgnqR8tYuchTvTcMcQ3kL/ZoxB+36LeGi/U+aq
         buX7OCBApYgAjfHSPdgA/E/JfEczwwiEZ5+smejuR2F6XujtiN5/W1U22UPm1ye5L3N9
         3oNOTFMDJquxNEa1BVbQHqE3t+7h5UkPLX+Ok4B6d9VTmKIBw6casxWPf+BRvUA53hoo
         DQ9Iza0L36G3XAJqaCrS6ew6R3R9IzC/BCub0ryorE27Jefq1uLJbTIXeG6MV7odQSsU
         sC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4z2xKXvSS6M2vDCqLxvfV54qcVvG2suyeJvSyyuIHBM=;
        b=pQTRu/QP62fUqcVBrJsAIr0HV7rkEPw0BB8ZgUdpiA6MoDfFv+O75+6RkbHg3F6H0x
         0CWGLK2FwX3FizhKFq3JD33OaeI3HkkOcCKKxCrLxYlQv24nlHSWS3juPF/n53Dzbzmf
         jfxY5sIkQeOzuDsmKKTqvpjt3SYDK0oAlRbeHI2sCSKeKxdZCY18ywgdpC3y8l9qxd/U
         nYBZ8+869leiXTLx7TW1/T8rnMl/Bm9VXFkRLPBf1WrQFhCFz67OnOA1ze/SWapG0N/S
         y5Dc8f79Fe4vPopXvk2Afb7oREzxlAJ52J1wvOxqsvEpnXRMSOAgkR5ry+9GOsUYzMHb
         uH7Q==
X-Gm-Message-State: AHYfb5hHJEGDn5Z14OTBfq2hr45S4i3qKEVsV2rEx1von3g8w6jgpopc
        9PqTb7tjFep8kV3/
X-Received: by 10.80.214.18 with SMTP id x18mr12792894edi.253.1503324788510;
        Mon, 21 Aug 2017 07:13:08 -0700 (PDT)
Received: from localhost ([2001:67c:208c:10:604b:2ee0:e11:4776])
        by smtp.gmail.com with ESMTPSA id l3sm6622715edc.32.2017.08.21.07.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2017 07:13:07 -0700 (PDT)
Date:   Mon, 21 Aug 2017 16:13:06 +0200
From:   Job Snijders <job@instituut.net>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
Message-ID: <20170821141306.wnlfn5a4hmgnj3yn@hanna.meerval.net>
References: <20170802185901.GA27243@Vurt.local>
 <20170820180332.GC39363@Vurt.local>
 <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
 <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net>
 <CAOxFTcxaxRjdsd0OSQX9E9ncEnO4XFLoa-0puXm2AByv6dZUow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOxFTcxaxRjdsd0OSQX9E9ncEnO4XFLoa-0puXm2AByv6dZUow@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add 'raw' blob_plain link in history overview

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
