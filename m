Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206531F461
	for <e@80x24.org>; Sat, 18 May 2019 19:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfERTew (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 15:34:52 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:4377 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfERTev (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 15:34:51 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id S56XhoV2pnuQZS56XhC1Ya; Sat, 18 May 2019 20:34:49 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=b4GSQUfwuEDkhX-jwPoA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH] make slash-rules more readable
To:     "Dr. Adam Nielsen" <admin@in-ici.net>, git@vger.kernel.org
References: <20190518140759.14500-1-admin@in-ici.net>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <7b062fd1-c793-b8b9-c997-90f53f958e2c@iee.org>
Date:   Sat, 18 May 2019 20:34:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190518140759.14500-1-admin@in-ici.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfJOqwt83aQowRCN1gId3SIJxnbi8YD7ful3lvlvEgBdNs/oWRh0zIpmD1SvEyf6j8Gys9DSISI+A4GaqbUAQmO/h9DVmeALZ8cZIdxbpy5Tfu2glmJAR
 4MtrgFx2VVnPsRSBw57Dio2kCGRjTr89TtTMB1L6x6HPShTy9IqMgAUlPomJFsTcpUy0WG9i9C8N9ArDjAKfR1SaH3Hl2asKw7o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam

On 18/05/2019 15:07, Dr. Adam Nielsen wrote:
> + - If the pattern contains no slash or only a trailing slash,
> +   the pattern is matched against all files and folders (recursively)
> +   from the location of the `.gitignore` file.
> +   For example, `frotz/` matches `frotz` and `a/frotz` that
> +   is a directory (relative from the `.gitignore` file).
This "Otherwise" below could be the complement to the initial "If", or 
could be part of a "matches" pair of example sentences. At least on my 
initial reading I paired it via the 'matches'.

A blank line separator make make it more obvious.  Alternatively, make 
the "For example" parts flow as part of their previous lines.
If you go for an additional blank line then the next next para needs to 
clarify it's 'above' as their will be two paras, not one.
> +   Otherwise the pattern is matched relative to the
> +   location of the `.gitignore` file.
> +   For example, `doc/frotz/` matches `doc/frotz` directory, but not
> +   `a/doc/frotz` (relative from the `.gitignore` file).

 > + - The above pargraph also includes the case of a leading slash.

s/pargraph/paragraph/
--
Philip
