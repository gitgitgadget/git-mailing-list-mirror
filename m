Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB18C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B10215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="piF3ejhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgAaUIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:08:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61977 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaUIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:08:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFD8AAC8DA;
        Fri, 31 Jan 2020 15:08:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+elItryKNcHcGbQ4gaf5GLWV97o=; b=piF3ej
        hZfrjfpcmw8Y26EMK4SVqrY37ra80o6SbZvHMNicXhsfykeB8SJVG6k39ISTlF3T
        7Vb3lbQojaMdH0PFuwnSon5bxc5eDQ84iPgSVQxOXl71pOmLlUk3hNIlSLPPJ/kA
        Fq6wsGRsw53PEWnwXYk6ela9iWIF5GMeFsAoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CPkYhMe4mXcq7zqOHLAeKtMnNKMaG+uo
        iERA4ffeRkos/EuXBcfGAv4kAsA/4XDR92Cv/YaZjtV+bDhdTpVzZS+8ehXq/lpk
        e62KHO17Gdrk5W4YbBTWgV5GKzXBxjDwK6txXATq1GB2a+1tcHt70xCUDZuj2EQ7
        tc1HRX/Cna0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7D6CAC8D9;
        Fri, 31 Jan 2020 15:08:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCE35AC8D7;
        Fri, 31 Jan 2020 15:08:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Git <git@vger.kernel.org>
Subject: Re: change of mail archive?
References: <20200130223011.tx6gzmaql24zemht@LykOS.localdomain>
Date:   Fri, 31 Jan 2020 12:08:12 -0800
In-Reply-To: <20200130223011.tx6gzmaql24zemht@LykOS.localdomain> (Santiago
        Torres Arias's message of "Thu, 30 Jan 2020 17:30:13 -0500")
Message-ID: <xmqqo8uj9yoj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A034184-4465-11EA-9342-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres Arias <santiago@nyu.edu> writes:

> I just noticed that the archive[1] I was using is missing almost a whole
> month of emails. Is there a new "blessed" archive? Sorry if I missed a
> memo...

mail-archive.com has never been a blessed archive to begin with.  

In general, archivers offer public service by giving access to what
they receive as merely one of the subscribers---they generally are
not "blessed" (well, unless the mailing list software directly
injects the archiver, and from that point of view, that is).

https://lore.kernel.org/git/ is probably the closest to be called
"blessed".
