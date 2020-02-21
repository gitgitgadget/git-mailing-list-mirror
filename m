Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D812AC11D24
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09DA208E4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pR9rsAzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgBUDoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:44:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61456 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgBUDoe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 22:44:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61615537B3;
        Thu, 20 Feb 2020 22:44:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I4eLfBt5+vGtOa9+fzHYLgC7CLs=; b=pR9rsA
        zG5T6CBU7TPvXV1sdJJxKkzRBbz7zHYI0vxQdr7yafXnsYca0teqBqJ2xopBEsgD
        gb02EuTDtOpRmZEd6xkVt5i59kMM5k1l3a3uK6jb7Fw7umtuAB4m9zFN++jHt+EZ
        4Oh2zxlK9mwRdfcPLkru+VPixY2TEGXvdFjXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fhteSCQxff/XdzYjaEu++Dxu/8/UGTso
        kYl3H5nnPlif2A3SrlXBmLBI7su6FU7+wmnafsdRozaN7guD2lcSRCHIxB4NEoS/
        k1j6sccOZQgRLeabfah+BhDbmh+W+KSLi+gEh3zm89dX1QGZnumZP2e28/Kf4b9j
        h9s86bvsU4k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A5BA537B2;
        Thu, 20 Feb 2020 22:44:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE6D0537B1;
        Thu, 20 Feb 2020 22:44:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/15] bugreport: add git-remote-https version
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-8-emilyshaffer@google.com>
        <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
        <20200220232812.GH2447@google.com>
Date:   Thu, 20 Feb 2020 19:44:30 -0800
In-Reply-To: <20200220232812.GH2447@google.com> (Emily Shaffer's message of
        "Thu, 20 Feb 2020 15:28:12 -0800")
Message-ID: <xmqqo8ts7gf5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 782A267C-545C-11EA-AFC6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> ... Unfortunately I agree that we wouldn't be equipped to handle
> reports in other languages.

I actually was anticipating a far better world ;-) 

There is no reason to limit the recipient of reports only to *us*.
Use of Git and population proficient in Git would become wide enough
that we should be able to expect that users who speak language X can
be helped by experts who speak the same language X with their
issues.
