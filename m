Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5C520286
	for <e@80x24.org>; Fri, 15 Sep 2017 07:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbdIOHu4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 03:50:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37960 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdIOHux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 03:50:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id p37so815964wrb.5
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ITqZjILcpqGRACwE0Axdlw4j3eQay8O99DLQNCmH/1I=;
        b=oqjMyhaijyPMMLZS/galrNP+gISO0yuA+hp+muqntspxrUbCRcTqPr6xlmLDb+/lzo
         MvbEDhiMkVt3n2AhiCingRNALViTn5l5AjPsUu8oKZ7RpxNnkSBQ1zprKQb/GkupJJov
         8kvkHlZHdk7tCdJpboInZkEzM96gAX8Ab4mRVE8B7j9ECei/HgGCEO+B2qW1PP6TuV5z
         lZyQ+Fe/csognwH6v46+qz6oebKXvTNcVs5wrAHjrQESJAD6Cd2en6J8dRdjbAWgEG+e
         HoGxYidcfrh0Rip/KVNU6/eNn6s01sw9uSaCamlFLY/5XoYIk5ClblGOFLtRnrAl4Uzy
         NrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ITqZjILcpqGRACwE0Axdlw4j3eQay8O99DLQNCmH/1I=;
        b=XSgKj+h6S1v9oMXPIlqJHRYrySwAlSgIN6laECF20BBqxPPTKAf3ndiQsaidIuu97G
         PXLhCpC6g/KtogaaeYPL7EYHc9ppTwjizSS0WaNdWAl9C/MiMmSHG1eYcgbGI138RSoW
         xEs3zSh6BfGY8Lctg6FkRaJXQ03JGPIM8c2yyj7cprgdSiQxKkcTKDiITOIpmM3xX8Oj
         J5g7rYBRn2EcsgLoXbSJcWTQkRMhb5AxANBD3mUVjFLiGPbOggM4cKuTS3HRuIL4Kobm
         hYKAzdLE6KAo1swbPKMBRuhMquB73X9YY0SPmIe9blBjrB5v+mj6uTRtI0rhcNI2Bwxp
         q8Rg==
X-Gm-Message-State: AHPjjUiFHx2Da3PaqdiZo1wTxrc7Okt0kieqg+Z3R39Rs3Z+FTyEn24f
        rCjCQYMZBrDEHw==
X-Google-Smtp-Source: ADKCNb4/PH08BsPS1Bl4vzl1Sf39LxxXtf1i21qLKd24XlIU4BbbaGZjqyifsVfGAGf7IT4G2qWU3g==
X-Received: by 10.223.142.83 with SMTP id n77mr19503440wrb.108.1505461852031;
        Fri, 15 Sep 2017 00:50:52 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5D87.dip0.t-ipconnect.de. [93.219.93.135])
        by smtp.gmail.com with ESMTPSA id w4sm304334wrc.78.2017.09.15.00.50.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 00:50:50 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 15 Sep 2017 09:50:48 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <44574AF3-D215-4486-B7AE-72F83CC934C5@gmail.com>
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 15 Sep 2017, at 07:58, Junio C Hamano <gitster@pobox.com> wrote:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

> ...

> * ls/travis-scriptify (2017-09-11) 3 commits
>  (merged to 'next' on 2017-09-14 at 8fa685d3b7)
> + travis: dedent a few scripts that are indented overly deeply
> + travis-ci: skip a branch build if equal tag is present
> + travis-ci: move Travis CI code into dedicated scripts
> 
> The scripts to drive TravisCI has been reorganized and then an
> optimization to avoid spending cycles on a branch whose tip is
> tagged has been implemented.
> 
> Will merge to 'master'.

SZEDER noticing a bug in this series that I was about to fix:
https://public-inbox.org/git/3B175D35-5B1C-43CD-A7E9-85693335B10A@gmail.com/

I assume at this point a new patch is better than a re-roll, right?

Thanks,
Lars
