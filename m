Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B52C1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934799AbcIUQPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:15:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55665 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934641AbcIUQPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:15:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34B693C434;
        Wed, 21 Sep 2016 12:15:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QS56rCi9zgFOWfukTzUzN7tdXGA=; b=V4uilG
        VoRNrJdVO15dPdhqc017w2OwmKrv6wb0N24BkI09nurepzzRIc7fhiFwvVt3+XxU
        wtVAyQygL/7J9OtkdZNOITyZzTqiwObAfjlcLDgVMKWlknfpfxBIIFUZZ5JD0LXL
        Bh82ZumurdbaPRbeag+43NfC4qGDPJQToo0wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KLNyMHqOlE0HQbnLPnFK/SX3xvUPB7Pt
        mPX3xrP/OOBKa8TS4qA6SeYRGIsl6jUapSwSNWH1bJmN+g1qKBWPAdoV8wpx7rfh
        6mLnMxXsgeZ9sJ2Ts1OQzRBRPkIsAl6qEnFW7q9zbnxLy/Fi0q3QwPaIwJLrHLqE
        HFXaY4c+ChY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BFEF3C433;
        Wed, 21 Sep 2016 12:15:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7B773C432;
        Wed, 21 Sep 2016 12:15:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
        <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
        <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>
        <affca640-4ed8-268a-9f7d-e2c7ce6d66fc@drmicha.warpmail.net>
Date:   Wed, 21 Sep 2016 09:15:45 -0700
In-Reply-To: <affca640-4ed8-268a-9f7d-e2c7ce6d66fc@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Wed, 21 Sep 2016 16:46:45 +0200")
Message-ID: <xmqqlgylb55a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7F750B4-8016-11E6-B540-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I think you answered to e-mail (in-reply-to) and to Philip's actual text
> (quotes), but just in case:

Yes, my mistake.  Sorry for the noise.
