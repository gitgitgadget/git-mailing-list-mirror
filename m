Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0FE1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbdARSs0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:48:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64238 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751914AbdARSsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:48:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C6805FCD5;
        Wed, 18 Jan 2017 13:44:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FhwykJG9eEwgJyTubXCbH8Zq7sA=; b=Ml9KsN
        oJ5/dIT7ByqmJQu6O/hHdyXGbANhVIrwSwT2p7Ow+tMiGuWFF9nfVbcdBl5KTeRq
        HOHaoCmeXifkvSoV7v4vczvVTh582E/oJfcicwa+78ebc5YujXYZG8UHZMPIXdP4
        5PBGBti0SO8mnEz7wgGikJ73dnIonaRw7mnjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jvSGcLWfTZF+WWAlM7tKOLLfnmUhIwXK
        DYBYafEn6Xs9Zyg0ueFFVY1vG9FScb6WhR7jGA9iDn1aoZbu6/6XtFfH7inFAgu/
        wWCp/p0Dhzn6M3lHHMOQQjCJNPC7BmZr+hICEHglvpDhdMp98fdfxUpDCTfSg2W1
        XCEMpLva4pw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72A095FCD3;
        Wed, 18 Jan 2017 13:44:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B386C5FCCD;
        Wed, 18 Jan 2017 13:44:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>, meta@public-inbox.org
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
References: <20170117233723.23897-1-santiago@nyu.edu>
        <20170117233723.23897-5-santiago@nyu.edu>
        <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
        <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
        <20170118182831.pkhqu2np3bh2puei@LykOS.localdomain>
Date:   Wed, 18 Jan 2017 10:44:03 -0800
In-Reply-To: <20170118182831.pkhqu2np3bh2puei@LykOS.localdomain> (Santiago
        Torres's message of "Wed, 18 Jan 2017 13:28:32 -0500")
Message-ID: <xmqq4m0wb43w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16372488-DDAE-11E6-AFFB-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

<<nothing>>???

Eric, I've noticed that this message

  http://public-inbox.org/git/20170118182831.pkhqu2np3bh2puei@LykOS.localdomain/

and all messages from Santiago appear empty when they come via
public-inbox.org; the reason I suspect we haven't heard much
complaints is because nobody else around here sends multipart/signed
disposition inline other than Santiago.

