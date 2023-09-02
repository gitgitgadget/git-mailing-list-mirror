Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA867C83F2C
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 22:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjIBWQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 18:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIBWQP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 18:16:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB50CE0
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 15:16:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E49A02B061;
        Sat,  2 Sep 2023 18:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=k2a7HMYSGZ8V1QlRc4mPMJ1sIlK3pmaZ3jOfvf
        0WyQc=; b=wkIcXoVIvRjKV0uf+YCcCSJeiBe9txryDB2CZnEaY70AYC82tQyPJl
        Ulm2y8ghgqXm+Bavut/TOjff9eytB6fi/ffRpYFUuhdmUd8vPrPWiNaYlyhdG9jS
        aRb0tSfU9zu8izJMB6HQZhS6u2hFu5rFSox7z+ZT+C3aHyNpnj1l4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCAB32B060;
        Sat,  2 Sep 2023 18:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B2E42B05F;
        Sat,  2 Sep 2023 18:16:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] New configuration option "diff.statNameWidth"
In-Reply-To: <72c114086590b9b15a3fdd9e0d6bd67e@manjaro.org> (Dragan Simic's
        message of "Sat, 02 Sep 2023 20:56:58 +0200")
References: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org>
        <xmqq8r9ommyt.fsf@gitster.g>
        <72c114086590b9b15a3fdd9e0d6bd67e@manjaro.org>
Date:   Sat, 02 Sep 2023 15:16:07 -0700
Message-ID: <xmqq4jkcmdaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5104097A-49DE-11EE-AF54-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> Thank you very much for your thoughts and the time required to write
> it all down.  I'll do my best to make my patch(es) irresistible. :)

Heh, I have to send the same from time to time, so it didn't take
that much time.  Having said all the above, once we start seeing the
actual patches and its sales pitch (aka proposed commit log
message), we do guide and help polishing the patch into a better
shape, so it will not be like the contributor has to work in the
dark without knowing what level of bar their contribution has to
pass.

Thanks.
