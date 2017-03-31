Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472CB1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 15:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933244AbdCaPqt (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 11:46:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56314 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933211AbdCaPqs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 11:46:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A79E379BEF;
        Fri, 31 Mar 2017 11:46:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v7ExsGudBnFoHXzWzamODOm3nDI=; b=WLzBXM
        G8nHw9aHBgZTBsyGB2nT7FGdNLXg6Ihrgr3FbAQ/aC5gMZVAg596x5z1N6X8Xbax
        IkLDfxoLAfiYMIrbgPulYUtLVDFPIHxwcBiHneKtnGG5K9LxE80Hnqt41Yia0nDw
        EVnnnMOkIBRyRdEPLAo82pKlzMmGeBAWm7EbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n2Atjo27rEjWM9TbVPj+PS6lV4YuwZFC
        bdchV6/EhsTXzXlGQzlCajTdHvoYVmwj+jZPelSg7o8yIb7y81wEsv77Y8pKjqoB
        juMfjpD8lJb3PurLWIhfW3qHfeWGRzAAAxIwVAg7WswoT+u3MLceJ64EZUSdDcPO
        EfR1/8+y6Gw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D96D79BEE;
        Fri, 31 Mar 2017 11:46:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AA3679BED;
        Fri, 31 Mar 2017 11:46:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/20] object_id part 7
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Date:   Fri, 31 Mar 2017 08:46:44 -0700
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 31 Mar 2017 01:39:41 +0000")
Message-ID: <xmqqa8811maj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EC3CF92-1629-11E7-890B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for these patches.  I didn't see anything questionable in
them (except a very minor thing I sent comments on separately).

Will replace.  Thanks.
