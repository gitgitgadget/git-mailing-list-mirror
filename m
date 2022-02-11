Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9131AC4332F
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 17:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352180AbiBKR24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 12:28:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352165AbiBKR2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 12:28:55 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C502C0
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 09:28:53 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CC8316A04D;
        Fri, 11 Feb 2022 12:28:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/bHHc3vdFMeO
        0EFJM4JHs4AcuzPuEgj6csb7/6GgybY=; b=MHEGLKGX4vMTsBfLtjEtaqdg7jAn
        BIs1QD4ppBfYheBRT1wKitD3by2NYMOzAFTCbO6B75/4P4DXbGK6y3ED0xJZTAEQ
        beqTJmgLnYMrs814fpMTP25ty5npw9N1EkJ3oL6eJmX94YVxai7DjiAM3B2SKE7Z
        e6TtRrcCJz6UG24=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 967C816A04C;
        Fri, 11 Feb 2022 12:28:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0310B16A04A;
        Fri, 11 Feb 2022 12:28:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     calvinwan@google.com
Cc:     git@vger.kernel.org
Subject: Re: Review process improvements: drafting a ReviewingPatches doc
References: <20220210233346.1009735-1-calvinwan@google.com>
Date:   Fri, 11 Feb 2022 09:28:49 -0800
In-Reply-To: <20220210233346.1009735-1-calvinwan@google.com>
        (calvinwan@google.com's message of "Thu, 10 Feb 2022 23:33:45 +0000")
Message-ID: <xmqqo83dcnxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13FF8A2E-8B60-11EC-86DF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

calvinwan@google.com writes:

> In continuation of Emily=E2=80=99s "Review process improvements"[1], I =
am
> drafting a ReviewingPatches doc to help standardize the review process
> here on the git mailing list and to provide a rubric/checklist for new
> reviewers. In order to do so, I am looking to compile examples and
> input from everyone by asking the list a set of questions biweekly.
> Please contextualize your answer in terms of whether this was a
> maintainer, individual, or drive-by review.

Often people other than the patch contributors themselves find
others' reviews a useful learning opportunity.  I take it that your
"contextualize" request is asking for comments like "As the
maintainer, I found this review by an area expert very helpful
because ...", as well as "I sent this patch and a drive-by typofix
at this URL was not very helpful"?

When soliciting input from the list, it would probably make it
easier for others if you led by example by sending your answers,
to show the level of detail you'd find useful.
