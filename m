Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63D81FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 22:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933251AbdCGWnL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 17:43:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64643 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933243AbdCGWnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 17:43:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B28CF80883;
        Tue,  7 Mar 2017 17:26:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1uCGLzDd2quHo7n2R5ixydkoYuE=; b=xL9YDr
        qkIp1vmJNg5yJ9WWrzO/xVe64g113ZNqyHAZmzP+Upu6xuLNkDVj/W4w0mjG1Io8
        ChytT1sel/16R3gh44AwtGhBCnZ7a2xrjqO4BEmdddC6XnpgLc67H4gOpYTMH9S8
        KqbEIYpM03Vl5HAzmnKy2BbreqYbftCYzEYqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=auplS31sf+IORAHN73S+mV1ZAcTnqJPe
        PBfo/1+QQ9o/RhPug1qPe7veWUY6bEa7UlhSVAqM9+KFLPH47rvf4Wkh6c4pUSsz
        0XI0XyElB/7qKHxWnlETHNU+voFng2eE64UjeBn78HzLxcftR3J/UCv5PM+ba3fy
        ICCtkhQ7tJQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A926D80882;
        Tue,  7 Mar 2017 17:26:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D28280881;
        Tue,  7 Mar 2017 17:26:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 05/18] lib-submodule-update.sh: define tests for recursing into submodules
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-6-sbeller@google.com>
Date:   Tue, 07 Mar 2017 14:26:36 -0800
In-Reply-To: <20170306205919.9713-6-sbeller@google.com> (Stefan Beller's
        message of "Mon, 6 Mar 2017 12:59:06 -0800")
Message-ID: <xmqq4lz47mg3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20A4F100-0385-11E7-935F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +	# ... and ignored files are ignroed

ignored.
