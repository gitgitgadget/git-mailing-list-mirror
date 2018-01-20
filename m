Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB161F576
	for <e@80x24.org>; Sat, 20 Jan 2018 11:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbeATLK2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 06:10:28 -0500
Received: from mout.web.de ([212.227.17.11]:50780 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeATLK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 06:10:26 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McFLP-1eLbIf040t-00JaqU; Sat, 20
 Jan 2018 12:10:14 +0100
Date:   Sat, 20 Jan 2018 12:10:12 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 0/6] Force pipes to flush immediately on NonStop
 platform
Message-ID: <20180120111012.GA26459@tor.lan>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:5ty0euPACCqTDsw+IumPdx1q1i6VwqtfxJ4a4l5VkaxL3ek98HM
 ZffWBRWCYVJqP+3GSFIgoSDuc2pN/WI+7ooj4UEB4rra6ISDHFdN1dCBLqU82soabCcpiYw
 gv5h21BqgcHWJgmz+ntPY7nIP8YyWotly2qquyLGy6L1YI7bc6lwkSfeFKbq1hVLRZF89W5
 YOYee2DrNwkAzW4yHNZ+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EOzqXpePRoc=:ySm6CZvPuO1+Yh2tyLxon6
 WagRVALivVbs1rDqxsXKmRPM85X4u3B1kb+mqBPB77Vra5ODBe27Dgipaq4OV4lXeVTxcxSM9
 0qu0khIPbGjZp70b0OeERWPHQMkzgOVNFjQb5IxnAVrpFSNT6f2HEjVxmkWF8WspxEfRQwVck
 fvOwOq5whw9oa/p2jS+MLBmKWfUSy1NOlKj3Ss+PFBX+a1IkodLLVRx7fLKREUrSolNVzrWTo
 0KW5UfJADwjx0LbDujhmJI65bpM8aY9ehN0H3Z7TnoxAfh0VAwxQWMPgnqtrH1d9f5l7G2dk/
 rAqhIxLWrk0bMh3v9BKu5BAuba9E0J5zFS8jZ8LhqA82eeXkgK77fvAkhPaGAM8jp79fUJ1lB
 0Y4QdH1SjZTvawUHvm2Pa7+6CSuzHA1rV+xiQSXTUDExiWQp1t81OT9Aav4wfu+G+/RD2ImW9
 WRFLsP8HV1QHq60f12hjF4ffU+olW+J33Q7hQK5Pqw/2so0fW3FbWULgr+WnIKghBmjsXGCGs
 0+sZvyCUT/5Sl0oWovhVI5eTZVW0P//GDFFhdXQYsskAgXr0OtZk8dp/Sw5JX574XebbaiTBr
 9Hk9WEMUWfYtct+XH5VSuMb7gAFZS92xEeEBRth0efqBsynAcI6gw/bHKDjX2jEZkpSv0ZqC+
 THbVfIrEYZvc/yL41HJqSQrA+dI34elLB10N/s/iuP7W0bipNfi8Ppy6+f1LcuQfnzxVcccRg
 zYdJeZ5uY+RJLqnKtDJ0UIGp4a7DoUEgTSUa4btvj04H3BaXuHbqYNo+WLoBHr2UVdT/wmZgX
 fsbJCfjh6QAdvpPZdd0eUWKetiDGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 12:33:59PM -0500, randall.s.becker@rogers.com wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> * wrapper.c: called setbuf(stream,0) to force pipe flushes not enabled by
>   default on the NonStop platform.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  wrapper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/wrapper.c b/wrapper.c
> index d20356a77..671cbb4b4 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
>  	FILE *stream = fdopen(fd, mode);
>  	if (stream == NULL)
>  		die_errno("Out of memory? fdopen failed");
> +#ifdef __TANDEM
> +	setbuf(stream,0);
> +#endif

Reading the commit message, I would have expected someting similar to

#ifdef FORCE_PIPE_FLUSHES
	setbuf(stream,0);
#endif

(Because other systems may need the tweak as well, some day)
Of course you need to change that in the Makefile and config.mak.uname

>  	return stream;
>  }
>  
> -- 
> 2.16.0.31.gf1a482c
> 
