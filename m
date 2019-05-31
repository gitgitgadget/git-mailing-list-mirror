Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956D81F609
	for <e@80x24.org>; Fri, 31 May 2019 17:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEaRCw (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 13:02:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60881 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaRCw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 13:02:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 844EA66E2A;
        Fri, 31 May 2019 13:02:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qQ0uENc8SYmdzexM2aawwKvYr9U=; b=IsQBys
        BAqPSAKC7PNLexmAWqHs76rgrwC+zYAM/q9cntlxNL6QqtmGIp48jPZOsi0HuTPQ
        vp2DNXSvbSWN3LaH7xzNGqn/uzTfcktXGTDbI7AQFQzKiVfMrESQv5XJJy9bVmCd
        iSBMos0DN2/FEyYIErxd0dbSNTpPlqROxhmT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rCHxRjbPaIlQmkSZ/fT+8aKTCMBtV3Lz
        t2plGn9Nhw3n+TmnPi+dLiK+DJ2fWgHoKMu9amsYKUOP27Zv5fiXn4ab62lttFEg
        0Kh+3SMb9416ijmw/QcBBTsWNzVPLfma+xJmSVLSp/RiUSXnSrpLuFpXojh/ibjH
        RJPz8MQrhXE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C1BB66E28;
        Fri, 31 May 2019 13:02:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 84A4F66E25;
        Fri, 31 May 2019 13:02:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905311337270.44@tvgsbejvaqbjf.bet>
Date:   Fri, 31 May 2019 10:02:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1905311337270.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 31 May 2019 13:39:30 +0200 (CEST)")
Message-ID: <xmqqd0jywo97.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9C93056-83C5-11E9-BD7B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The second round of release candidate has been tagged, after
>> slipping for several days to merge a handful of last-minute
>> regression fixes.
>
> You hinted in an earlier "What's cooking" that you'd maybe go for an -rc3.
> Is that still the case?

That was back when I did not know exactly what shape the tip of
'master' was.  I agree with what you said in your announcement of
the Windows port of the -rc2; it seems that the release candidates
are in reasonably good shape so far, and perhaps we can do without
another round, even though it may be prudent to slip the final for a
few days to give enough space between -rc2 and the final.

Thanks.
