Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F09820387
	for <e@80x24.org>; Tue, 18 Jul 2017 20:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdGRUMz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 16:12:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53707 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751457AbdGRUMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 16:12:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC86279F5C;
        Tue, 18 Jul 2017 16:12:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=u
        oq1oCgLlTqpdDX/iUbLy7J1Wic=; b=dDElFQw3kkFRD6F+avP4DYm4Lm/aa7Kdz
        Dw6CstczP+1O9XZCN8pjIBXiHq632Pv2BY/4I/tG1elbLLjwSIiF93fHHGaox0JX
        NevUzZ4RVB5M5TXE3/7aQRLbBjNZqBHu+q5agER6x8Xj1s/JzlzroptsmttjlXIh
        hfkyNjrPr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Ey8
        lx7YftT+4DyS3fdeLq9mW23UP7d/iDSITnwY+LEzgtq6utOfYYxFVDjKpXkpgUF9
        lbJDCmVwTRVp2RtLkRe0q9yJyNz7HEsoE5yvLF2N3JHQMv4KagCJ/fpa3NKMmBQ2
        XOXU80mTfW7c5I32ee7NFpXrNoVM9JA3/nSogmOc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4A7979F59;
        Tue, 18 Jul 2017 16:12:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED3B679F55;
        Tue, 18 Jul 2017 16:12:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Is anybody seeing t5551 get stuck, every once in a while? <EOM>
Date:   Tue, 18 Jul 2017 13:12:52 -0700
Message-ID: <xmqqbmoho663.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 7B6A4BB6-6BF5-11E7-88BB-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

