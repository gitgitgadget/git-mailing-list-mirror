Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD071F453
	for <e@80x24.org>; Fri, 26 Apr 2019 23:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfDZXIX (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 19:08:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62724 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfDZXIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 19:08:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0DB515702C;
        Fri, 26 Apr 2019 19:08:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VA/Ic3xk6gxOs7Puk36ucCCNRAE=; b=XWQ2OS
        bXZAQjBKgCQPJl1/Qit+lxcjCbVj9oCKU+4BlhKQ5wMS6Z3xgj5A2PU9dR1ohsKO
        RdOGaGkCg+dOR/NXl7ARysdJMUaHH5NN4WhyDR1Fuu5Q6pZisAqjTjb9ryw434LR
        UDKf33gRvMPT2qNesG7GQ2D2/pvos04lBZLkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T45pen1N3lbmLOCTDna00NgkMHupoqWc
        yiwbUzratz1kc8xc2cBPCaAE0Xg4SCWpPvGSYUhS6dhBzNlrwn1/0mzABnuP3U5a
        7Xn1oYXEOe9xtJUGtO1PMY8kFl6VE1W0YmPovxeX8GIXgVdqRDAwfmFFARc1WgyL
        oYNLj+75OUg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A640215702B;
        Fri, 26 Apr 2019 19:08:20 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10C2515702A;
        Fri, 26 Apr 2019 19:08:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, lwn@lwn.net,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Fabio Aiuto <polinice83@libero.it>,
        Santiago Torres <santiago@nyu.edu>,
        asymptosis <asymptosis@posteo.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 50
References: <CAP8UFD2P6ojUdVh91Q8C=Bmbc=FMEwzYg7jMYZHv_2NBSTNLeQ@mail.gmail.com>
Date:   Sat, 27 Apr 2019 08:08:19 +0900
In-Reply-To: <CAP8UFD2P6ojUdVh91Q8C=Bmbc=FMEwzYg7jMYZHv_2NBSTNLeQ@mail.gmail.com>
        (Christian Couder's message of "Fri, 26 Apr 2019 22:53:19 +0200")
Message-ID: <xmqqh8aktlek.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EBAD52A-6878-11E9-85C4-DF19F34BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Hi everyone,
>
> The 50th edition of Git Rev News is now published:
>
>   https://git.github.io/rev_news/2019/04/26/edition-50/
>
> Thanks a lot to Luca Milanesio who contributed again this month!
>
> Enjoy,
> Christian, Jakub, Markus and Gabriel.

Rev News team, congratulations, for a 50th milestone.
