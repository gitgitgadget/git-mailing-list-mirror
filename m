Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1444DC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00DE20772
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 19:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="owOCnMZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRTJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:09:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57847 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRTJj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 15:09:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF4C8E54CD;
        Tue, 18 Aug 2020 15:09:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=okD8qCh3WQW+/nrqw8xz+cibhXg=; b=owOCnM
        Z5I5k5uo2tBRBoI4cK5oMy6QODgKNvMmWwFWVSYfIZFvNZpJzLq4I82NV4Zkd4vp
        FuwrjLXin/0wHR62f+dTxputXkOkC6DYCd9KF68zaGxBDYcQTF59W8w3qQndTJji
        J8sZgTVHKro+aI+vZrjwnoruhWoKY0QyHbzGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sagBeTzb9K/wF2psMChgGRQg2cF/ddAy
        jDRUfH9JkDg7CJAQqozZAyv0HenuaHyDDlkQwuAZlgsjvnt3S0VsXURY0pY90xwm
        8CgjamBMQt1F7ZQSafKLpE9IPgSWSItnqcMYvXkPjUw3NsDedzWOmLQIgQURj3ga
        qaCgnIEYArE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D73FAE54CB;
        Tue, 18 Aug 2020 15:09:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1ABFE54C9;
        Tue, 18 Aug 2020 15:09:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carmen Andoh <candoh@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Inclusion Contributor Summit Registration
References: <CA+Twho+nyERK1Ljdy6MnXA=iK6SiU85v4yLQc+fRmW83JVa+hQ@mail.gmail.com>
Date:   Tue, 18 Aug 2020 12:09:34 -0700
In-Reply-To: <CA+Twho+nyERK1Ljdy6MnXA=iK6SiU85v4yLQc+fRmW83JVa+hQ@mail.gmail.com>
        (Carmen Andoh's message of "Fri, 14 Aug 2020 16:22:02 -0400")
Message-ID: <xmqq1rk3zs7l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B315F88-E186-11EA-A4C2-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carmen Andoh <candoh@google.com> writes:

> This is a free event.  We encourage anyone interested to register by
> Tuesday, September 7th.

Monday Sep 7th, or Tue Sep 8th?
