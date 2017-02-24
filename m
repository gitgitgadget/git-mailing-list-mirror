Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70E7201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 22:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdBXWs2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 17:48:28 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33899 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXWsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 17:48:15 -0500
Received: by mail-lf0-f47.google.com with SMTP id k202so896859lfe.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 14:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=h6mrWdofcrtrzqcKvONvkAEyB6kUVLduR2uDcQefQ+4=;
        b=grCx+YteB0s/VRb7e+unsObM4enqA8ctmSiTLn7oXX+dPYqI/xrEnGmPQYmD7hrt2e
         dZrwNkKTRLXeF5v3LBRSwo6Pr8cnIIy9tmgdfUMhABXWPmUIBqZtn/ziYLqRjmGQLHR9
         fEpSwemtNzeMp7jQhBI2UI6FyhdqpY12y7+e6XPipovcZ0od1hiNOEEMr2EG4DVJqhRJ
         zhF/0/JT8r+DvWma9BnWd+kZyuHnix0cibgFSPGiRcMRhYquuKS02uBfA+WWx8vURKRk
         YoR88R2BgOBQsYafYJ7zAJL15ogJMoCVI0g4cJmOi+sqlPv0zJR4+LtTdFAf62clfxB8
         dwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=h6mrWdofcrtrzqcKvONvkAEyB6kUVLduR2uDcQefQ+4=;
        b=sCPKRAHgyFKJjQox78I/U2Gla2s5h4hNJsf9GIXDFV2x6b1tEM+nExQ3kHSv7E3oV2
         0sYLvRhL9ddQmDZ9Nn88RSBqQfrMm07Zt65NTbOafhrvoHCkIPJ61zMZ3UWsFafy3FTQ
         US/hlqEdKrbhkEK+jN+5+6TE/uild/+taDYhbMfXnGT0kHk9AVEl63I8eynixG0WwoWg
         r23IUtcqG1muFsPS0bI1ylohF9a/VF/NSM1gzqvdvEzd+E3tggr7yzkKr+uMEhALqeOX
         ckf7hPDwnW0hx8khg1/dQqEA+2pOCxBjMMRJbvavnOGBjQ5aNWdiQa3XvwaKNdQC9fpw
         k43A==
X-Gm-Message-State: AMke39lBqSUo2fAXoXQaMolminqf5CaCD68iPv8yx9HqTzWIc/syjoO2x+xu9u4QpGnAdA==
X-Received: by 10.46.21.92 with SMTP id 28mr1280753ljv.81.1487976473325;
        Fri, 24 Feb 2017 14:47:53 -0800 (PST)
Received: from [192.168.1.26] (acuy7.neoplus.adsl.tpnet.pl. [83.11.104.7])
        by smtp.googlemail.com with ESMTPSA id a138sm2289306lfb.2.2017.02.24.14.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 14:47:52 -0800 (PST)
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
Date:   Fri, 24 Feb 2017 23:47:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170223164306.spg2avxzukkggrpb@kitenet.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have just read on ArsTechnica[1] that while Git repository could be
corrupted (though this would require attackers to spend great amount
of resources creating their own collision, while as said elsewhere
in this thread allegedly easy to detect), putting two proof-of-concept
different PDFs with same size and SHA-1 actually *breaks* Subversion.
Repository can become corrupt, and stop accepting new commits.  

From what I understand people tried this, and Git doesn't exhibit
such problem.  I wonder what assumptions SVN made that were broken...

The https://shattered.io/ page updated their Q&A section with this
information.

BTW. what's with that page use of "GIT" instead of "Git"??


[1]: https://arstechnica.com/security/2017/02/watershed-sha1-collision-just-broke-the-webkit-repository-others-may-follow/ 
     "Watershed SHA1 collision just broke the WebKit repository, others may follow"
