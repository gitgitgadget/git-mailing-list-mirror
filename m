Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1C620286
	for <e@80x24.org>; Sat,  9 Sep 2017 06:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdIIGl6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:41:58 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49284 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751244AbdIIGl6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2017 02:41:58 -0400
X-AuditID: 12074414-0ebff70000006ddf-ca-59b38d357508
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.1B.28127.53D83B95; Sat,  9 Sep 2017 02:41:57 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC859.dip0.t-ipconnect.de [87.188.200.89])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v896fsEa020819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 9 Sep 2017 02:41:56 -0400
Subject: Re: [PATCH v4 16/16] refs.c: reindent get_submodule_ref_store()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
 <20170823123704.16518-17-pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a445a47f-9fe9-1c56-8e14-eb5aafbdbb0f@alum.mit.edu>
Date:   Sat, 9 Sep 2017 08:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823123704.16518-17-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42IRYndR1DXt3Rxp0DCPy6LrSjeTRUPvFWaL
        7ilvGS02b25ncWDx2DnrLrvHgk2lHhcvKXt83iQXwBLFZZOSmpNZllqkb5fAlXF0zUP2grec
        Ffe+/WZuYLzA3sXIySEhYCIxtfc7kM3FISSwg0niXesJVgjnHJPEorsT2UCqhAU8JN6e3MYE
        YosIpEksnvyeuYuRg4NZwEti3sdykLCQQIrE2iXzwIayCehKLOppBivnFbCX2HL3NjOIzSKg
        IvFm01VGEFtUIEKi7+1ldogaQYmTM5+wgNicAhYS5/b/AOtlFlCX+DPvEjOELS5x68l8qLi8
        RPPW2cwTGAVmIWmfhaRlFpKWWUhaFjCyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3StdDLzSzR
        S00p3cQICXGRHYxHTsodYhTgYFTi4a3YvilSiDWxrLgy9xCjJAeTkijvhdrNkUJ8SfkplRmJ
        xRnxRaU5qcWHGCU4mJVEeKu6gHK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2Cy
        MhwcShK8z7uBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCG/wOp4S0uSMwtzkyHyJ9iVJQS530PslUA
        JJFRmgfXC0tBrxjFgV4R5g3qAariAaYvuO5XQIOZgAaXPN8AMrgkESEl1cBYvOfpzcW3FqRp
        Zb8WzV/1//MCndAlJU2hq1iurnD/cSSzbsZXJeWqzZrcn36x8B3uPv1G5dmvCxpP1NZaynCc
        rCib5O5Twha6gulZav3USkH14D/l1hN5Fgl83WT43OJ/1+zaR/8nStpOZ2c3O2JwTUXx3Bmz
        VwkSUzL+PDwi9Ot19XcF/5I6JZbijERDLeai4kQAJnrrnRwDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2017 02:37 PM, Nguyễn Thái Ngọc Duy wrote:
> With the new "if (!submodule) return NULL;" code added in the previous
> commit, we don't need to check if submodule is not NULL anymore.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index a0c5078901..206af61d62 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1590,13 +1590,11 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  	if (!submodule)
>  		return NULL;
>  
> -	if (submodule) {
> -		len = strlen(submodule);
> -		while (len && is_dir_sep(submodule[len - 1]))
> -			len--;
> -		if (!len)
> -			return NULL;
> -	}
> +	len = strlen(submodule);
> +	while (len && is_dir_sep(submodule[len - 1]))
> +		len--;
> +	if (!len)
> +		return NULL;
>  
>  	if (submodule[len])
>  		/* We need to strip off one or more trailing slashes */
> 

Now I'm confused. Is it still allowed to call
`get_submodule_ref_store(NULL)`? If not, then the previous commit should
probably do

	if (!submdule)
		BUG(...);

Either way, it seems like it would be natural to combine this commit
with the previous one.

Michael
