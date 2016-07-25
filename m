Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FAD7203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 17:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbcGYR2Y (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 13:28:24 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36427 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbcGYR2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 13:28:22 -0400
Received: by mail-wm0-f49.google.com with SMTP id q128so143561483wma.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 10:28:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4mBRm8+Dh1y7U+aT6We3+sGqE+yhKfIfuG1x5QWbf+k=;
        b=yJLYNFlKPo5klmFsk232MpOixG9Vx02pzpVA+gCsT26jBGP9KcFqu9Yb2YXdGGQ7nm
         M23MHrNQz+irB3j5kyeZYPJLC90+FHBh4e4N3ga9gVwdJdvZxDkn+FD4x1PUu5QbZRX1
         WpZVoIgLLC1QrXxNftojl9EsqOFGevTVG2Jpy3PO/d1ARGsmKZsxyml+olMKlI9Z/YP0
         NlGrYeGS9UMSk4mV7Pw9v1GYcwRhkgp2PmVOplQJXef+LwVx6k1yGsmICQdA+zcQP8In
         dZyAeZODsnDVvX6KqQovg/pDnQ/Dxq4abiPKSE+PIzKgsbIrOR/2CcCKdNY5akmnuIRi
         818g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=4mBRm8+Dh1y7U+aT6We3+sGqE+yhKfIfuG1x5QWbf+k=;
        b=aaBIYpf/9WZRxYcwRXKZHAVGAptfZb0YTGZovi5INQkqUjPz90wpeQc8lkxxs0on14
         1sWtgmklsHkfQiZy+pBg9nMbzRl1YGeBr2DZkBkDPSTM24wVEOxUMkwKAPZ6UP182+8k
         tu6h2z075tgyzu5djf/+rdH4eE0ovAxzZrqoL3AXnjkB5FEZMa/54/OVrBwvdA9ejuE6
         Z4gVN9dJyn27dykbg2JY2US9TAyAgDIOq5lLChmQDSSmTT4LDZpJH1zrtwt5+UJOJxRI
         cuJghVv9ysSP2w5qggLTMjp1UFU21UQALv54CeRjEBrj91NZ9vJ5N/8Xi0LplLgGKnw1
         bf5g==
X-Gm-Message-State: AEkoouviO6diVJHUu+7Yh48kvldizLfdc467kvmh29OSq9zLIhfbTaqZLOtbYZT8urpDuw==
X-Received: by 10.194.238.170 with SMTP id vl10mr16737271wjc.18.1469467701453;
        Mon, 25 Jul 2016 10:28:21 -0700 (PDT)
Received: from [192.168.1.26] (dax80.neoplus.adsl.tpnet.pl. [83.23.23.80])
        by smtp.googlemail.com with ESMTPSA id p83sm28451710wma.18.2016.07.25.10.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2016 10:28:20 -0700 (PDT)
Subject: Re: Bug: "git log --format='format:%+s%+b'" doesn't insert newline
 before body
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilya Tumaykin <itumaykin@gmail.com>
References: <8915446.47C9zkNvuX@photon>
 <alpine.DEB.2.20.1607250926320.14111@virtualbox>
Cc:	git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57964C29.9000902@gmail.com>
Date:	Mon, 25 Jul 2016 19:28:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607250926320.14111@virtualbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 09:33, Johannes Schindelin pisze:

> Therefore "%s%n%+b" *might* do what you intended (I would not
> know, because that information was missing from the report).

Shouldn't it be "%s%n%n%-b" or "%s%n%-b"?

-- 
Jakub Narębski
