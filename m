Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499E32095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdCRTbQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:31:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53401 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751661AbdCRTbO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:31:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0202184057;
        Sat, 18 Mar 2017 15:30:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lZa7k2q92BEdh/jNMLD0VXDCCt8=; b=hafxLo
        OuxM9fNBOHVrWwczT9E5/+3T9VfmJYuQwqS3Hv9f8ookqbGN4jkMuiQNHsde7lLE
        BEySjDJyAXlVvJeJns55CPdrYkX7e3/cSWow+grdAxoPZ1ihSGwFUlWhDvVQ8IXV
        bfOhoucNx9tEjKKX9nmQszRX7edTGvfSTwuUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WC4dPNh+wbmxRfr1MMw3RuKUztHmfPcC
        3oQ5RvUEzyaHhnwb5vpG1jtU93a2asN3oUxRqeI2ftS2XrHcL1wH3kJi7GrmdnR2
        /QAYtxnnxiPbe0cjz8L768p3eudryyPiwlErFq55cS/PwUzbx0hWTGy7M0+weKn0
        ajT9lML52/o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE31884056;
        Sat, 18 Mar 2017 15:30:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E7E984053;
        Sat, 18 Mar 2017 15:30:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: How do I make 'git diff --no-index' follow symlinks?
References: <CACBZZX6Bknimu26in8YG7TbsL3hEpmXTYwQAZQ5xK-DFoSatEg@mail.gmail.com>
Date:   Sat, 18 Mar 2017 12:30:52 -0700
In-Reply-To: <CACBZZX6Bknimu26in8YG7TbsL3hEpmXTYwQAZQ5xK-DFoSatEg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 18 Mar
 2017 18:55:27
        +0100")
Message-ID: <xmqqk27m1ixf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66AC52C6-0C11-11E7-A1C6-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sounds like

    https://public-inbox.org/git/20161111201958.2175-1-dennis@kaarsemaker.net/

to me.  A key message in the thread may be:

    https://public-inbox.org/git/alpine.DEB.2.20.1611121106110.3746@virtualbox/
