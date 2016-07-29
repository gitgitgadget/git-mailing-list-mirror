Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF141F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 07:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbcG2Hq5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 03:46:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36039 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcG2Hqz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 03:46:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so14469967wma.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 00:46:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=oN4hjpYA6yVH/BaGQQ0WnaJsWJ98K2QUfceHBN300tk=;
        b=R8BUGKvtR8J/htm+XPwbZomX3MjOUHX49oGNYd2rQ2ZTUA18Sip8uc/xO+b64/8d0z
         q9pu8NuuvdCvnC7MtUYmIz45kQFWByZeQHIGRuFlX0Qq79wdQoJNOMkkGr5R8qgDPJlC
         nMEjidN6e43QscQzXazBtEXB7EVML8enYqGtK+T4aQzs5CZQTXD9dOZ8goYe1a0Gu/Gh
         cE706qiDE7wJ684D36UbBceI3TrqvA0Qwe5DlGmkNiZVfKctd63q4HSzP9JrHEdMYj+r
         OuofHno/2UhgPppXFO78VA6+fhWpjIi0AoRP0aHwLsxpERu+43P85qPHZvyGqkAC3Q9c
         87ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=oN4hjpYA6yVH/BaGQQ0WnaJsWJ98K2QUfceHBN300tk=;
        b=d6n9zb3eTGVCnN9/hZN2AMEs1p8lWE94Swr7lke/836Paof5QhDk+7rVIn39mQQHSL
         wrfJ19/HrPjrUAHpo/KcfGLAYf+uviLUXu/W8quQyXoFgg6oN/R+X+MZxOvdN9pbdA1z
         Rx0OWyvaPUjeHJV5ie4bvfuSWUi+aVVrjQRkvIIj8xGqNVe/sO+gz0ZeQXzLroWXqDQ7
         RgsByG7513oGi87AHKRpKxLgIUkNsv9PaM1tcebsW3kG7fXmrPr0XKQSPqmelbepvPku
         sWWsVGGf5dS2svQEddAWLyd1Vlf3GIOPgdc+S/NydPNjQGMk4FHenI9ygxXE+J5hTeqV
         qk7w==
X-Gm-Message-State: AEkoousRcbxUxnzg0uLSBzGksB/Lmwpn87tnFrvaya5hKH329c+o/ITZmjhJJQ8MKN7NiA==
X-Received: by 10.194.77.142 with SMTP id s14mr36320803wjw.77.1469778414218;
        Fri, 29 Jul 2016 00:46:54 -0700 (PDT)
Received: from [192.168.1.26] (ewj64.neoplus.adsl.tpnet.pl. [83.20.233.64])
        by smtp.googlemail.com with ESMTPSA id a2sm1728548wma.2.2016.07.29.00.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2016 00:46:53 -0700 (PDT)
Subject: Re: [PATCH 0/3] diff-highlight: add support for git log --graph
 output.
To:	Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org
References: <20160728162712.GA29220@tci.corp.yp.com>
Cc:	Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <579B09DD.9000603@gmail.com>
Date:	Fri, 29 Jul 2016 09:46:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160728162712.GA29220@tci.corp.yp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-28 o 18:27, Brian Henderson pisze:
> Hi, I've been working with Jeff King on this patch, but he encouraged me to
> email the list.
> 
> I recently learned about the diff-highlight tool and find it very helpful,
> however, I frequently use the --graph option to git log which breaks the tool.
> This patch looks to fix this.
> 
> I wanted to try and add some tests as well, but I was unsure what number to
> pick for the second digit. As there were limited tests in the contrib directory
> (only t93xx and one t7900) I just chose the next number in the 9xxx range.
> Please let me know if I need to change it.
> 
> I'm also not super happy about my test case for the graph option. If anyone has
> any better ideas, please let me know!
> 
> Brian Henderson (3):
>   diff-highlight: add some tests.
>   diff-highlight: add failing test for handling --graph output.
>   diff-highlight: add support for --graph output.

Could you please follow SubmittingPatches, and send patches in separate emails,
inline, with those emails being replies to cover letter (like `git format-patch`
and `git send-email` would do), and not as attachments to cover letter?

With email as it stands it is really difficult to review individual
patches.

> 
>  contrib/diff-highlight/Makefile                  |   5 +
>  contrib/diff-highlight/diff-highlight            |  13 +--
>  contrib/diff-highlight/t/Makefile                |  19 ++++
>  contrib/diff-highlight/t/t9400-diff-highlight.sh |  76 ++++++++++++++++
>  contrib/diff-highlight/t/test-diff-highlight.sh  | 111 +++++++++++++++++++++++
>  5 files changed, 218 insertions(+), 6 deletions(-)
>  create mode 100644 contrib/diff-highlight/Makefile
>  create mode 100644 contrib/diff-highlight/t/Makefile
>  create mode 100644 contrib/diff-highlight/t/t9400-diff-highlight.sh
>  create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh
> 

