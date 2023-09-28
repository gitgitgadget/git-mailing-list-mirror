Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CFFE743C1
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 20:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjI1U1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1U1c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 16:27:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC27180
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 13:27:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23EB128E82;
        Thu, 28 Sep 2023 16:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=UUuxsxcCkSAcPdT2vtraQ941pUMhETLaGswkLM
        3oXg8=; b=SniYCmqpiS5f5PkiEys9+e1InqiFjZ/8Tra4fCEi7VGtRWy6JmOyC7
        WHKgh9rpFC+aTS80V7GNG0CMeiucG4Iji847wCFu2oSVtPrpMrs9Ckdil284LCUL
        asVXcKHc5F/vsg7ABMS1zwBbFf9+Qdt5dTJ1quYkpD7uuBYPhpAu8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C74F28E81;
        Thu, 28 Sep 2023 16:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF6C728E80;
        Thu, 28 Sep 2023 16:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff --stat: set the width defaults in a helper
 function
In-Reply-To: <0570bd5c26caef1ff66a643558305fb0@manjaro.org> (Dragan Simic's
        message of "Wed, 27 Sep 2023 04:30:53 +0200")
References: <d45d1dac1a20699e370905b88b6fd0ec296751e7.1695441501.git.dsimic@manjaro.org>
        <0570bd5c26caef1ff66a643558305fb0@manjaro.org>
Date:   Thu, 28 Sep 2023 13:27:25 -0700
Message-ID: <xmqq7coajb6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 706DD066-5E3D-11EE-826C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> Just a brief reminder about version 2 of this patch...

It still is a bit premature to queue this before the topic, to which
this is a clean-up for, graduates to the 'master' branch, though.
