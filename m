Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2340820A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdJBAo6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:44:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50522 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750943AbdJBAo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:44:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72603B64B9;
        Sun,  1 Oct 2017 20:44:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hzYpFMWTOKJMLtbJVh3jFPcF+8s=; b=Tr+H8g
        2Y1fWwJMJUsuuuhjp378oTrmyPYItZJrq9hVtdqRbVqpCiuF49QJmFSmkQbcNS8W
        6quQ7FBfN7+OUcSVVGReunf1ZsaKy3C4KSZSqfSer9jKTNpEsylnYGr3jFVp0ZJV
        4ipIQffsHge90T36I/itMllaotqcomKkGNPbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tVd50uOK2ifC3uT14IyTQapQa4i0Gcs0
        h58ZFgDQUlPiRKS2k1T+qPkF9tmMZqUMHWcXLsvcn4ZhnMNuyZKOc0P0WzdEG1/x
        wNOtBRe0t154aRK9kukmGdodffOmP+t8vAuJ3YpecpbjGbjO2G1faAvr3wPG6xge
        LYTij5Y8G9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69192B64B8;
        Sun,  1 Oct 2017 20:44:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF948B64B5;
        Sun,  1 Oct 2017 20:44:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sbeller@google.com
Subject: Re: [PATCH v6 1/3] submodule--helper: introduce get_submodule_displaypath()
References: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
        <20170929094453.4499-1-pc44800@gmail.com>
        <20170929094453.4499-2-pc44800@gmail.com>
Date:   Mon, 02 Oct 2017 09:44:55 +0900
In-Reply-To: <20170929094453.4499-2-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 29 Sep 2017 15:14:51 +0530")
Message-ID: <xmqqk20es7i0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9A252CC-A70A-11E7-9E3B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This step looks good to me.  Thanks.
