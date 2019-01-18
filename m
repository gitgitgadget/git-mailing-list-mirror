Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB401F454
	for <e@80x24.org>; Fri, 18 Jan 2019 22:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfARW3y (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:29:54 -0500
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:30574
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729932AbfARW3x (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Jan 2019 17:29:53 -0500
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2EBF83E46A5;
        Fri, 18 Jan 2019 22:29:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a52.g.dreamhost.com (unknown [100.96.35.77])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DADFB3E47D5;
        Fri, 18 Jan 2019 22:29:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a52.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.16.2);
        Fri, 18 Jan 2019 22:29:52 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Occur-Gusty: 01a02edb687f58a2_1547850592013_708346504
X-MC-Loop-Signature: 1547850592013:1983144554
X-MC-Ingress-Time: 1547850592013
Received: from pdx1-sub0-mail-a52.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a52.g.dreamhost.com (Postfix) with ESMTP id 8CD447FA54;
        Fri, 18 Jan 2019 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=BVkpe
        oTXbQJfncdC06iRXQdWAW4=; b=T7Kjd1U0/PSP8rI5E4n3FSzbCaPRQCt+Kcg2J
        FWT6uMRVjffiUDaE4XjVZjnzgV6Z1zthYyoAsMEBTqB/tbFzppAdgLhkkVhJUBHQ
        iySh1Mcla90J8tyhdlb13M/gbrOcIyCMpxNsObuVORBpG+XxntkASi08M7reBEnQ
        QwaKw0=
Received: from corey.lan (ool-18bcb49e.dyn.optonline.net [24.188.180.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a52.g.dreamhost.com (Postfix) with ESMTPSA id 9C2DF7FA55;
        Fri, 18 Jan 2019 14:29:49 -0800 (PST)
Message-ID: <b4f859d8c414bbf0693cf26a418cc6c4769456ef.camel@novalis.org>
Subject: Re: [PATCH] t1512: test ambiguous cat-file --batch and
 --batch-output
X-DH-BACKEND: pdx1-sub0-mail-a52
From:   David Turner <novalis@novalis.org>
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 18 Jan 2019 17:29:48 -0500
In-Reply-To: <20190118222629.3nvcos24gmi6xe4i@dcvr>
References: <20190118033845.s2vlrb3wd3m2jfzu@dcvr>
         <a7307f431e2231dd420a0190a22aa38094cd593f.camel@novalis.org>
         <20190118104519.fqpzirux5qulkcwa@dcvr>
         <672a6fb9e480becbfcb5df23ae37193784811b6b.camel@novalis.org>
         <20190118222629.3nvcos24gmi6xe4i@dcvr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrhedtgdduieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeffrghvihguucfvuhhrnhgvrhcuoehnohhvrghlihhssehnohhvrghlihhsrdhorhhgqeenucfkphepvdegrddukeekrddukedtrdduheeknecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopegtohhrvgihrdhlrghnpdhinhgvthepvdegrddukeekrddukedtrdduheekpdhrvghtuhhrnhdqphgrthhhpeffrghvihguucfvuhhrnhgvrhcuoehnohhvrghlihhssehnohhvrghlihhsrdhorhhgqedpmhgrihhlfhhrohhmpehnohhvrghlihhssehnohhvrghlihhsrdhorhhgpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for adding the test. 

On Fri, 2019-01-18 at 22:26 +0000, Eric Wong wrote:
> David Turner <novalis@novalis.org> wrote:
> > Let's try this version.
> 
> Thanks!
> 
> Tested-by: Eric Wong <e@80x24.org>
> 
> Not sure if t1512 would be the best place to put the test, but
> having a repo with ambiguous data already at hand was easiest.
> 
> ---------8<-------
> Subject: [PATCH] t1512: test ambiguous cat-file --batch and --batch-
> output
> 
> Test the new "ambiguous" result from cat-file --batch and
> --batch-check.  This is in t1512 instead of t1006 since
> we need a repo with ambiguous object_id names.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  t/t1512-rev-parse-disambiguation.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-
> disambiguation.sh
> index e4d5b56014..b0819630c9 100755
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -388,4 +388,14 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguous
> commits are printed by type first
>  	done
>  '
>  
> +test_expect_success 'cat-file --batch and --batch-check show
> ambiguous' '
> +	echo "0000 ambiguous" >expect &&
> +	echo 0000 | git cat-file --batch-check >actual 2>err &&
> +	test_cmp expect actual &&
> +	grep hint: err &&
> +	echo 0000 | git cat-file --batch >actual 2>err &&
> +	test_cmp expect actual &&
> +	grep hint: err
> +'
> +
>  test_done

