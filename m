Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4321F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKNCZJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:25:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57438 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfKNCZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:25:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBBB83587C;
        Wed, 13 Nov 2019 21:25:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G1PzeQusatarW+ludDJmzfc3rE8=; b=P/a7PK
        CeonMTGmAz+CyqvPgthbXUkfgnzm2zZcUefTUkiSYUlo1V5Nqp8zELPhpCf5wTb7
        oYpuuuV8fAjlqTqZcY/7iu7I15MdZN8s01Iyk4jbqkksr1IObIa/dQO+VBDXjkIp
        l5jYmYn6rEfIOHP0Uq9QAHYuDoQIElPg9X4Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hL1RJRmJXFgNdRXkGws72bn4LDncIWbf
        KOh+nJPoOXio2b5oMI/k4ZTetusVdgGzZLxv2NNb5zv2BlAXhJgJEZIKFXDIKs7g
        gWy0KZIZM+amf1OG/RTYq0KXdn3G3y1pxCoXGTxCk9V+zrO9aNxFyYJOmp0hObHs
        EMPrc7W0Sk8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2CFD3587A;
        Wed, 13 Nov 2019 21:25:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2ED9F35879;
        Wed, 13 Nov 2019 21:25:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/1] git-p4.py: Cast byte strings to unicode strings in python3
References: <pull.463.git.1573679258.gitgitgadget@gmail.com>
Date:   Thu, 14 Nov 2019 11:25:04 +0900
In-Reply-To: <pull.463.git.1573679258.gitgitgadget@gmail.com> (Ben Keene via
        GitGitGadget's message of "Wed, 13 Nov 2019 21:07:37 +0000")
Message-ID: <xmqqa78z9ou7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8C19F24-0685-11EA-917C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> commit: git-p4.py: Cast byte strings to unicode strings in python3

Luke, this patch [*1*] came in my way, but I am hardly an expert on
Py2to3 and know nothing about P4.  Could you take a look at them,
please?

Thanks.


[References]

<0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573679258.git.gitgitgadget@gmail.com>
