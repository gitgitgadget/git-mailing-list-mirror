Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F501F859
	for <e@80x24.org>; Fri, 12 Aug 2016 13:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbcHLNLZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 09:11:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36151 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbcHLNLY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 09:11:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id y134so1543293pfg.3
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 06:11:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=g4ja/H4kP4q0DZ02sWFrlnOM8pJluGIsvgkdXw4hTcI=;
        b=ZVSTNwQihbLD5idbg/FB+4B8EG5LVsSh8sRljmgtFBxM4IW7+4XbVhblfjKUP0wH+M
         j/wv080E6F+dezb14zC69xAXQI+3JwIMMIPfng8aFb8gpXGnQNSqMaVJBr/Rjqpxm8C2
         P4Ig603HYS+hE9K8l6ncjOGHxJMItdPh0WjtoLyZN6qM0IOIb2VFk2lYPneBQmSQjGCT
         esByKg4EtVj9/IjF7VsBaoWF7ozbdz/uSnlFOdxbQi6qdlOJs62srPXyTvSvtP7NRUX+
         GhdzcshpXMiCHkcmnP/cO+STghDmL6VudSSi3ckRTulBdjrygwH/2Lbf9t7vwRJDQQao
         TlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=g4ja/H4kP4q0DZ02sWFrlnOM8pJluGIsvgkdXw4hTcI=;
        b=eSVhRpiQlSb2chVWZqXKV1+pY6Wxy0L3R/6DMespgSoFGd3e2sltUxeiacUug03UiC
         mJC1QJcF5UG2yW1ExqxgZxhSWw3Q0RMQCZHseax030mdPAxdGkymaDqg5QhuyOu//zbs
         jPwnfiI2llZQXefSENI5Ms7WBg03yU8Cfe7H83ohkkBSuzPiVba6zEvMyYVksHxNfw5t
         SbXckj/2mh4iONqkYwLhcAhnTaWoMScOOd2riBa4h9yQm6j99C/8z+Weyei2bg7DAPJG
         iqOS1cqKAA7/dkjvnQlElYnXU5xWeznZekxZnwBgC4KARYVSigtfitr5WR+jhCvXh5hk
         Ll0A==
X-Gm-Message-State: AEkoouvlr0ndyW3i/lxAN8/KSABHu+wB3qvW6S7iZR5f6lgGiyXlLitMQPLelOBLeyty1w==
X-Received: by 10.98.62.65 with SMTP id l62mr27159747pfa.2.1471007483496;
        Fri, 12 Aug 2016 06:11:23 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.174.142])
        by smtp.googlemail.com with ESMTPSA id yt4sm13154900pab.26.2016.08.12.06.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2016 06:11:21 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
References: <nn1euf$h6q$1@ger.gmane.org>
From:	Sitaram Chamarty <sitaramc@gmail.com>
Message-ID: <d2ef9717-beb2-2661-d0b0-4e33f82511ae@gmail.com>
Date:	Fri, 12 Aug 2016 18:41:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <nn1euf$h6q$1@ger.gmane.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 07/24/2016 09:37 AM, Jon Forrest wrote:
> This an announcement of Pro Git Reedited 2nd Edition, which is
> a substantial edit of Chacon and Straub's Pro Git 2nd Edition.
> I spent a lot of time tightening it up and maybe clearing
> up some explanations.
> 
> The pdf is downloadable at:
> https://drive.google.com/open?id=0B-Llso12P94-Ujg5Z1dhWUhhMm8
> 
> The complete self-contained HTML is at:
> https://drive.google.com/file/d/0B-Llso12P94-U3g1aDBRWjk1Sk0
> 
> The sources for this book are at:
> https://github.com/nobozo/progit2
> 
> I welcome comments.

Hi

While I'm kinda happy to see the chapter on gitolite gone (for reasons
of difficulty in keeping it current at that time), I humbly suggest that
a brief mention of gitolite somewhere in the chapter on "git on the
server" would be useful.

At present gitolite is -- AFAIK -- the only "pure server side", "no GUI"
solution for access control, and has some interesting features that more
"GUI" solutions may not.  It is also (again, AFAIK) used by kernel.org,
Fedora, Gentoo, and several other open source projects as well as many
enterprises.

If you're ok with adding that, I'd be happy to supply some text for your
consideration.

regards
sitaram
