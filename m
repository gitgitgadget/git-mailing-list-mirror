Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A79F1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933488AbcIUSMy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:12:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52843 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932340AbcIUSMx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:12:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 927EA3F6BA;
        Wed, 21 Sep 2016 14:12:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xpGRSjvPkT+hHYj9rPhxJeTo4HA=; b=W2SQN9
        oMiubdrqKuCF9DbeHLa0O/6aQvhd1S79kZLQX9RoMCYxfkE6Wyw/mvDol9p5+Fdm
        u0wQMqxoqEn7facalA8Dzv5eyjz2Lbw/UvHQ8heAo06fUFLBn65N36ZzgO0xnzkO
        kzEemIW7rJIrZ2wj3hny3ViYaCXQj6eGjqfcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uPFRb8u/Gf+RqBDflrlYcDiSw6uN01GP
        PF17lbay2sKYepCoAUHQjd7b49iR8ybOY2KlxXLRyYSR7QWJfXim1pLoRe99ZkYt
        u/toakz7loYaYk9UpevrnwP/N11pB3UNZuk3PGXyrwQ+za7iLhd1iF87HGF3Ri3a
        OsJw1JNqvCU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BD453F6B9;
        Wed, 21 Sep 2016 14:12:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F42E3F6B4;
        Wed, 21 Sep 2016 14:12:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-check-ref-format.txt: fixup documentation
References: <20160920073314.22485-1-gitter.spiros@gmail.com>
Date:   Wed, 21 Sep 2016 11:12:50 -0700
In-Reply-To: <20160920073314.22485-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Tue, 20 Sep 2016 07:33:14 +0000")
Message-ID: <xmqqponx86l9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02DB757C-8027-11E6-9DFE-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> die is not a standard shell function. Use
> a different shell code for the example.

Thanks.
