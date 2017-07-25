Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A871F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbdGYUtd (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:49:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54601 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752483AbdGYTUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 15:20:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1AC073305;
        Tue, 25 Jul 2017 15:20:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YZ2RWjrszNCR3uf3jYOUwnmZ+50=; b=TFIuvw
        2cAQMkIoyBsfDoFwKne8sk0JpeiU4x/BpAujx8BUK5Q1S+H57RL+IhbpKRG8o3T6
        qiB22ws27ieWPRIcvcvrej6CtzNNslbClPtCyr75V45B1loOebo94NEKJ/pJwrR2
        jaKS0rvrBko/UyI0sAy+ZQOKopvENWLNRRdo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QaM/mIKdbvof3ZZ+zctb2ppo8GqQwkB7
        /KxhSe6lExD0lsC04T2KidjbyrkZJTtMI9rBRanYGV3Z0D9wbT0s6h6knqLrQaGA
        Nh3IQCyQK4yCrtXEwJTb86fhAmGowX3LYN82NywzZ32v4dQS6xvD5twmqIQdmPv3
        MqErbk+ByJI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C953473304;
        Tue, 25 Jul 2017 15:20:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A8A273303;
        Tue, 25 Jul 2017 15:20:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] git-gui (MinGW): make use of MSys2's msgfmt
References: <8a13544743fd5e6a3b3b5fdb35e02c9c34695e25.1500971399.git.johannes.schindelin@gmx.de>
Date:   Tue, 25 Jul 2017 12:20:44 -0700
In-Reply-To: <8a13544743fd5e6a3b3b5fdb35e02c9c34695e25.1500971399.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 25 Jul 2017 10:35:57 +0200
        (CEST)")
Message-ID: <xmqqvamg9vcj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B708A54-716E-11E7-862C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> 	Pat, I still have a couple of Pull Request open in your repository
> 	at https://github.com/patthoyts/git-gui/pulls/dscho that await any
> 	reaction since October 14th last year. Please let me know when you
> 	are ready to accept code contributions again. In the meantime, I
> 	will send git-gui patches to this here mailing list, Cc:ing you,
> 	and hoping that Junio will take the patches.

I'll try to fetch the latest from Pat, apply this on top and queue
it in my tree in the meantime, but that is a lot more involved than
simply applying a single patch to a new branch and merging it to
'pu', so it will be done later in today's integration cycle after I
handle other topics.

Thanks for working on this.
