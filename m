Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF71C001DF
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 22:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjGaWFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGaWFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 18:05:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11CE7
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 15:05:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF41B1C15D;
        Mon, 31 Jul 2023 18:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UmB+ZYmU/a/BJg8h0y4ILl672IaIgGdwmvuTwp
        FWnes=; b=q7tFNeorAQ3Xg0ww1azLHAAOmTW5rAobS2+PeGKay0U4xPR7uHt5As
        3YEsN4iE4ZNTVF0KCBHmGCvcmKFBm7YNgX2RUnJ6aC9gq95B1oG5+Z36i9lE257W
        G4D22SN7X38/HAmM4CY0nxnqUAU938fItIKYHD6eNJRlWVZabIbGM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B77721C15C;
        Mon, 31 Jul 2023 18:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5441B1C15B;
        Mon, 31 Jul 2023 18:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thomas J. Faughnan Jr." <thomas@faughnan.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
        "Daniel P." <danpltile@gmail.com>
Subject: Re: [PATCH] ident: don't consider trailing dot crud
References: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
        <20230731214435.1462098-1-sandals@crustytoothpaste.net>
        <CUGOYGU96P8T.3EUVTC5SAFW36@badwolf>
Date:   Mon, 31 Jul 2023 15:05:37 -0700
In-Reply-To: <CUGOYGU96P8T.3EUVTC5SAFW36@badwolf> (Thomas J. Faughnan, Jr.'s
        message of "Mon, 31 Jul 2023 17:56:06 -0400")
Message-ID: <xmqqleev20um.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61BD9CA4-2FEE-11EE-90A9-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thomas J. Faughnan Jr." <thomas@faughnan.net> writes:

> I agree that simply dropping the "." from the crud list is the best
> solution. Hope this gets merged.

Sure, I do too hope this gets into a shape that can be merged.
