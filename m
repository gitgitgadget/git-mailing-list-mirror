Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4D9920954
	for <e@80x24.org>; Mon,  4 Dec 2017 16:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbdLDQwd (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 11:52:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62613 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752915AbdLDQw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 11:52:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BFFCA1C63;
        Mon,  4 Dec 2017 11:52:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=liNN4VaEo7mmwsdTo3ZCk/XmI+w=; b=BYZpFk
        g8kOHMbmeU+Yxe2eF8Cn1WV5ByCbTW0qH4G/wKyPBgiTGdQzN0o8nReo/Na83qgc
        p+2yD2TJhWvr+/snV1nKk39t8w5pUKiY4vsunxlgvhzCC+wkMXhp59EglzrQG2+u
        /CZcQNMCG/st6V5I+SN05zLIhFraZw2qQdJr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tNtwkfzWQ4AldxH8jy0YBOz/eBEGzwSK
        ztAGgUx67qGqw09SRdUV0noZMYqaZLmIYN6ZtpPabLd3D9weycKdppjBuDkRpIoM
        PfTlDvljFq3QN2cfW856LOd+BQKFMTTAPeqXtjGm8Xri7uPSE8iy6Ymov8sfaw1r
        6XM/D1G4goE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02B59A1C62;
        Mon,  4 Dec 2017 11:52:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6EFA8A1C59;
        Mon,  4 Dec 2017 11:52:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5 1/7] Documentation: revisions: fix typo: "three dot" ---> "three-dot" (in line with "two-dot").
References: <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
        <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
        <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
        <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com>
        <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
        <20171124235330.15157-1-bedhanger@gmx.de>
        <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com>
        <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
        <20171203212743.10228-1-bedhanger@gmx.de>
Date:   Mon, 04 Dec 2017 08:52:25 -0800
In-Reply-To: <20171203212743.10228-1-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sun, 3 Dec 2017 22:27:37 +0100")
Message-ID: <xmqqo9nemo52.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8279E642-D913-11E7-81EA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found a few questionable pieces in 4/7 but other than that the
whole series is very nicely done.

Will queue; thanks.
