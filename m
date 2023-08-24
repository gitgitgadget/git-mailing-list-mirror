Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F42C27C40
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 17:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242719AbjHXRCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 13:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjHXRCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 13:02:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04035DB
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 10:02:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 937C52FCDE;
        Thu, 24 Aug 2023 13:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5y8rhTj09ZbwURv2T9t+u30TYJpgUcEbEpok9M
        HP8BM=; b=ABd621uRvdufRruLVQgqlVndmaIwxLFoEzopVGKQNzwqL0373fu0dw
        bZ/lZTGPLs2zehB44twiHHo4pVipvE1SWoWGSI6+lYpSfmzmJhkwZIjQXNxlrXT2
        NR7EiMfVnMAuH+GWk2OBMGp0tLbrPzq+xZxyqk1L+piSohMtHa7Lg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C8ED2FCDD;
        Thu, 24 Aug 2023 13:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC8C42FCDB;
        Thu, 24 Aug 2023 13:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Mark Levedahl <mlevedahl@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Subject: Re: [GIT PULL] git-gui pull request; also, call for a new maintainer
References: <mafs0wmxkcs3o.fsf@yadavpratyush.com>
Date:   Thu, 24 Aug 2023 10:02:07 -0700
In-Reply-To: <mafs0wmxkcs3o.fsf@yadavpratyush.com> (Pratyush Yadav's message
        of "Thu, 24 Aug 2023 18:39:23 +0200")
Message-ID: <xmqqjztkbchc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F605BA40-429F-11EE-8811-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> For these reasons, I would be happy to hand over maintainership of
> git-gui to more interested hands. I do not know of anyone myself. But I
> hope this email finds itself to someone who would be willing to
> volunteer.
>
> In the meantime, I can still pick up odd fixes or security fixes every
> now and then. I cannot promise much more than this.

Thanks for your work on git-gui so far.

Will merge.
