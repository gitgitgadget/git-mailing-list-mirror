Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5798C20969
	for <e@80x24.org>; Mon, 27 Mar 2017 20:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbdC0Uo7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 16:44:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56912 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752215AbdC0Uo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 16:44:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36D5282BF6;
        Mon, 27 Mar 2017 16:44:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9ZOqfhuMj4YxiqMMPewj2oTfypU=; b=Udblf9
        dZXo1gIMyWeTYDhsWZ23mAOk8ml53NqGIJrkdGnSOeiIRPYQig84HTYFRK+6osX4
        S9Clzp2C2DVJGimo0nbZUSEhJU+2LAC7wQjaPOdil8I2EqKq5DGP/AOW7ppRGCX7
        AgMSSvLszyn5eTkn1d+wtWJ1nd+qLTilldbSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g2FRewujfWihrDuIL4rlcMizOrNN1pWP
        EhbGL78ZX+w5uIyDEV4mTKBTjzjSmWGZ0VzMwQ7NeJGX2mO6Zmr3P//hTiGZqJbT
        kKP6ZNW9mwafnE7B7Tq7oXZoSjtPge34JGzl+OzghJuB5QvNHHmOCl/0kpUq6BfU
        1Sr1KMwb18I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F8B182BF5;
        Mon, 27 Mar 2017 16:44:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9402082BF4;
        Mon, 27 Mar 2017 16:44:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH v2 0/2] describe: localize debug output
References: <xmqqpohf7opl.fsf@gitster.mtv.corp.google.com>
        <cover.1490633145.git.git@grubix.eu>
Date:   Mon, 27 Mar 2017 13:44:42 -0700
In-Reply-To: <cover.1490633145.git.git@grubix.eu> (Michael J. Gruber's message
        of "Mon, 27 Mar 2017 18:50:04 +0200")
Message-ID: <xmqq4lye1mbp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34F809E0-132E-11E7-802A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> v2 computes the width for the localized output dynamically.
> In fact, it might overcalculated a bit depending on the encoding,
> but this does not do any harm.

Thanks.

As you said, if we wanted to actually _align_, then it needs much
more work.  But that is not what we are aiming for in this round,
it should be alright.

