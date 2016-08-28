Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5DE1F859
	for <e@80x24.org>; Sun, 28 Aug 2016 13:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755331AbcH1NCN (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 09:02:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35131 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755273AbcH1NCM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 09:02:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so5977285wmg.2
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=N2vW6R5fubkahm6aOOzPXsWhtAvc7eJIoBZJYuQvE08=;
        b=khrsCY7chujHQcU51wXBqQClre/ANTBaTqjWinXYn7f2TdtM3ATpLeiUHzd1VcvYD9
         yBnf9AnY/oBH2FC/G8K8nSJG2rqfy6gCAkrkEQK6wnrfMBq/fkegFFfai9dmMXYx1B9C
         PAzHEyjetVCRj7Ymh3K0g8x44TZrjocTV9nx9t+66/gMyH58MW4JAcJ4fz7gN/0QAcYg
         PI4WJFe7GjbUofCPJFEYN6MODuGT6JvTZk26h78pdbphmmhtCYpTJoAp/4lm5NQklJ54
         3ZrqRfnA/UX4aQcmFkKtzfDRY6Xuv3QhiqREFevf7GsRW2nD3t7liqo5cPyfMHVSexH6
         v9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=N2vW6R5fubkahm6aOOzPXsWhtAvc7eJIoBZJYuQvE08=;
        b=bfgCKs/TXLzINqI947HM5uWMODmNBbN7Vv9wlU8X0zLe9cjWoZ7D67FVl1HnSok2U5
         oyXEXLAmGBrOoCUTUdLqHEW8bB+KP7KwTmr7R5MILVZntofZ6efR2v/fe50Ak/lWfAig
         FEPjN2JEBWfLfp/F0EucJSliKHfyhc5DnPrJxlUGw3mX2GGIIm2WIE5ISyZCuDRdlt+D
         rt/egffogttebpNaEGZuo7OC4DxjmmfSY4BFBJzyDWWw4dQlyu5QjrWZU7/lxlvglQJI
         h2XPdde2Bt1+sBEYWtQrC94l6IQau8lUgn1dl29OZEQMh3k+9dtKygmfTdYV1c5Cy9wV
         a6LQ==
X-Gm-Message-State: AE9vXwOxuRnDrAMSA3QD7XvMp4VhfL6K5x2l0qE9QVB0TlABiHCXOGREDNVBeOwfjuO8tA==
X-Received: by 10.28.227.11 with SMTP id a11mr6115249wmh.29.1472389315726;
        Sun, 28 Aug 2016 06:01:55 -0700 (PDT)
Received: from [192.168.1.26] (enk96.neoplus.adsl.tpnet.pl. [83.20.0.96])
        by smtp.googlemail.com with ESMTPSA id jd4sm29373652wjb.6.2016.08.28.06.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 06:01:54 -0700 (PDT)
Subject: Re: [PATCH v5 09/12] doc: revisions - define `reachable`
To:     Philip Oakley <philipoakley@iee.org>,
        GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
 <20160812070749.2920-10-philipoakley@iee.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <494c1bd2-19c8-e2af-da1c-ff1331f91c4f@gmail.com>
Date:   Sun, 28 Aug 2016 15:01:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812070749.2920-10-philipoakley@iee.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 12.08.2016 o 09:07, Philip Oakley pisze:
[...]

>  History traversing commands such as `git log` operate on a set
> -of commits, not just a single commit.  To these commands,
> -specifying a single revision with the notation described in the
> -previous section means the set of commits reachable from that
> -commit, following the commit ancestry chain.
> +of commits, not just a single commit.
> +
> +For these commands,
> +specifying a single revision, using the notation described in the
> +previous section, means the set of commits `reachable` from the given
> +commit.

Why such strange formatting?  Is it to keep original contents
for better blame / word diff?

> +
> +A commit's reachable set is the commit itself and the commits in
> +its ancestry chain.
> +

It is all right, but perhaps it would be better to just repeat:

  +Set of commits reachable from given commit is the commit itself
  +and all the commits in its ancestry chain.

-- 
Jakub Narębski

