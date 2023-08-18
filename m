Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78964EE4998
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 21:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbjHRV2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 17:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240772AbjHRV1t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 17:27:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54411BF9
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 14:27:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D35129072;
        Fri, 18 Aug 2023 17:27:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f5g/JLJpNs/+Jo82Z4jVxzslr3yz06pOh5Y8RG
        g75Dg=; b=w0UPCcvxQt5oCAmc77CafZNhKycjcPCzQ2IMmNYttZYlZZLX76INSV
        G6GNAFtovEB9iyd3igRby2b44LG9o6+HVy6dCW5M7SKitU+MaNeREZTGsqv73UK1
        RBdhCL/QfCktZ9gZmF8zED643tEWimcuDLVvCXS8vYtLyUIU5aifo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 361B129071;
        Fri, 18 Aug 2023 17:27:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E7D4A29070;
        Fri, 18 Aug 2023 17:27:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [BUG] Git 2.42.0-rc2 t1092.57 script error
References: <018601d9d1fc$2049ede0$60ddc9a0$@nexbridge.com>
        <xmqqedk0uq6r.fsf@gitster.g>
        <01a101d9d20b$836f1a30$8a4d4e90$@nexbridge.com>
Date:   Fri, 18 Aug 2023 14:27:43 -0700
In-Reply-To: <01a101d9d20b$836f1a30$8a4d4e90$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 18 Aug 2023 15:38:01
        -0400")
Message-ID: <xmqqzg2ot50w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1220ADDE-3E0E-11EE-96AF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> Is this new test code? The local qualified appears to be a bash extension,
> not available across all shells - from what I can determine. Is it really
> required here or just fancy?

You are asking a wrong person ;-)

You know Git well enough to run "git blame" on this code yourself to
answer the first question and find out whom to ask it:

  https://github.com/git/git/blame/master/t/test-lib-functions.sh#L1794

