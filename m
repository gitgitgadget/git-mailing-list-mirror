Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E501F45F
	for <e@80x24.org>; Thu,  9 May 2019 06:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEIGrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 02:47:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56919 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfEIGrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 02:47:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B5EA559B6;
        Thu,  9 May 2019 02:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rt99pHFWducDb/Yfo/VaZ9yZ8gA=; b=AmGuG9
        B1Np1YMgmInr/vS/yE8ifyic3DlhQVc43P5ZDNjc/pPLtytPlYebOzYPgcRnqtkl
        tQ7qJymjdEkxjygRGa5vXfINFNt6lq8JThWUbQvp/LYF23/AbS7R/mErliNeQKjR
        9jiyEnz/k+JVwq6J4EpCZp5JPyllvkxPs5j00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VzHO6Rj0HYq9kAYONKRKGwIhg886BNfX
        M2CGMlmf7mRSPmfh+lCHzKPK+Eg/rD5EZYB2/+NTBJPEOOtJhSFmAvHByabQaxGa
        Rw4nrQXYK5Dc7m2tK9rwwI2Mcjr8i5abRxOvrfyyNXTmW385qxUEL1GtX9zf5QhZ
        wRd7yOk+6/Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 327A6559B5;
        Thu,  9 May 2019 02:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 576AD559B3;
        Thu,  9 May 2019 02:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] send-email: honor transferencoding config option again
References: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
        <20190508105607.178244-3-gitster@pobox.com>
        <CAPig+cRrPsm+8Ja16A0t1ihM0OKZUn=pexhWaKGjUst-EvSOLw@mail.gmail.com>
Date:   Thu, 09 May 2019 15:47:18 +0900
In-Reply-To: <CAPig+cRrPsm+8Ja16A0t1ihM0OKZUn=pexhWaKGjUst-EvSOLw@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 8 May 2019 17:24:39 -0400")
Message-ID: <xmqqzhnwdszt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AF9FC22-7226-11E9-A152-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, May 8, 2019 at 6:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Since e67a228cd8a ("send-email: automatically determine
>> transfer-encoding"), the value of sendmail.transferencoding in the
>> configuration file is ignored, because $target_xfer_encoding is
>
> s/,//

(also all other typofixes are obviously correct)

Thanks.
