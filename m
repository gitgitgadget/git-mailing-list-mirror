Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD461FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 00:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761972AbdJRA5U (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 20:57:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61672 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756563AbdJRA5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 20:57:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C23D9A4A1B;
        Tue, 17 Oct 2017 20:57:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6nj1uhUPWocor2W/s3R786tH/ck=; b=eyxIcg
        T0kqvaBCGPa6LltGYX6imwNdflBvgfBM5ufHaO3WUUl7p28h/wrVwZ/13oQ89u8g
        RWcVoO+XISXcP381FwqV5NXPqIWd8zTOINT0MmKu6P8hmu6x8wKNTu6WSo3E5AHn
        DYCMaKkUSmpAErnSw6q6+Qrt52BQO4mzFJFNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M7LMb4Ex/qPsjWPDLbvvQFa+hrOc3Kyn
        hji69WUUKWklPW/lgqkupDvanUVV0nqXm7rFXGBcI9rbnAbKoC6MoPhqjxK0wQJM
        Rw1QmsAgFT0NAx8/QI3jXOuY8bH6DQwYSeH8bILx6IrroLx5NQ7rlzsDVvFF7jhX
        YCQuHHHCCHs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAA2AA4A1A;
        Tue, 17 Oct 2017 20:57:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26396A4A19;
        Tue, 17 Oct 2017 20:57:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gilberto Stankiewicz <kiewic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Has git-gui repo moved from location?
References: <CACjmu29CV_0HgmNaBmNLn-J4ZdUx+jRgweNSibBsB2SOZBWWEg@mail.gmail.com>
        <CACjmu28WBUZMyivR-uvttMURSEtVuCUaYHdtT0mpv4LAffOd5g@mail.gmail.com>
Date:   Wed, 18 Oct 2017 09:57:15 +0900
In-Reply-To: <CACjmu28WBUZMyivR-uvttMURSEtVuCUaYHdtT0mpv4LAffOd5g@mail.gmail.com>
        (Gilberto Stankiewicz's message of "Tue, 17 Oct 2017 16:50:36 -0700")
Message-ID: <xmqqr2u1l1ck.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4975C012-B39F-11E7-A849-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gilberto Stankiewicz <kiewic@gmail.com> writes:

> I am trying to clone git://repo.or.cz/git-gui.git as described at
> https://github.com/git/git/blob/master/Documentation/SubmittingPatches
> but it seems the repo does not exist.

$ git fetch -v git-gui
Looking up repo.or.cz ... done.
Connecting to repo.or.cz (port 9418) ... 195.113.20.142 done.
From git://repo.or.cz/git-gui
 = [up to date]            master     -> git-gui/master
 = [up to date]            pu         -> git-gui/pu
 = [up to date]            todo       -> git-gui/todo

$ git fetch -v git://repo.or.cz/git-gui.git
Looking up repo.or.cz ... done.
Connecting to repo.or.cz (port 9418) ... 195.113.20.142 done.
From git://repo.or.cz/git-gui
 * branch                  HEAD       -> FETCH_HEAD

