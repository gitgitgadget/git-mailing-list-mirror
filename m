Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB001F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 09:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbdKMJtD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 04:49:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64034 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751202AbdKMJtC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 04:49:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 102799B960;
        Mon, 13 Nov 2017 04:49:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iJL5CMZn1Ac4mjz4NbjNyEwqvuA=; b=vr+Hej
        wi/ptA4QSR/zb6np5GKTYkt1S5Q2Oy9oJ3K9wIuRyruuXPzhL/sMrAjxWH7BAJYM
        zVlSe/nHw+C5A3fh2WSN4dikVnIMwG5evglZz+Im3EqNw6+oguLAu0YbPULQ5u2d
        O+sMJvnzGbxtFYmQYk8uMadWGjpEhG5OzRKb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XDX22QmViXeSMYbpMCv9vhpRekLt0kf9
        3kKkvgTdIE+6CwyZctj3UN3oF2IwGzrT8Oi/RBez1KV2THz7cdi0tdsol7GzyOIv
        DNRkDq12kNveIfuAJDkTNon2x6yoRcIQAIJQ1YMkzDlgz3wqYD7ZyxLCYZE9xGFV
        tVJkeyiIzA0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 089889B95F;
        Mon, 13 Nov 2017 04:49:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 772109B95E;
        Mon, 13 Nov 2017 04:48:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] cover-at-tip
References: <357e8afb-4814-c950-1530-530bb6dd5f5a@suse.de>
        <e1d3ab5b-82e6-8490-8f2e-00c1359c6deb@suse.de>
        <xmqqbmkaf0yn.fsf@gitster.mtv.corp.google.com>
        <bbdeaba0-b757-041d-9649-4150080d4b07@suse.de>
Date:   Mon, 13 Nov 2017 18:48:58 +0900
In-Reply-To: <bbdeaba0-b757-041d-9649-4150080d4b07@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Mon, 13 Nov 2017 08:58:24 +0100")
Message-ID: <xmqqh8ty8q5x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF79251E-C857-11E7-852F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

> I agree this is a "am" job. Was just wondering if reusing some of
> the code from apply (and move it so it makes more sense) wouldnd't
> make more sense than rewriting a patch detection function.

Yes, I understood that and have already given an answer, no?

