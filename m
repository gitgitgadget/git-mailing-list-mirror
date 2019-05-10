Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218C51F45F
	for <e@80x24.org>; Fri, 10 May 2019 23:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfEJXJc (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 19:09:32 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:15926 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfEJXJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 19:09:32 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id PEdthGlhSp7QXPEdthVi3x; Sat, 11 May 2019 00:09:29 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=EdyoZ6NwNAtDJAbAi2gA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH] doc/gitattributes: add Octave
To:     Boxuan Li <liboxuan@connect.hku.hk>, git@vger.kernel.org
References: <20190510004715.29298-1-liboxuan@connect.hku.hk>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <c1bef9da-e588-233f-b2c9-ed2b9932d4e6@iee.org>
Date:   Sat, 11 May 2019 00:09:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510004715.29298-1-liboxuan@connect.hku.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfLD+8bSh3lMl28EwSfK4PPL/cnz/u28YDJe1xuD0ip/qbAwBdPOVVNjODVdlycX8tcfcbK/uIui9VZ6wrTIfoS27zcuxpMO/R7SUTD3e4upqiNbrk2uD
 n8M0nNARTSgXiLhzMviB1oGfhdv+LmaSuWY+1/V+l7vIF3nUK6pYl65T0Es9EKq3EVkg4zXHNM5wLAkLKrL9Tb7FPzuwT/OjgXY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/05/2019 01:47, Boxuan Li wrote:
> `matlab` pattern is also suitable for source code
> in the GNU Octave language.
>
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
>   Documentation/gitattributes.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 4fb20cd0e9..1b28381bda 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -819,7 +819,7 @@ patterns are available:
>   
>   - `java` suitable for source code in the Java language.
>   
> -- `matlab` suitable for source code in the MATLAB language.
> +- `matlab` suitable for source code in the MATLAB/Octave language.
>   
>   - `objc` suitable for source code in the Objective-C language.
>   
Looks good to me.
Will help Octave users searching on their name for the Open Source 
variant of Matlab.
--
Philip
