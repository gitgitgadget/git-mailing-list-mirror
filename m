Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D90EE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 22:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjHUWFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHUWFo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 18:05:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A27126
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 15:05:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 116FC18730;
        Mon, 21 Aug 2023 18:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ui9NA1I9AbrtdYUwZBGol/o4S4fpWiVM30k0kN
        5KVrM=; b=Of2OJ+zzgEL3PWnHmedTmxTmvRlqcq2/zX96Bhj32p9AdwEMk8HCsT
        7pImdcPMaUALL+TNfuGWsU1cQAaTYKpJmM3/1u94nwQpOY/RpbC169YlQVuzzRZn
        hpqZMPli01kAjUufPjgCTAGdIg3BRuecz+1lPcis8m3j7oPngbTJw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09CEF1872F;
        Mon, 21 Aug 2023 18:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE9461872A;
        Mon, 21 Aug 2023 18:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] format-patch: add --description-file option
References: <xmqq1qg9qmyq.fsf@gitster.g>
        <20230821170720.577820-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 21 Aug 2023 15:05:35 -0700
In-Reply-To: <20230821170720.577820-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 21 Aug 2023 19:07:20 +0200")
Message-ID: <xmqq4jksoxu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB716392-406E-11EE-8094-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> +test_expect_success 'cover letter with --description-file' '
> +	test_when_finished "rm -f description.txt" &&
> +	cat >description.txt <<\-EOF &&

"<<\-EOF"  ->  "<<-\EOF"

No need to resend as I've fixed it up locally already.

"make test" would have caught this, by the way.

Thanks.
