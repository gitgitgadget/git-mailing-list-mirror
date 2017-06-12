Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FC21F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 17:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbdFLR7B (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 13:59:01 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33464 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdFLR7A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 13:59:00 -0400
Received: by mail-pf0-f169.google.com with SMTP id 83so54419492pfr.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=kLL2JaVvYce1vz8uqmtRE3jNHRKYFXoNnPm7VRYc+M4=;
        b=PjGECjExb96KGDA/39jJnocRe4C3lB1vuEFZQs1YNy13+wFwGjQ5k6tQfWO22MJEM2
         jDmJ3E0hKYP4gnLdwtHG54dmcoXQ32aQQCA5oGIM+ViRClKwNkxUTJV5+ccwBvAiJ7gn
         eWhGQink6Zbi1PPxThRhvzPHfTodWJrEZ2LiKvhA7EGx8lNSRlVeITG6cD3WpFNv4JV+
         Xzk9LfgcLGcrXno9l3Cy6wmPQ/FTXUBbjkdWeMWIacY5jtuNNxj7+oxsZNz6CRsSAOxE
         qwJy411HS/VBJ6ZlOFC6MFjbO+BYCCPo5Vl4XQkfY7IUDrsxlCf+CT0t5FkZOAj7KkZR
         TNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=kLL2JaVvYce1vz8uqmtRE3jNHRKYFXoNnPm7VRYc+M4=;
        b=osCcgAkB3bkGgF3+hh/5FZ63To8O7qRU7a9uD9yMpiZGNyacgrGycF3Mkedk2MXmEa
         7YuTdl6ES2Vg5BnzGsde5EWY9xfKkXJvR6nS4TE4P9cJrmke4406iqvN6p5ztpV8bi1P
         vMzUytjY8PpM9W+zeQxeNcU4vyxQaHTszDums6oDJnTk1Ya9/Jb+7PzM2F1DQQoRqdxZ
         V395Hvz2Cy+chLOkiNOYzyAdtaOWc4j51hDfTA43J42tpeepkg7YVCCMobXlsU3+m8Q+
         SS8dfgDM3cZY/oBnPbgU22RP7aadFX96m0372AbY7a73KxHrcXzpANBu0nT5pAVscSlu
         h3+A==
X-Gm-Message-State: AODbwcBWVQtDnCO3diAGIm0qoougibNoP82BvIL1Fz94CgIhZLD3B7tZ
        2IW4NxtYpYWPhQ==
X-Received: by 10.99.119.132 with SMTP id s126mr46817997pgc.52.1497290339897;
        Mon, 12 Jun 2017 10:58:59 -0700 (PDT)
Received: from unique-pc ([2405:205:8100:7f26:2f1e:ad3f:8899:445e])
        by smtp.googlemail.com with ESMTPSA id l3sm10364663pfk.34.2017.06.12.10.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Jun 2017 10:58:59 -0700 (PDT)
Message-ID: <1497290317.11486.4.camel@gmail.com>
Subject: Re: Small issue with "add untracked" option of 'git add -i'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Mon, 12 Jun 2017 23:28:37 +0530
In-Reply-To: <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
References: <1497278015.7302.13.camel@gmail.com>
         <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-06-12 at 10:38 -0700, Junio C Hamano wrote:
> After prompting to get the list of desired files, if the user chose
> nothing, the message is shown.  "No untracked files chosen." is
> probably what the code wants to say, I would think.
> 
That does seem to be a more apt message to be shown. It's unambiguous.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
