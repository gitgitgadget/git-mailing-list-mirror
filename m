Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08DF92184C
	for <e@80x24.org>; Thu, 31 May 2018 12:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754758AbeEaMEt (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 08:04:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:46949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754734AbeEaMEs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 08:04:48 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEFqW-1fZLkM0pQW-00FQQB; Thu, 31
 May 2018 14:04:46 +0200
Date:   Thu, 31 May 2018 14:04:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] sequencer.c: free author variable when merging
 fails
In-Reply-To: <20180530170302.191176-2-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1805311402210.82@tvgsbejvaqbjf.bet>
References: <20180530170302.191176-1-sbeller@google.com> <20180530170302.191176-2-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mboFO/vpjBhp4Ft5OgSFJF6TYe6WyNkVON6bo1Uouz1GFqs3bgW
 C/pCFKFGVTIexMbi/hEjG0kjmOAboCowdQatF/MUTUtQp9nKhBPT+VaIdiVIQQsTJqJ+tpd
 PPeBuAYnmHEz05AExeJDm9xu2H9B84bX4ksTZHuaOTh/wYGruo9VJsHiyIfiqoCCqUNHsBn
 xU5Fwd+TkIROg6Ame3Jjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xvckw5E7ndM=:X9joDFl4ji6omQcX5aCnWf
 qrdzPMX5G5+sGqZpJEBQPhpbFyfwGReiyO1AkStzMSkb7vm+xrpzb5AjVBhgjgWdtmqv/egse
 EaS+JxK7jRqc992BPJGj0ClDg4cfh2+1qF9RUZO/FS8BcV2PrMGWKh8c5PjuH0TYZ6/xcX51+
 YAYDJrbSH9McYQbDirFRyAu8NsL4FAviPmqeIbG91YZTxaAS3yJcH/GH0n3g/ernAg26x68Vt
 K4cogWZrL9XUAw0JXUS0PDyqdz6Tm3L/GmdDNJzBzUDNN4VkeY0uM5NpFVlDDeHTPfvQ/GyFy
 KTzL/gp5GIIf5rOyhGBriNcrvULfeyq0TagvRjc7q9v/dOcsUnr3aXf53PYtvbGEEbSH2Tabm
 mNMi2rDlDK59Ypd2ev7HmKutDSL/Iv632LFyZbpXh0eR6NggbREq2focTWz8UmJ52FEr5mi5e
 u3YDdkIPrJ+99DafYa/DdljFRR0pdCzj2mXv02afqd9Hh5Km3GV2lyQ2yMjcLfiNaN3MUboXs
 WxYzMLNNd6bhkF6syxjp8GA+EVIKBQMv2brEDMivuAmgOQfX2k5427mJOOwrH1mU8l7dRPFID
 VTxUAIUjl0y+o/CyXKOAoBRcAmRlk7Ig/4vjO956do7ZnP5qu4L+dKcKl6PnxlvlikwDdIrhs
 S/pThEfIpLd/Mhc45DLIeuQ3BNdP6XD51rHrzp9W4zpsHEd61O9fYyuomL9Mu/uu7CmsPsshD
 m65QtG2GfWcYDXCehlGzggcE3cRpUrKa9Nn8aDg5SEa9qY3L9K9oVfhZvJIfp7290mRUVrgiV
 YSJAv40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 30 May 2018, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> This was a deliberate oversight in f241ff0d0a9 (prepare the builtins for a
> libified merge_recursive(), 2016-07-26)

No, it was not deliberate. It was inadvertent, most likely ;-)

>  sequencer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 72b4d8ecae3..5c93586cc1c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1771,8 +1771,10 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
>  		res = do_recursive_merge(base, next, base_label, next_label,
>  					 &head, &msgbuf, opts);
> -		if (res < 0)
> +		if (res < 0) {
> +			free(author);
>  			return res;

Why not `goto leave;` instead? I wonder what is happening to the commit
message: can we be certain at this point that it was not set yet? And
also: should we call `update_abort_safety_file()`?

Ciao,
Dscho

> +		}
>  		res |= write_message(msgbuf.buf, msgbuf.len,
>  				     git_path_merge_msg(), 0);
>  	} else {
> -- 
> 2.17.1.1185.g55be947832-goog
> 
> 
