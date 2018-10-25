Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529601F453
	for <e@80x24.org>; Thu, 25 Oct 2018 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJZDeh (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:34:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:37319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbeJZDeg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:34:36 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b03-1gRcqB0OeV-00D3e5; Thu, 25
 Oct 2018 21:00:28 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b03-1gRcqB0OeV-00D3e5; Thu, 25
 Oct 2018 21:00:28 +0200
Date:   Thu, 25 Oct 2018 21:00:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        github@brendanforster.com
Subject: Re: [PATCH] http: give curl version warnings consistently
In-Reply-To: <xmqqsh0uln5c.fsf_-_@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810252059510.4546@tvgsbejvaqbjf.bet>
References: <pull.46.git.gitgitgadget@gmail.com>        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>        <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>        <xmqqzhv2lnn6.fsf@gitster-ct.c.googlers.com>
 <xmqqsh0uln5c.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mxhaOtGPSTgR+NqpbkKDUAyMQI36U7nTGDW9kFCG6y+94sRm2o7
 uylj6nrLWZhWqW1iE1VlEVOkJlQvIzG30deTX/mdqrkevFcaQ5zFIk+tiEZ9t4xC5d5GyQX
 EOItZhUOaZ75k6/Y7fZjNfJw6o7LUDIXf6iGlPBW5E+S1UYBchRIqL9yD7O3xNVnkv3LU0S
 TfokWZBONeac0uwmjC8Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kw9GAoKedrE=:XotcOH6mw8xbGjgnP2Xwh9
 wAHpywmhYiiOUcuO2x+o7BhqhR78qkpW37g6/gbozVOn3SrSsIKV8ETaSq6qRYzOy+TwlV7Qk
 XQrJK2WwuyebnCtZBYkS1X7LgTpfqXqOfrZSpdQN459bUOuxkZQjrVQ0WPuov4g65skyw0j/O
 itig/QjeG1Emviw5Xp/lC0EQelej0AbLcO6utC5xmy696zHYq7UTBvIWNmK7jFVLqb000Ct2q
 s2QXOusTwfv14peaMJ53pT3xIurkfXSWScNQ4xw7riI54+4jzbIc6iGgtP+QHBIK+iEA2TSCb
 GhbnGlEQ6W55E8ZUL/y35kCpJT+ZzfPV4VyPnfKUpNU3dJo/Fuk0o7LxfJknZ/00B2jloDjHv
 qZED/ymcEWElUaL2QLn75g3u01OFY4JUnGDGcSp5BZBhYTGU0cmceO2PDMa4AkCySsxaxHius
 QLy6xZRXn8DCCoy7DcX7FZIf7zb0yeGjpj9B8YrjGlM8X8sFshI6vo7uS8ee8fdUdWxRZsIkX
 Y7ALUh6AcB9l1Vhkrb9rOFyJSAIdBm+JlGxcIx81/B/DxesMFdfDhDNGTt/b1I8RCw0vEOWL1
 +Jit+4WXvD/h7SioR+4XqDuaEHR2gSZY54vKsZqVQsq9Ni/CUecS3qbuMQwWu2AydFhFV8gt0
 g6JhgyTUYY2yWPuSpoIgxwUjmYOAjrnJni3sd1mmxogNjjryk11O53Y83GVycZxMaxmrzNTh5
 vCbwOtKAAjQJa9tfX3d9IzduKXl0hbqhZEMBLhdwOEGQmyNWHXncSk1GXbQH1QpuXQiNnfTS0
 Qvz2PsvT8ZvKsWt8/e9KECRO9w6fGzMa7KnmVym+M+0Y+IkJzI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Oct 2018, Junio C Hamano wrote:

> When a requested feature cannot be activated because the version of
> cURL library used to build Git with is too old, most of the codepaths
> give a warning like "$Feature is not supported with cURL < $Version",
> marked for l10n.  A few of them, however, did not follow that pattern
> and said things like "$Feature is not activated, your curl version is
> too old (>= $Version)", and without marking them for l10n.
> 
> Update these to match the style of the majority of warnings and mark
> them for l10n.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I like this patch better than the one I had prepared for v2, so I dropped
it again, and "hit the Submit button".

Ciao,
Dscho

> 
>  > I have a clean-up suggestion related to this but is orthogonal to
>  > this three-patch series (after the fix-up is applied, anyway), which
>  > I'll be sending out separately.
> 
>  So, here it is.
> 
>  http.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/http.c b/http.c
> index 43e75ac583..2214100e3b 100644
> --- a/http.c
> +++ b/http.c
> @@ -834,8 +834,7 @@ static CURL *get_curl_handle(void)
>  #if LIBCURL_VERSION_NUM >= 0x072c00
>  		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
>  #else
> -		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
> -			"your curl version is too old (< 7.44.0)");
> +		warning(_("CURLSSLOPT_NO_REVOKE not suported with cURL < 7.44.0"));
>  #endif
>  	}
>  
> @@ -908,8 +907,7 @@ static CURL *get_curl_handle(void)
>  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
>  			 get_curl_allowed_protocols(-1));
>  #else
> -	warning("protocol restrictions not applied to curl redirects because\n"
> -		"your curl version is too old (>= 7.19.4)");
> +	warning(_("Protocol restrictions not supported with cURL < 7.19.4"));
>  #endif
>  	if (getenv("GIT_CURL_VERBOSE"))
>  		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
> -- 
> 2.19.1-542-gc4df23f792
> 
> 
