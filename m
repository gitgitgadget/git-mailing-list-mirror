Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DBCA207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 23:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbcILXOS (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 19:14:18 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37117 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbcILXOR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 19:14:17 -0400
Received: by mail-wm0-f45.google.com with SMTP id c131so83207907wmh.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y48+/Jxb5hpey/xeo21jVWwPqpdyZ8NgDIdukug0nHQ=;
        b=EkC64Kva2T1Dmh9P698PE2SU0qL2w6JsLzv+JRRi6LSYCDahgPa3RzR80uhA5gpJms
         VHHFSy897JEOjXmSLAFcMucWPyng5jMADWJ2Q85CwN+k86fuJb/MBu9xYo1XWdRBDJ/o
         COZIYuKTPLQ4RcH8yauvTOK8JHRpXWyxIr+hNasz4Bl73w05aUJwttTpaJqHPVbZ8CZB
         jh9bZQUGV/zLA0dZs+HJd+ixDMt903hg9ZLOFbToeEABBbQzd9FrNN4ZNcgOrbpOSfny
         nloC5JlmCor56egoaKuQYyIqwWXovsLh/TKT1WUvdzoob0WirRazYA8y4pwkZBdaoSu7
         9yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y48+/Jxb5hpey/xeo21jVWwPqpdyZ8NgDIdukug0nHQ=;
        b=O8POiA+LaIchyyvzXMmyqu1AOnEWecctnyeCSDCfpJWaTX21R91XiWi4eYqTbhqo1i
         zWjYYeaOj3dj6FhYlw49GfZthuPv2zWPRRuktk/RxpJU6zvlkuQ42jW47F4XfDMnL2sL
         YXA+RS9kIclgrVWPO7n8jql/5QV8rKNtdZBHJevOjX+rwzJzS13EGfJ8Y2jPrayb7tHo
         FLcRabMabbHyT8D2gMAAtYzBeWVwh8bXnsi5NSPhD0meXMAMS3Bcpn37Q3BrGEBxx/J7
         aKpNFCJfouVqIv3qemAhtaIrH8Du+azWTKb5N6dDjmuJ5UmW2GmymK9b/vlBQNaXJu1H
         ROvQ==
X-Gm-Message-State: AE9vXwPRTgPxfq0IY7I8SeqY00eFgn24N4eqYwyKEx/Gs+EuWCJGD4VZx/R7F0IyA6qdww==
X-Received: by 10.28.210.5 with SMTP id j5mr12348845wmg.67.1473722055959;
        Mon, 12 Sep 2016 16:14:15 -0700 (PDT)
Received: from [10.32.248.227] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id qf2sm19979700wjc.19.2016.09.12.16.14.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 16:14:15 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Git Miniconference at Plumbers
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqeg4o27zw.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Sep 2016 00:14:12 +0100
Cc:     Jon Loeliger <jdl@jdl.com>,
        David Bainbridge <david.bainbridge@ericsson.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1019E7FD-0AC0-4BCE-B810-BE20968DFEE9@gmail.com>
References: <E1bhKNo-0005m2-5z@mylo.jdl.com> <20160912004233.qh6uf35v5ylrboz6@sigill.intra.peff.net> <E1bjRLd-0005k0-Vb@mylo.jdl.com> <DB5PR07MB1448B5EDFE2E2D84C42A8AFCE2FF0@DB5PR07MB1448.eurprd07.prod.outlook.com> <E1bjVfp-0006sG-89@mylo.jdl.com> <xmqqeg4o27zw.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Sep 2016, at 21:11, Junio C Hamano <gitster@pobox.com> wrote:
> 
> [..]
> properly; supporting "huge objects" better in the object layer,
> without having to resort to ugly hacks like GitLFS that will never
> be part of the core Git. [...]

I agree with you that GitLFS is an ugly hack.

Some applications have test data, image assets, and other data sets that
need to be versioned along with the source code.

How would you deal with these kind of "huge objects" _today_?

Thanks,
Lars
