Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B7E1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934533AbcIUQiR (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:38:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61788 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755445AbcIUQiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:38:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 856743C996;
        Wed, 21 Sep 2016 12:38:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TXZknRfiY7KR
        ao5N5sxvCM/w7I8=; b=B/LiP9+44Cls29cPUWCki+zhgV2C3Tl48NBXFoSq60Mm
        Fl+1dQMsqm7SSP1Sm+BqIkZi2RwBxVSEg5yfBSneDHjiuUt8I/Urb3MdZv+3M38o
        ShuzWCe8Z9tH7AeiLH7uGVYccNUE1e+B5nouA7I95qwjIQDhb6WlJ/6pDlVt4Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hNdqZz
        1/5AMmqfD6Of/Wp7OnsLbguhku1oOf9A+aVIMNFFz/QgHbE8kfEIzG/Z+pTqvrus
        JAh1IBVl9or05w8d1Vai5TLfPxUBenYAEk9Wh28L2qYQJ5dld16cCfieeI/mEvbe
        owlHdZ2/IiHD0wLiwTHB5Yq3KV0mnrV8GLTDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D09D3C995;
        Wed, 21 Sep 2016 12:38:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFA063C994;
        Wed, 21 Sep 2016 12:38:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
Subject: Re: [PATCH] gitweb: use highlight's shebang detection
References: <20160906190037.12442-1-ian@iankelling.org>
        <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
Date:   Wed, 21 Sep 2016 09:38:12 -0700
In-Reply-To: <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 20 Sep 2016 22:22:48
 +0200")
Message-ID: <xmqq4m59b43v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB03F686-8019-11E6-AE41-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 06.09.2016 o 21:00, Ian Kelling pisze:
>
>> The highlight binary can detect language by shebang when we can't tell
>> the syntax type by the name of the file.=20
>
> Was it something always present among highlight[1] binary capabilities,
> or is it something present only in new enough highlight app?  Or only
> in some specific fork / specific binary?  I couldn't find language
> detection in highlight[1] documentation...
> ...
> Thank you for your work on this patch,

Thanks for reviewing.  It seems that there will be further exchange
needed before I can pick it up?
