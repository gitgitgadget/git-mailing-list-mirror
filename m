Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE256202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbdGESTp (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:19:45 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36122 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdGESTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:19:44 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so128079853pgb.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=hlFX2pQbnwLK7JN94RVieTcv/H8S23No0p6oGIGWF1k=;
        b=puxuq+qkzYcbdo7Odxaptxgb7UjEkgVMwe3YdDSiz/oq/ea1tuCWsa0qQ5R1ctzRvL
         ah9YP93zJ9wSvYlAglPp44yjX61TcSMz4DrXFE4Xy/Hsp0Uodo6cKm81DJr7GDU+plVf
         JTHk4lVAeQpUu0cFRUfneCC4QWTfxdBSA0+t4oTC9mfmO6fVuZ+8WqyB3trFuULhei1+
         xJy0dhceXKGf8zbpCKKUT+Q7MiDzSUkMli1ihkxzqhTP7tl7iqNH+j+wecpe9t2/mFzO
         dlH9ijxtbN1dY/ww6U5w/tmx+W2cN5GkWt2zJYBvjuEmZx5pPuq6VxdokQACJEimyHFf
         npyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=hlFX2pQbnwLK7JN94RVieTcv/H8S23No0p6oGIGWF1k=;
        b=qcjVfwTxRZNfzn8RMHAZSjbpPiLt0btTC/t6UBtZCjTRoEJP0GLiiZGfaY/+2MD6Ky
         U7D1YUUCe1QRMQCGFXRgSdltn8Cis7gPmwhUwN1KlbQTcnfS5o8QznnyI3XFFdi+o35N
         z3XIa2uLgnqPayQZCCKxOr5A+08OwqknZFx5BVypf1cj7gAARp/bFsKT2I4GY5z/rigZ
         E8hecwBjt/4sKaqdMlZTANgp8h+asdfwfZRMJf/xW6m8gyOcHGFv8aykMmIKXgBGAL4M
         PG9dIXhdpIxCxlmhGAWWb+SFKwNbwL9E9rWkhmbDKSWo2OHso7PgxlW5meOfHHn1du0r
         am9w==
X-Gm-Message-State: AIVw112OUfppqpPczksrAWTdHIaDDiNLnEspgu5Hb6SVdDLodF/2zhdu
        ujYIZhXwf5aBBw==
X-Received: by 10.98.80.198 with SMTP id g67mr22262065pfj.146.1499278784121;
        Wed, 05 Jul 2017 11:19:44 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id r69sm53255894pfg.28.2017.07.05.11.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 11:19:43 -0700 (PDT)
Message-ID: <1499278787.1791.2.camel@gmail.com>
Subject: Re: Requesting suggestions for a good sample "prepare-commit-msg"
 hook
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Wed, 05 Jul 2017 23:49:47 +0530
In-Reply-To: <1499275601.16389.6.camel@gmail.com>
References: <1499273152.16389.2.camel@gmail.com>
         <xmqqwp7miztv.fsf@gitster.mtv.corp.google.com>
         <1499275601.16389.6.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, 2017-07-05 at 10:00 -0700, Junio C Hamano wrote:
> > I am not so sure that we are searching for them, to be honest (who
> > are we in this context anyway?)
> 
Imagining HTML could be used in plain-text,

<strike> I think I misinterpreted your sentence in one of the other
mails (found below), </strike> Sorry for that sloppy sentence. More
correctly, the "we" in that context is the same as the "we" in the
context of the text quoted below,

>     That sounds like a sample that is there not because it would be
>     useful, but because we couldn't think of any useful example.
> 

Link to the post that has the quoted text,
http://public-inbox.org/git/%3Cxmqqy3s7nbkm.fsf@gitster.mtv.corp.google.com%3E/
