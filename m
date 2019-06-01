Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3A11F462
	for <e@80x24.org>; Sat,  1 Jun 2019 10:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfFAKrT (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jun 2019 06:47:19 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:32800 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfFAKrN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jun 2019 06:47:13 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id X0ELhlSMTdraxX0ELhIuhr; Sat, 01 Jun 2019 10:23:13 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=uY0RQopZbdGGBb7OyxoA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH] make slash-rules more readable
To:     "Dr. Adam Nielsen" <admin@in-ici.net>, git@vger.kernel.org
References: <20190531074426.6810-1-admin@in-ici.net>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <6f633212-7ea8-0d26-3476-fa5a2142ef06@iee.org>
Date:   Sat, 1 Jun 2019 10:23:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531074426.6810-1-admin@in-ici.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfOH8mabDEPc16BtXIhjRhBYbK4+MuUtyyQRHMzcoI//kpXMtRWzT7aRObBnePzcWFpxODEmlEqUMGInsAK1kSTI51K0iMIarfdynDs9GwEa+Yq6q1vWP
 62pQ5fNQvVsv5LY/5I3xGoAwh5ImnHf+9BTqeostJBLZK1Nq1TRAGjdesc22LeWrY06KLtNYE7FaWWqJ52OyTUmWq0ZYWu2Ec20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor spelling mistake at end:
On 31/05/2019 08:44, Dr. Adam Nielsen wrote:
> +   (a regular file), "foo/bar" (a diretory), but it does not match
> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
> +   patter does not match "bar/hello.c" which has a slash in it.
s/patter/pattern/
> +
>   --------------------------------------------------------------
Philip
