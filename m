Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A784208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbdHJTjJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:39:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54013 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753270AbdHJTjI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:39:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75087938DA;
        Thu, 10 Aug 2017 15:39:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u+2LSqBuwMg/1ro6J1EU5ljwmeY=; b=jHJqo9
        9k0ek8cRcnLruNqqc7Z3ubXHIbEd9Nz1O8ynw27J8OztMTgbTxpeU8cYey9YdoZX
        ujVn8/8G4IUkITOW46nsuouO1kFawVNDd0SHKFPDm01qLDMCQKxz9Z8jMjF1wVFo
        Gc4X71eA2hdAcvGuhmKPjfpHV1+W0v7fzxYH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xGFVCsXw6YJHfbenSOd/d4bsqaweDWfi
        x8TlVyZo3xPj11h7f9Cx7cE1106w76u/yTAv3M7QsWYVPIjxlYz204sbz+j+5G03
        9FnRRDaO5F8CgKQTDXihRFnffyDYIRB9t4kG022FYSPS+JzUMWAj5twX6LhmwaLS
        TnO15Kf+n/4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BD93938D9;
        Thu, 10 Aug 2017 15:39:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAA46938D6;
        Thu, 10 Aug 2017 15:39:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH] t1200: remove t1200-tutorial.sh
References: <xmqqh8xh8fcb.fsf@gitster.mtv.corp.google.com>
        <20170809212253.27597-1-sbeller@google.com>
        <alpine.DEB.2.21.1.1708092334420.11175@virtualbox>
Date:   Thu, 10 Aug 2017 12:39:05 -0700
In-Reply-To: <alpine.DEB.2.21.1.1708092334420.11175@virtualbox> (Johannes
        Schindelin's message of "Wed, 9 Aug 2017 23:34:54 +0200 (CEST)")
Message-ID: <xmqqvalv2ox2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92A65372-7E03-11E7-BDE5-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 9 Aug 2017, Stefan Beller wrote:
>
>> v1.2.0~121 (New tutorial, 2006-01-22) rewrote the tutorial such that the
>> original intent of 2ae6c70674 (Adapt tutorial to cygwin and add test case,
>> 2005-10-13) to test the examples from the tutorial doesn't hold any more.
>> 
>> There are dedicated tests for the commands used, even "git whatchanged",
>> such that removing these tests doesn't seem like a reduction in test
>> coverage.
>> 
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> ACK,
> Dscho

Thanks, both.
Will queue.
