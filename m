Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF162018B
	for <e@80x24.org>; Wed, 20 Jul 2016 08:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbcGTIUk (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 04:20:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35793 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbcGTIUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 04:20:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so5842920wmg.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 01:20:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d7fThrD95LNNQjZFVP7NoSsvFL4UzZnIpQGy5O8ykTw=;
        b=F3n/FrCZiFL2/Eurp5hQ6odoe8uh//WGlnleBzQ5KpWCUcGjctBIATnCNmJp0mvx3w
         8oSQR+Xvrq5RIiX48GAAXKI22GE3jKPVMQ75ylu7BIjtC4VwEACdzidM8ovOS0fFe84r
         EvG22JClqFRXVjkUceLseOJMIEAyCiTZyC/Lu0o8399A0d1kvS7e6avkQYMZGuUow+sP
         IinCZnf3ieZlYE8EkY2JOKrDysNb5yAXc8E06ar01K3f+zg2ez7TsusxABv8eMWR7sbg
         LALBkzCl2jJztM/940NbpwgViGpWbZvj1YSbNsyTsqWWF5oB2fN7L4R12iT0fmROPzNE
         M2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d7fThrD95LNNQjZFVP7NoSsvFL4UzZnIpQGy5O8ykTw=;
        b=eZD9kd97YQAPRj/vK5ArRfVl1abYgFbMGUW0kaOHqtxMTwmmimm3tBJt7SA+UcDBI9
         SUUAAbCA1fKCw2iNQIEJWUbjAXbAwq/Eub/HSprA2ML69xr/AxJCpT48sJTpmzNASDpX
         9TzE1vVRVO0f3lSDNr4He/CwcqK43a47xK1o4BkeHl36YUWzq5wwp+l47vWS/dRCgS7n
         Qy6Wc3DMxLeboHUW44WmtrV9NAjQsdOHZz08YjmK1ajLEkQsriHzrixNwMgy0DBftYng
         o94hOl9gVIHtxTt/8vMHTKzy7fYdfsVJzImfElBEeYWILncw2260ZIqtRoM67gSkEnd0
         xnPw==
X-Gm-Message-State: ALyK8tIu4AKrpE9NX5WPDt2STIc7f1ZaJ7QoLRZegfq4rmzH4jOAjN98HYhcu15xHG9m+w==
X-Received: by 10.28.74.221 with SMTP id n90mr9672294wmi.16.1469002836149;
        Wed, 20 Jul 2016 01:20:36 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB6597.dip0.t-ipconnect.de. [93.219.101.151])
        by smtp.gmail.com with ESMTPSA id p126sm3802307wmp.13.2016.07.20.01.20.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 01:20:35 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: What's cooking in git.git (Jul 2016, #06; Tue, 19)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqk2ghdysg.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 20 Jul 2016 10:20:33 +0200
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <CBEE46F3-5497-43D6-BA5A-217C7AD55B48@gmail.com>
References: <xmqqk2ghdysg.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 20 Jul 2016, at 00:54, Junio C Hamano <gitster@pobox.com> wrote:

> 
> [New Topics]
> 
> ...
> 
> * jk/push-scrub-url (2016-07-14) 1 commit
>  (merged to 'next' on 2016-07-19 at 6ada3f1)
> + push: anonymize URL in status output
> 
> "git fetch http://user:pass@host/repo..." scrubbed the userinfo
> part, but "git push" didn't.
> 
> Will merge to 'master'.

t5541-http-push-smart.sh "push status output scrubs password" fails on 
next using Travis CI OS X:
https://travis-ci.org/git/git/jobs/145960712
https://api.travis-ci.org/jobs/145960712/log.txt?deansi=true (non JS)

I think the test either fails because of OS X or because of the
used Apache version (Travis CI Linux uses 2.2.22 and OS X uses 2.2.26).
I haven't done any further investigation.

According to my Travis CI Git bisect script the failure starts to appear
with the commit that introduced the test in 882d49c 
"push: anonymize URL in status output":
https://travis-ci.org/larsxschneider/git/jobs/146027836


- Lars

