Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A40C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 22:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiIZWoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIZWoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 18:44:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5492BF5
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 15:44:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21A521CE549;
        Mon, 26 Sep 2022 18:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K4Vbk5c5o1TSvLsxBNTR97wkvv55dwk/u1n2bb
        L1zIs=; b=O78zdNaFdzkip3PaeKuoKaDIGxFuYtmKPh41FvZVULK8SN0LIPmJ42
        M3fDmCn2i2i/L0eZ3LyUqTBRNMcWQxozBkFRn3HBtqapH8ubFwa/ne7owh+f7e/h
        3Jb8ZK/l3qrObl1T0i+I2M++ZVPBFPonUxdJms4m06BKK1+XUcQxk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18ECA1CE548;
        Mon, 26 Sep 2022 18:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AAD801CE546;
        Mon, 26 Sep 2022 18:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: Join us for Review Club!
References: <kl6lfsgdn4oe.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 26 Sep 2022 15:44:34 -0700
In-Reply-To: <kl6lfsgdn4oe.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 26 Sep 2022 15:37:05 -0700")
Message-ID: <xmqqr0zxah7x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC470E42-3DEC-11ED-93A3-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> [2] http://tinyurl.com/gitcal 
>   Note that the gitcal event is a little out of date; it should say
>   say "Please contact Josh Steadmon <steadmon@google.com> _and_ Glen
>   Choo <chooglen@google.com>...".

I can make that happen, but do you really want both of them to be
contacted?  Also do you (or Josh) want a write access to update
these details?  You two clearly have a demonostrated need to such an
access.
