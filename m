Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E200D201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbdB1Rbn (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:31:43 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53345 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751337AbdB1Rbm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 12:31:42 -0500
X-AuditID: 12074413-f4fff700000077e1-d5-58b5b11a9920
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 59.17.30689.A11B5B85; Tue, 28 Feb 2017 12:19:23 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SHJJlR014770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 12:19:20 -0500
Subject: Re: [PATCH v5 05/24] files-backend: move "logs/" out of
 TMP_RENAMED_LOG
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-6-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <cb86192d-8644-bed3-1e73-821931589e79@alum.mit.edu>
Date:   Tue, 28 Feb 2017 18:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-6-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1JXeuDXCYFITn0XXlW4mi4beK8wW
        /cu72CyWPHzNbNE95S2jxcyr1habN7ezOLB77Jx1l93jw8c4jwWbSj262o+weVy8pOyxf+k2
        No/Pm+QC2KO4bFJSczLLUov07RK4MtY3v2cpWC9R8WvKd/YGxm/CXYycHBICJhJPpixi6mLk
        4hAS2MEksffbJjYI5yyTxIb1S5hAqoQFgiRWf29nBbFFBNIkFk9+zwxiCwn0M0ocuRgI0sAs
        cINR4tLEj2ANbAK6Eot6msFsXgF7iW2L9wE1cHCwCKhKPP7DDRIWFQiRmLPwASNEiaDEyZlP
        WEBsTgFzia93poLtYhZQl/gz7xIzhC0v0bx1NvMERv5ZSFpmISmbhaRsASPzKka5xJzSXN3c
        xMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQYBfewbjrpNwhRgEORiUe3gPdWyOEWBPLiitz
        DzFKcjApifIGzQAK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHdUQyU401JrKxKLcqHSUlzsCiJ
        86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8JpuAGoULEpNT61Iy8wpQUgzcXCCDOcBGu62HmR4
        cUFibnFmOkT+FKOilDivNUhCACSRUZoH1wtLRq8YxYFeEeZ9CFLFA0xkcN2vgAYzAQ1+oQI2
        uCQRISXVwLj52w8e7hluJvyRX/+KPzV+ycJXP7tYzHGR2WulqnD/ewsb3lazvfbzcZBuWv32
        dZbf9/vRP1TjLwb26hfOEL7+SMpkwr+ki++/3yh9aSG+ZUlW4I559mFf6rb0P3pi8Dr78KLc
        5LpDUlHd1laf2W+kJci9l3jBOed2291THt8z9x45dHChfI8SS3FGoqEWc1FxIgAujysQIQMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> This makes reflog path building consistent, always in the form of
> 
>     strbuf_git_path(sb, "logs/%s", refname);
> 
> It reduces the mental workload a bit in the next patch when that
> function call is converted.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 435db1293..69946b0de 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2513,7 +2513,7 @@ static int files_delete_refs(struct ref_store *ref_store,
>   * IOW, to avoid cross device rename errors, the temporary renamed log must
>   * live into logs/refs.
>   */
> -#define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
> +#define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"

The constant name feels a little bit misleading now that it is not the
name of a logfile but rather a reference name. OTOH "tmp-renamed-log" is
*in* the reference name so I guess it's not really wrong.

>  struct rename_cb {
>  	const char *tmp_renamed_log;
> @@ -2549,7 +2549,7 @@ static int rename_tmp_log(const char *newrefname)
>  	int ret;
>  
>  	strbuf_git_path(&path, "logs/%s", newrefname);
> -	strbuf_git_path(&tmp, TMP_RENAMED_LOG);
> +	strbuf_git_path(&tmp, "logs/%s", TMP_RENAMED_LOG);
>  	cb.tmp_renamed_log = tmp.buf;
>  	ret = raceproof_create_file(path.buf, rename_tmp_log_callback, &cb);
>  	if (ret) {
> @@ -2626,12 +2626,12 @@ static int files_rename_ref(struct ref_store *ref_store,
>  		return 1;
>  
>  	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
> -	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
> +	strbuf_git_path(&tmp_renamed_log, "logs/%s", TMP_RENAMED_LOG);
>  	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
>  	strbuf_release(&sb_oldref);
>  	strbuf_release(&tmp_renamed_log);
>  	if (ret)
> -		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
> +		return error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
>  			oldrefname, strerror(errno));

It seems like it would be preferable to use `sb_oldref.buf` and
`tmp.buf` when building the error message. But I guess that `tmp.buf`
might include some path preceding "logs/" that is unwanted in the error
message? But it's a shame to hardcode the file naming scheme here again.

Maybe we *do* want the path in the error message?

It just occurred to me: this temporary logfile lives in the main
repository, right? What if a worktree reference is being renamed? Part
of the advertised use of worktrees is that the worktree might live far
from the main directory, or even on removable media. But it's not
possible to rename files across partitions. Maybe this will come out in
the wash once worktrees are ref_stores themselves.

For that matter, what if a user tries to rename a worktree ref into a
common ref or vice versa?

>  	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
> [...]

Michael

