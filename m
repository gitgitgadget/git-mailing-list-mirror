Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37122201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 11:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbdBTLeg (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 06:34:36 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60611 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751341AbdBTLef (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 06:34:35 -0500
X-AuditID: 1207440f-129ff70000003517-ea-58aad443f0f9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.A1.13591.344DAA85; Mon, 20 Feb 2017 06:34:28 -0500 (EST)
Received: from [192.168.69.190] (p579060C0.dip0.t-ipconnect.de [87.144.96.192])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1KBYOB4026637
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Feb 2017 06:34:25 -0500
Subject: Re: [PATCH v4 06/15] files-backend: remove the use of git_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-7-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <1d750672-441d-14ae-21e9-d7bdd47a50a4@alum.mit.edu>
Date:   Mon, 20 Feb 2017 12:34:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170218133303.3682-7-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqOtyZVWEwZ61+hZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyvg28SVLwTmBits3tzI2MK7i7WLk5JAQMJH4u3sVWxcj
        F4eQwA4mie7md0wQznkmiWuPbjGDVAkLeEpsu/YRzBYRSJNYPPk9M0RRH6PE9auzwNqZBW4w
        Slya+JEJpIpNQFdiUU8zmM0rYC9x5sxvRhCbRUBVYlfbbjBbVCBEYs7CB4wQNYISJ2c+YQGx
        OQXMJDomb2EFsZkF1CX+zLvEDGHLSzRvnc08gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEz
        pzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJOD5dzB2rZc5xCjAwajEw9swe2WEEGtiWXFl7iFG
        SQ4mJVHeO0tWRQjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Z1yFijHm5JYWZValA+TkuZgURLn
        VV+i7ickkJ5YkpqdmlqQWgSTleHgUJLg5b8M1ChYlJqeWpGWmVOCkGbi4AQZzgM0/N0lkOHF
        BYm5xZnpEPlTjLoc295feckkxJKXn5cqJc67C6RIAKQoozQPbg4sUb1iFAd6S5i3AGQdDzDJ
        wU16BbSECWjJTY+VIEtKEhFSUg2MEVZbOW8vnf1xSi7nbZn9H/23CmlbrJpd8oDr+wyBrsQV
        c/T4WT6wTZD+JTLlwZdDCxhmTtbM5G9x+7lBU/nF11e9mqHRWapnQw+sa/X+Ga/eyn7ytUDY
        mqMuTq5ZQpOzrmZP0os8GDdLMcpyT3C0FN+dDcz/PJYkiQabLagJ21Z7aHtVWMRVJZbijERD
        Leai4kQAxLgS9S8DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/18/2017 02:32 PM, Nguyễn Thái Ngọc Duy wrote:
> Given $GIT_DIR and $GIT_COMMON_DIR, files-backend is now in charge of
> deciding what goes where. The end goal is to pass $GIT_DIR only. A
> refs "view" of a linked worktree is a logical ref store that combines
> two files backends together.
> 
> (*) Not entirely true since strbuf_git_path_submodule() still does path
> translation underneath. But that's for another patch.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 37 +++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index b599ddf92..dbcaf9bda 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -924,6 +924,9 @@ struct files_ref_store {
>  	 */
>  	const char *submodule;
>  
> +	struct strbuf gitdir;
> +	struct strbuf gitcommondir;

Is there a reason for these to be `strbuf`s rather than `const char *`?
(One reason would be if you planned to use the `len` field, but I don't
think you do so.)

> @@ -937,15 +940,33 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
>  {
>  	struct strbuf tmp = STRBUF_INIT;
>  	va_list vap;
> +	const char *ref;
>  
>  	va_start(vap, fmt);
>  	strbuf_vaddf(&tmp, fmt, vap);
>  	va_end(vap);
> -	if (refs->submodule)
> +	if (refs->submodule) {
>  		strbuf_git_path_submodule(sb, refs->submodule,
>  					  "%s", tmp.buf);
> -	else
> -		strbuf_git_path(sb, "%s", tmp.buf);
> +	} else if (!strcmp(tmp.buf, "packed-refs") ||
> +		   !strcmp(tmp.buf, "logs")) { /* non refname path */
> +		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
> +	} else if (skip_prefix(tmp.buf, "logs/", &ref)) { /* reflog */
> +		if (is_per_worktree_ref(ref))
> +			strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf);
> +		else
> +			strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);

This code would also be simpler if there were separate functions for
packed-refs, loose references, and reflogs.

> [...]

Michael

