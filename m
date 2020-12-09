Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FCC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7210422B3F
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgLIPs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:48:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54512 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLIPs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 10:48:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F167996DC;
        Wed,  9 Dec 2020 03:13:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fqxMZYna3xGBkbwifg/yW60yXo8=; b=jdJiLb
        JeIptWluvQn2kDaZnZ71OIVYOWWWYxGI7xbxIH2cceDVzQtvAURJCLTO8zRyNPc3
        mOn2T9M+FQizM9l3VuU9sfskwQpGVXykKgdXvPkldVQHHdGuB0LjDGOaIDai3xt+
        fqhymdgm47G6QczgUzSP61aoumN9AzQQIFwTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JLaJQ/Yiwqp24BuOuZb0/7W1Zv+4dgMm
        HGISLvSdvBRjSzF5bDJv7N5DhlXomv8V3GZcqWJ7Op4Zu9PGm+LQFLlPUEOTdj9y
        Dxwt/0Nva/Yvd5TXeKPTFlUw7ycWEyW7Zf5mxj9nh3ia9Chl2rJccBK6/Q3xEI8X
        kKREjY+YGDg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5690D996DB;
        Wed,  9 Dec 2020 03:13:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D33E4996DA;
        Wed,  9 Dec 2020 03:13:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
References: <20201209002619.25468-1-felipe.contreras@gmail.com>
        <X9A1On3v35nEjL7i@camp.crustytoothpaste.net>
        <CAMP44s0W3En0ZuNfBOOZhfeFUeFRvEFs7khAFRraocuDaFpbNA@mail.gmail.com>
        <xmqqlfe731vh.fsf@gitster.c.googlers.com>
        <CAMP44s2xo=n4z6m7FhuPiZ66yPWvmdQuAodvh2XNpdVAfo6R8g@mail.gmail.com>
Date:   Wed, 09 Dec 2020 00:13:08 -0800
In-Reply-To: <CAMP44s2xo=n4z6m7FhuPiZ66yPWvmdQuAodvh2XNpdVAfo6R8g@mail.gmail.com>
        (Felipe Contreras's message of "Wed, 9 Dec 2020 01:16:14 -0600")
Message-ID: <xmqqh7ov2y97.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F50F998-39F6-11EB-AE82-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> *2* In other words, I doubt these graphs are depicting "how widely
>> is an editor used by developers".  It is just showing how often it
>> is installed, and I know the primary workstation I use daily has vim
>> and nano installed without me choosing to have them, as opposed to
>> emacs I had to manually install, and I only use vim once every month
>> and nano once every quarter.
>
> Yes, but in Arch Linux at least no editor is installed by default.

I thought everybody has nano not because it is adequate and usable
for them, but because it comes by default with distros, and distro
in turn choose nano not because it is particularly popular but is
small enough not to matter if left behind unused when the user
chooses a real editor.

But you are essentially usaying that 80% of Arch users install nano
by choice.  I find it doubly surprising.

