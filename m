Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E172021E
	for <e@80x24.org>; Sun,  6 Nov 2016 14:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbcKFOZ2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 09:25:28 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36828 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbcKFOZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 09:25:27 -0500
Received: by mail-wm0-f65.google.com with SMTP id c17so11975530wmc.3
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jiBSRC7mDYybdKFuS6O9duKvIKq9zFrc+K3pndTlpZg=;
        b=pW/3b6ZP9vEZcKfY7E/sF/eJzA8SbZu5kfY3r3UEwe0gqXzRoRaBbskh7Dvol4pOsm
         gw+9cWXLuGcJXgl6yVU4pvgP+V4FYucfWaFax/fvJswtMu0uydR2ufi9tpEb2iBO36t9
         e4uw2G2os4I3ei68nWZXX9Lg/DnxjgqNZFVpfnh/9K75Q+GLhCU7tKHs21logOK2tNFq
         LULmof/heqQjUeEvDAPDCsIHSLcgV3CGUayFfOUGKBvZJE+6eFKVU+6CakFkucIEfIwy
         HBxVOfdMyC4qTUARC+s66HTFycoV43to17wdo9529OdybxtDfDgdGGUJb42mzaxLjjwg
         xI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jiBSRC7mDYybdKFuS6O9duKvIKq9zFrc+K3pndTlpZg=;
        b=mdWzcj0oD7CbhBk63hCoewfjEIR+d7iOSKKFZMshsF/6KgCiEVGAJXIofPTYa9/1mw
         mKznh/Hshb8Tlp3tcqOCIvzVlK/SOJA1UontD50SHT6WegdLHr/PaoZdHgmpPE86yMzZ
         mup2gVoJs9pTC3Bl+r4DcZdKym43dNGpZwYfpX33uzuaWPd77yq4Tmk7fsaZLUSad1UV
         7N0F7Xp3KFi7Zgp9cFzE0f0BM3Z/bY1aCUZ4y8Cne1tMgd2rlirq6Sm99w5sfLwCoWiX
         rSy8GSEyhMmDRM7OT5qhac8DFZxbF18PDWUBuW16++XivSJsfpnUOXzR0DdS0kjhWiJ9
         mWGA==
X-Gm-Message-State: ABUngvdwASZvx+EnZy0Tywp0rsm9pjkzA5bpMCfaTlseiLuQz4lyY1QGEqxiw8j9lE19gg==
X-Received: by 10.28.194.135 with SMTP id s129mr3112955wmf.55.1478442325908;
        Sun, 06 Nov 2016 06:25:25 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id a1sm25436215wjl.28.2016.11.06.06.25.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 06:25:25 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/4] t0021: use write_script to create rot13 shell script
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161102181751.trxsns5pxqk73ukc@sigill.intra.peff.net>
Date:   Sun, 6 Nov 2016 15:25:33 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <22DAA280-1857-4E22-914A-1208D784DA98@gmail.com>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net> <20161102181751.trxsns5pxqk73ukc@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Nov 2016, at 19:17, Jeff King <peff@peff.net> wrote:
> 
> This avoids us fooling around with $SHELL_PATH and the
> executable bit ourselves.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> t/t0021-conversion.sh | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index a20b9f58e..dfde22549 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -6,13 +6,11 @@ test_description='blob conversion via gitattributes'
> 
> TEST_ROOT="$(pwd)"
> 
> -cat <<EOF >"$TEST_ROOT/rot13.sh"
> -#!$SHELL_PATH
> +write_script <<\EOF "$TEST_ROOT/rot13.sh"
> tr \
>   'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
>   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
> EOF
> -chmod +x "$TEST_ROOT/rot13.sh"
> 
> generate_random_characters () {
> 	LEN=$1
> -- 
> 2.11.0.rc0.258.gf434c15
> 

This looks good to me (and it works on my machine).
However, I took a look at the "write_script" function and found this,
added by Junio in 840c519d:

echo "#!${2-"$SHELL_PATH"}" &&

There is some kind of variable expansion happening with the "2-" but
I can't quite figure out what is going on. Plus, I can't find anything 
about this in the sh docs.

Can anyone help me to understand it?

Thanks,
Lars
 
