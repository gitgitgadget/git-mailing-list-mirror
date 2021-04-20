Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7DBC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 00:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48CC26135F
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 00:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhDTAaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 20:30:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60435 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhDTAaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 20:30:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 261F6B0DAC;
        Mon, 19 Apr 2021 20:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=o
        YSw/0gCfnLESdFmchGNd2cXOR8=; b=cbNmODa4E/Gl581GctieIFt3088YVHL6l
        mIJO9j8dm8/dAsKm94/i0PCYu3phUaC4WOYQ5pjem6EXDxLdF9L3kpiHigew0iHi
        pYBolWE6+YscJIiUrk8r2vnCGarQJBzhWbo36amqRanTOvE5mqGDCjEybTyIKxhg
        qlLGcUaOX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=xIY+aQeHXxkFjBYYndRP8HrpaolMXf9iHWYidUAaGMBraw/dB9aEqCew
        CnKjeWlI5AEVR0CkcebVuUoSKcXTo/U9dl9lsk94j8/NBU3Oh5GZN33k5qKLA9xV
        Wv9j1XRHQmJjDswoZM9HlLbmYHfywLgrdzFxxlbllZr6IFtpB4s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D2D5B0DAB;
        Mon, 19 Apr 2021 20:29:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 918ABB0DAA;
        Mon, 19 Apr 2021 20:29:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Random GitHub Actions added to git/git???
Date:   Mon, 19 Apr 2021 17:29:36 -0700
Message-ID: <xmqqmttt7q8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D09BB88-A16F-11EB-9EE8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is only of interest to those who interact with the mirror of
the public repository at GitHub, but anyway.

I was browsing https://github.com/git/git/actions and noticed that
there are many "workflows", even though what we have in our source
tree in .github/workflows/ define only two of them (which I consider
"officially sanctioned ones").

I suspect that these other ones come from "pull requests" random
people threw at us that never hit our tree, with changes to the
.github/workflows/ directory in these PR.

I find them quite distracting.

Is this something the hosting site (GitHub) considers normal and
helpful to the projects they host?  Is there an easy knob to disable
those other than what we have in our tree?

Thanks.
