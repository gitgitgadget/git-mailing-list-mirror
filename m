Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196971F404
	for <e@80x24.org>; Tue, 26 Dec 2017 18:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbdLZSEW (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 13:04:22 -0500
Received: from mout.web.de ([217.72.192.78]:61998 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdLZSEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 13:04:22 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8bi-1eLk7Z0sMw-00S32w; Tue, 26
 Dec 2017 19:04:19 +0100
Subject: Re: [PATCH] status: handle worktree renames
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     alexmv@dropbox.com
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
 <20171225103718.24443-1-pclouds@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f451553f-cef5-f3c4-ccdc-5ac300a62e8c@web.de>
Date:   Tue, 26 Dec 2017 19:04:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171225103718.24443-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:QGf0X/iuQMbBYVP/WQ7F8Lf2DuvXEWDbnYrtxVqEOI1FZGo4szm
 pY+hixy5MpyKVy4qqtPo3gdDVRjkkCfmPDlW+EhY4hxCDJfmP0SB2JT95+HCl2HCPVEUTyL
 vq55awkAJgv+SIAhToCAp9s6NBx7WRsasjNTiP03EJBbPcEU5DzD0PNM9pY/GsZ5isIZkd7
 7fp4zQ7OzccOODJQN1fFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VM8s4mqrsRw=:Jo+w6JhO5uwY1CGXnzntj9
 CeWPzfiFM9SsMSyha6hdrQ6nNwUNJH0Sr0iVrmiO9fjy5GKTE81RCRY4maIdyU2irQ16oyNPp
 f6kwm68ODFlz5NpiwRWunv9vEDYCwsARiwQm8A37wgYqpWfOjHg0cr81hTN3scsDUkeixEW2m
 wD6DBwN+UtT61Igj1x+ukPtcYFwXKnJ2AJAuWvywOz8LWnmHZ9vZEEcpJQiLMKZeneBfbNhGo
 HRrJVgcBu5EyDv0VbTVayjlipvJ/fNBhsEWq/S/+Vr9ZGkg6gId374cTQLs8uMSVaevyMJSab
 n9Bwd3U87z9CFwH2fQMPsGAcUhct+UpNIow6ZUro1++kiqh3jUHe5gm6/Gvy1Ul8+SJ0rHV0u
 FAAF9j87j4mZm7M77uWIc7dXyi8JezGCH8Ye0ZeR4jpNcHNpbFCD6QoYgjVBuMQGnPX9zge7B
 6+plaKNw2vBBq875+8IvWYHYPL4JteumJWhsRrGyE8Qoll9y0tc34y3+rzpwWamwQzzL8k0GR
 4krpLcrgw0/tsnvMO85CRC3JEf+LTItlccmy6KWr/hFWfYlhSUn6Po7JOMN8JC+A4tdT36/s+
 GWuP7tBu8NbEG1DjPz9GGqfmhamqkgObdhtxSqoeikVUt3J8SbtgwjV9ROyOoSDsKxJGbJGJ3
 luNZMmcz7mWCgb1WFkjtdAostvA9ymQufQ00ylytf29RVsFJDRLdxl8V9q7Cy1PXMaE9p8Vt1
 wLXPzVi8ph9ON1N4UJm4BoehCX88S0chsbzH8J9Y50CA5+dN//v+opcPNYF4n+H9AZ1BtjY15
 0a0GHXICYuhgFqxuqO88ZiLAVS9KJ1NIj+YSLq2OaEQbOKlMTI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-12-25 11:37, Nguyễn Thái Ngọc Duy wrote:
[]
>  wt-status.c           | 24 +++++++++++++++++++-----
>  wt-status.h           |  1 +
>  3 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 1bdf38e80d..41a8874e60 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -150,5 +150,20 @@ test_expect_success 'commit: ita entries ignored in empty commit check' '
>  	)
>  '
>  
> +test_expect_success 'rename detection finds the right names' '
> +	git init rename-detection &&
> +	(
> +		cd rename-detection &&
> +		echo contents > original-file &&
Micro-nit, please no " " after ">":
echo contents >original-file

