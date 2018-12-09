Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AA320A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 01:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLIBjn (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 20:39:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59310 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLIBjn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 20:39:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15EE0112FC1;
        Sat,  8 Dec 2018 20:39:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZGxMwXZ3ub38J+j+bdCZK6iY7lI=; b=qsFBXB
        23wYqozdBmm89Bp7xaUlZpa6/1nZkH+wuUSA57WFgsS6EyeL3tXYqLk82alghBA1
        jd610qC5XHsbw6Oq3SE9s+gRHhSAMmnyGuPRHV1nGTRbQ1erDi4snyC2nFunXjQb
        dxq9b+80hipJPQqh3lIUVzY/r8SzvGnjbU1HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hQarSdDpuAyduIBaatQAuwV+EFUvNCf2
        4dzrrYQuTogCM8+2VxSB+IOYCgVbh47vq9PnNeSVAdRL33l1YIzf/upHXzDz0O5o
        qk6duB9Qy1nmE+qrpTFBUMGEhXcEvgmAWq3WWNW9DYwlMITy3Hp8RCfrn5+4E3wg
        FmtUKv2DR50=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E508112FC0;
        Sat,  8 Dec 2018 20:39:41 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83483112FBF;
        Sat,  8 Dec 2018 20:39:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, svnpenn@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 1/1] git clone <url> C:\cygwin\home\USER\repo' is working (again)
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181208151109.2097-1-tboegi@web.de>
Date:   Sun, 09 Dec 2018 10:39:39 +0900
In-Reply-To: <20181208151109.2097-1-tboegi@web.de> (tboegi's message of "Sat,
        8 Dec 2018 16:11:09 +0100")
Message-ID: <xmqqk1kj5vhg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BB026D6-FB53-11E8-ACF8-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> - The "DOS" moniker is still used for 2 reasons:
>   Windows inherited the "drive letter" concept from DOS,
>   and everybody (tm) familar with the code and the path handling
>   in Git is used to that wording.

Yeah, for the same reason as win32 can refer to their API that is
used on platforms that are 64-bit, the fact that the "drive letter"
concept came from DOS is so widely ingrained, I do not think it is a
beter change to deviate from it.

> And, before any cleanup is done, I sould like to ask if anybody
> can build the code with VS and confirm that it works, please ?

Yup, that is much more important.

Thanks.
