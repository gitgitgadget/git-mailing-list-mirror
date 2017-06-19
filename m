Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29461FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 19:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdFSSdu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 14:33:50 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32916 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdFSSdq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 14:33:46 -0400
Received: by mail-pf0-f178.google.com with SMTP id 83so57615159pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=qIYO+emcDdQwU/IYKGprQhQfX+Hn27W1/tAZEK1WzY8=;
        b=gCjr3Ih+Ohh7lfhC2X2znxir/HfiqDZ3dy0gAO3OsfWIDcNv7IcVyWQb5ufRQxw0ZA
         33U8UPhZ23MGfzIDgXLyQJ21/W9FLKHF9n1gFRWxxDhMnMxxxnqp983ReiOhxYbU34ZY
         poeWqdwjc8MqmGOIKXrxMjuvJ52V5igtqj/LMZ5pU+FcVWd2/2WXlLPXlQlLULGShqc+
         8OvviXR5Nv7fyPQ+QiwuYdZmKy5o/5lVLyAJj3iYKjzwe7JbjTP4KaCrK84TvZeoNdbX
         uEtlN91mh8G3z+QG4OTtlS2AT6OJkZsPgrRyp5blwohJiqxXMHyjfc5OhOWIX4G6A85N
         TeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=qIYO+emcDdQwU/IYKGprQhQfX+Hn27W1/tAZEK1WzY8=;
        b=O+RvsBurPp+aV/gQj081CjdssWAymQULIq7Tk4Ra1Nf7+EKeoD5Aj8+OItVyjTlACg
         yB2aLXjJDiOyPDhYaoUqK8Tl+Ym3cVjSc+IZ3Z74L0cqNZjWtGGUPy0W/uyJdvmVxyC1
         15VOnKSyRkHHEraJGbxIUtWVpI1OPu5SxqR7Jzrf/692mTY1YZyflVUTXJScZH2arOyu
         A0AqRbhl1FM/nxq7z8EkD4HzCQKCftJP1lGYxRqp6FA572q8dpyoQzmj+L/Ak8FVmb6H
         MLYRhwjICj5o3PwIpuE6rqK3rw0cCk24kuYRt4G4/oBWupTSowQ8zH/Qcv9G24KRNyF6
         Vz2A==
X-Gm-Message-State: AKS2vOzdXWySwHhfzUWXiyO4QldyA143BuZG3zX5lzkxuhZI1EGWi5fh
        /nc9kjYb8+ghUw==
X-Received: by 10.98.10.155 with SMTP id 27mr19079468pfk.4.1497897225366;
        Mon, 19 Jun 2017 11:33:45 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id l22sm22547391pfb.55.2017.06.19.11.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 11:33:44 -0700 (PDT)
Message-ID: <1497897210.18850.11.camel@gmail.com>
Subject: Re: [PATCH 2/2] Add test for the new status message
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, avarab@gmail.com,
        git@vger.kernel.org
Date:   Tue, 20 Jun 2017 00:03:30 +0530
In-Reply-To: <20170619180450.tjldpkltdwqad4ic@sigill.intra.peff.net>
References: <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>
         <20170619024412.5861-1-kaarticsivaraam91196@gmail.com>
         <xmqqh8zcvbq8.fsf@gitster.mtv.corp.google.com>
         <1497895189.18850.9.camel@gmail.com>
         <20170619180450.tjldpkltdwqad4ic@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 2017-06-19 at 14:04 -0400, Jeff King wrote:
> On Mon, Jun 19, 2017 at 11:29:49PM +0530, Kaartic Sivaraam wrote:
> 
> > Is there a way to test for the "Initial commit" message in the
> > commit
> > template?
> 
> You can do "git commit --dry-run", which produces the template on
> stdout.
Thanks for the help :)

> 
> That should be good enough for our purposes here, as it's the same
> code
> that produces the text that goes into the editor template. If you
> really
> wanted to test what the editor sees, you could do something like:
> 
>   GIT_EDITOR='cat >editor-input' git commit
> 
> but I don't think it's worth the trouble.
> 
That's right. I thinks it's not worth the trouble too.

