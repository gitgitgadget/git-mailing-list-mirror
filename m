Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5BBB1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 18:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbcLOSn4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 13:43:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64316 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754432AbcLOSn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 13:43:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCF8158467;
        Thu, 15 Dec 2016 13:43:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=weDCP2pLFpUwA5ztxgj19vjRFXg=; b=YeDLtk
        ugIqtXnuHlEJ3mSulKK9UeC67nNFo9xLov2V5jqQcAtk/iQXahCx7KijPjCpqeVc
        A15ByliyFBUORSFv+OQWBE+wI+SVOQJA+cAJp3moLn86BhERDQuc9eJ4N2QzCv3g
        597Ya6xfK0Mx7Hfvr7NW+60OyOCS9Y0QnJ3xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e6/+8k3L1rXhHzBdn+rB237HTzxj/YxD
        SO3DYTRkkPSBNdfogVrExd3reCNPKSLb/BNWBmFX0WGMFH/nU4IsPxmJ6Uqs25+J
        O+onHmmr+waE9L3dB7Imi5OQppAKwZjKdZWq+ICLFM6rSfD9y08OVkf8hhbguqY7
        SGofJsFwD74=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C74B558466;
        Thu, 15 Dec 2016 13:43:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34DD258465;
        Thu, 15 Dec 2016 13:43:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 08/34] sequencer (rebase -i): implement the short commands
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <42d43763075f3f2daa2cc06a8afc9bcfd8b20ac2.1481642927.git.johannes.schindelin@gmx.de>
Date:   Thu, 15 Dec 2016 10:43:53 -0800
In-Reply-To: <42d43763075f3f2daa2cc06a8afc9bcfd8b20ac2.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:30:06 +0100
        (CET)")
Message-ID: <xmqqh965uj6e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DDD5C48-C2F6-11E6-A739-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> For users' convenience, most rebase commands can be abbreviated, e.g.
> 'p' instead of 'pick' and 'x' instead of 'exec'. Let's teach the
> sequencer to handle those abbreviated commands just fine.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Sensible.
