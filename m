Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C779BC433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 20:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9481D61A3C
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 20:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCYUKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:10:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57518 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhCYUKf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 16:10:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8F7510E36E;
        Thu, 25 Mar 2021 16:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pxMIwaIzp/TNDj1nKOiM9Ntf7ss=; b=vGPIOg
        /cWTLk8bcFESZxyuoEe1K15vlS/XRJx4xVRYAKp4GAAWiFahByFaY+vdWC8XUsrO
        4m6LR55cQ/WCYfQPtqHVdzBwVXsOzpx1hmY7J5GgjeQv4usyedCAOsSAIN0UWtnr
        m7KyHF/Ox++6jCt1JP6dQ4cqCFIQCZtGbH/PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=la3abDY1Gpu/a+ayykom8ORydDI612O/
        XOnQuXTLyzu++//vlHiU9Vz78XjjDTKF2rmXSigLOrWDx8+f9oQoj8OjN62vWvUL
        7i55Q74RaxfHyRRuVuohd/TwZiIiZfnHpcO8/nOGAYpHLYNOgqADCqKhfdtNTJ3r
        HakoqT0tyHU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A062B10E36B;
        Thu, 25 Mar 2021 16:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9D4710E367;
        Thu, 25 Mar 2021 16:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: give an overview of what a "patch"
 message is
References: <20210325105433.43310-1-bagasdotme@gmail.com>
Date:   Thu, 25 Mar 2021 13:10:31 -0700
In-Reply-To: <20210325105433.43310-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Thu, 25 Mar 2021 17:54:34 +0700")
Message-ID: <xmqqmturuh8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 276172FC-8DA6-11EB-BDEA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The text says something called a "patch" is prepared one for each
> commit, it is suitable for e-mail submission, and "am" is the
> command to use it, but does not say what the "patch" really is.  The
> description in the page also refers to "three-dash" line, but that
> is totally unclear unless the reader is given a more detailed
> overview of what the "patch" the first paragraph refers to.
>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

I do not think this was co-authored; you are forwarding somebody
else's patch that was written without any input from you.
