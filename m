Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,TVD_SPACE_RATIO shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1F51FC96
	for <e@80x24.org>; Wed,  7 Dec 2016 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbcLGBAj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 20:00:39 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34429 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbcLGBAi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 20:00:38 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so21450060pgc.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 17:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=sTSWB6SoeVPo4R2JcVdqQ0INoUm/QO1PvHmF2E0WBn1A9FWz6O7VLkFY8olvWblgFg
         L4cMRff4pbgIYmNIKZlV1T8YPT3bqh5VsH0vxO0/WtiZIB+d2ybak12IknUopugTOZCq
         qSLqTSKwaZguAlBNrZxOPqXijs4BoQtckoH00FFSZfvwhsLdeIp+yY2ep8gTiBywYYdk
         W9Rt9Dou44zLdpph1XmyUMdk4tefnVpHQju8YwJG2oN46Mo0bhzUEcGCumcHvj5teVb3
         ZH5dLxb/rWrnJjnJf4pRt2GGbiISmfMMHT1DNVq93Pq0MGRqYLObioUoPdgjny1nmqwT
         6crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjunn4+x2QEs4HRrQcozT7INn2DM0lGSHIZkmkDz3T0=;
        b=V0NG5FT/iglf/D2ewoRhmnMBmOWQfBr9TCpxf8UV2xdJxn99xFAE2qKwGzZCt1JZi9
         AQLH3KZMgkO7irv2vfR+DjNa+dlY0J3XFRjH4QsDFZl/hXI9EUE+Rg42V2+BvrrCoRjc
         JiXFHTKkMjMZqOtg8n12xepCAx5mRFAlJdshEESjDS8yeYIpzBbDXrqtc9+oSoxl5ZWM
         1kLnVcKfRWdddCqrm6BtKS98I4UxiitGSecNrUlTvU9xcUi5UVVJqbj6qWyS8+Sp4bp6
         aKTp3DVrDX7/wLZPufkhQ0LvSsBL3c6EBqNTgsvGo5dY/PT3P3maHX2Kq743XaXfbDnP
         JHuQ==
X-Gm-Message-State: AKaTC02rnVThJYmK3L3x7AY0o+YMv40UggXD2x0SAfbs3N4KNfh6Cxz4+9iXtjdhM8orlA==
X-Received: by 10.84.210.167 with SMTP id a36mr143312016pli.125.1481072437580;
        Tue, 06 Dec 2016 17:00:37 -0800 (PST)
Received: from 69-172-153-136.cable.teksavvy.com ([69.172.153.136])
        by smtp.googlemail.com with ESMTPSA id 65sm37506553pfl.21.2016.12.06.17.00.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Dec 2016 17:00:37 -0800 (PST)
Message-ID: <1481072436.5381.0.camel@gmail.com>
Subject: 
From:   jbh <jbhx77@gmail.com>
To:     git@vger.kernel.org
Date:   Tue, 06 Dec 2016 17:00:36 -0800
In-Reply-To: <c35518dc-5278-bd89-569c-398e70aa8dc8@drbeat.li>
References: <835c0328-e812-1cb7-c49e-714ff0e9ffb3@drbeat.li>
         <1480798849-13907-1-git-send-email-dev+git@drbeat.li>
         <20161204075800.GA2415@tb-raspi>
         <xmqqmvga3yod.fsf@gitster.mtv.corp.google.com>
         <c35518dc-5278-bd89-569c-398e70aa8dc8@drbeat.li>
Content-Type: text/plain
X-Mailer: Evolution 3.22.2 (3.22.2-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe
