Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B0E1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755657AbcHSUMu (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:12:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59650 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755621AbcHSUMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:12:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F46C37CDD;
        Fri, 19 Aug 2016 16:12:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IurJ5HYzFhrsd7P0oDrWJXpl46I=; b=VLjO9J
        y6J5oNIlnrHqJnxk0iz2TJ3qQmxGePjbfepKykivIZWdIKiwB+X1LlsKfLnmEf4a
        75/ko8Aj5Es9pRznqiHQJkbg/TrwOUHvhroAUzdi4LYWdRZpFGYO/nb6L3MCDF2t
        CC0psDgTYcI0JfOpWQ8wRJEyB4lpol3d901nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o490Bj0QKSs4ozFdwZlK6laUryuwCEaq
        ta8eRD1zCduHwXp5KA5odFizGBtowzCcGb0uNcBnTLnCL8+S/kDZkQRHddNl2Zw0
        EkHm2ezTCajbifTyJunkZA9fjYMql6lN/W2jxiNWmvEzhy1E+BrjObZSw7PTPauV
        irQMEyH2kEk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2785D37CDC;
        Fri, 19 Aug 2016 16:12:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A005737CDB;
        Fri, 19 Aug 2016 16:12:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 5/8] submodule: convert show_submodule_summary to use struct object_id *
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-6-jacob.e.keller@intel.com>
Date:   Fri, 19 Aug 2016 13:12:41 -0700
In-Reply-To: <20160819000031.24854-6-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 18 Aug 2016 17:00:28 -0700")
Message-ID: <xmqqoa4o1ps6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49B5D840-6649-11E6-AF2D-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Since we're going to be changing this function in a future patch, lets
> go ahead and convert this to use object_id now.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

Sounds good.  Thanks.


