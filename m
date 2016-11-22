Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65731FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 03:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754963AbcKVD1O (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 22:27:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53741 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754790AbcKVD1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 22:27:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A04C53097;
        Mon, 21 Nov 2016 22:27:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gg+bN8CUpOsYRaY/TWT2BkUy89w=; b=mB8SLp
        Zo7hyKoQDs2eC+iM7iZu1VXwG55zTGFCWaCBEQhWX5ov7/Fhrlut6B20fMBfLhFV
        wwsmIrkCTlIBKpTqS7mrDI7+JeMnRgswRcJD678QlNqhasDfMPdd6rnZsYT5A48U
        fiyQf6XIbtQ5ddvSMDUuliOSWGYyQAJr5V45o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XsHN+e1VlpPyeaPCxcIQwhm0A+FgkBjH
        RCIIQ+iPOPCrZuqa4RsJrKwG/7LYkNA5wTJQt9KySJoAZEQ/5Qz3SkRiI8lXpvAR
        OTcrYRH1H3fqA291dkbjeXqvF4tTyi0vbirB+SSoIPLX7V/nMewHGG2XIwDKJ9xp
        wZ7FU47X9mU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80CBB53096;
        Mon, 21 Nov 2016 22:27:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2FB453095;
        Mon, 21 Nov 2016 22:27:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jacob.keller@gmail.com
Subject: Re: [PATCHv2 1/3] submodule config: inline config_from_{name, path}
References: <20161121232709.8906-1-sbeller@google.com>
        <20161121232709.8906-2-sbeller@google.com>
Date:   Mon, 21 Nov 2016 19:27:10 -0800
In-Reply-To: <20161121232709.8906-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 21 Nov 2016 15:27:07 -0800")
Message-ID: <xmqqd1hogpo1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E7C3320-B063-11E6-890E-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> There is no other user of config_from_{name, path}, such that there is no
> reason for the existence of these one liner functions. Just inline these
> to increase readability.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Makes sense.
