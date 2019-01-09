Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D478C1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 02:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfAICnD (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 21:43:03 -0500
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:39838 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728389AbfAICnD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Jan 2019 21:43:03 -0500
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id h3bbguUSWXaVHh3pfgzf6u; Wed, 09 Jan 2019 02:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1547001783;
        bh=gnKXo1rgpr2Y6npZzFrw1FyrZ61UCTlWA7bUe9EMnZs=;
        h=Received:Received:Date:From:Reply-To:To:Message-ID:Subject:
         MIME-Version:Content-Type;
        b=OCvISWCIpX6P0fv/tzlpf8ALXuR3B7INt8mzPdWXq9mMFAgTf3wpEru/foLOIDkmw
         NBf0Zgh0hMdEQFmRR9QKEq6R1/jSFAUiIGUEc/HTEOz34J/wGw2IL525qz+b3E/rCZ
         Bfodzm/hXZguJIbRBrwjhUE9R7ltiCHBafjMPpyyocEowoxQ+hGHz9mmhaNlSRcLQE
         /rOUTBFo7SC5xRfF2on65+wIv8UIVQ9jHsgHDFcXkgo7FSuLcKpI/BDycd151I3U1J
         Kg1b3qrnI74rNqZ1wEXwC3sHBlHyyqKdGJZWZWK+7J0wT23qRLgAODMSjN+xldC1k9
         v6+r75yjRijlQ==
Received: from oxapp-hoc-65o.email.comcast.net ([96.118.241.229])
        by resomta-po-18v.sys.comcast.net with ESMTPS
        id h3pdgOk69xe7Fh3pdgI5N0; Wed, 09 Jan 2019 02:43:02 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedtledrfedtgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfenuceurghilhhouhhtmecufedttdenucgotffhvedqqdeurggukfhmphhorhhtrghntggvucdlvddtmdenucfjughrpeffhfhrvffkjghfufggtgfgrfgkofhisehtjegstdertdejnecuhfhrohhmpefotefvvffjgfghucffgfggqfftgfcuoehmrghtvhhorhgvsegtohhmtggrshhtrdhnvghtqeenucfkphepleeirdduudekrddvgedurddvvdelpddviedtudemieegjeemgegstddtmeehfedusgemkeehleehmegrjeelugemfhekleehmeejgedvvdenucfrrghrrghmpehhvghlohepohigrghpphdqhhhotgdqieehohdrvghmrghilhdrtghomhgtrghsthdrnhgvthdpihhnvghtpeeliedruddukedrvdeguddrvddvledpmhgrihhlfhhrohhmpehmrghtvhhorhgvsegtohhmtggrshhtrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghtvhhorhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgsvghllhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesjhgvfhhfhhhoshhtvghtlhgvrhdrtghomhdprhgtphhtthhopehjvghffhhhohhsthesmhhitghrohh
X-Xfinity-VMeta: sc=??;st=legit
Date:   Tue, 8 Jan 2019 18:43:01 -0800 (PST)
From:   MATTHEW DEVORE <matvore@comcast.net>
Reply-To: MATTHEW DEVORE <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, pclouds@gmail.com
Message-ID: <1568150001.183199.1547001781704@connect.xfinity.com>
In-Reply-To: <xmqqbm4q4t3j.fsf@gitster-ct.c.googlers.com>
References: <20181210234030.176178-2-matvore@google.com>
 <20190108015631.22727-1-jonathantanmy@google.com>
 <xmqqbm4q4t3j.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v2 1/2] list-objects-filter: teach tree:# how to handle
 >0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev38
X-Originating-IP: 2601:647:4b00:531b:8595:a79d:f895:7422
X-Originating-Client: open-xchange-appsuite
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On January 8, 2019 at 3:39 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
> Also, the asterisk sticks to the variable, not type, i.e.
> 
> 	struct filter_trees_depth_data *d = filter_data;
>

Fixed. Thanks.
