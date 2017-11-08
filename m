Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1733E1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 02:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbdKHCHf (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 21:07:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60400 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752361AbdKHCHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 21:07:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9FF2B86E6;
        Tue,  7 Nov 2017 21:07:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GGSGF1kLIZce
        a5tdRJUaj4Qqbz0=; b=jN8J+aInMXnzx0uuhWRuQSh1NJTCjcz6JZYwzJoj2Dij
        stD/ngLW11gxfa5Yxowu4BUY2/m+C3SWSgxhJSQ6r6h2TwlILdvA0zT1KxH3U7lr
        UlvCA6V77CyrbGkxg73kNV/86NQuKkDuw0QV3DCbk7B0BKSyL3SbAwhXa18XYSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lranYR
        vXosYUJDfNbTN2iuI3YEp4yTJRyS1DC4W3p9HtbrvzQh+PH2DPYBzgWh8jh3jGSl
        W4/vYT9mcjBR5KPEOW4cvXm1jIvTKXe676UbcnGDEJJ5OcescbTuFyDwe6VV+ddc
        2bcsq+EgAx4KaPab3WMpT7ltozO6/vRUqcQUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A29F2B86E5;
        Tue,  7 Nov 2017 21:07:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28F9AB86E4;
        Tue,  7 Nov 2017 21:07:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 0/7] namespace support
References: <20171102212518.1601-1-anarcat@debian.org>
        <20171107160701.24202-1-anarcat@debian.org>
Date:   Wed, 08 Nov 2017 11:07:32 +0900
In-Reply-To: <20171107160701.24202-1-anarcat@debian.org> ("Antoine
 =?utf-8?Q?Beaupr=C3=A9=22's?=
        message of "Tue, 7 Nov 2017 11:06:54 -0500")
Message-ID: <xmqqbmkdmskb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 951284DE-C429-11E7-81A9-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupr=C3=A9 <anarcat@debian.org> writes:

> Yet another reroll to fix a typo.

Thanks.  Will replace.  Let's wait for a few more days and then
merge it to 'next' and down to 'master'.

