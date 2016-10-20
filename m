Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856301F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbcJTSFX (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:05:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58971 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754453AbcJTSFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:05:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C463A472E9;
        Thu, 20 Oct 2016 14:05:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WoZKqySJFsmPq571bX5xFDbvQJE=; b=pwj4LZ
        CJRje9rZBaz2qh283C8pYOX/Yt0L/Ro0Nxq37xUtO89wl0swQqH82wlgPkXzEDl1
        JdDbZixS7dKGyftMY6nseUDCgHC70fRG4xSDi5UVORCdCfaJm0xeiJpQ3mN/JinJ
        I3RbskkRuMBCV/DhOU9PwWf2VvUMqJ9Zdg0TM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lglvyuRXokVHc+YYfqSX/c2Sq3fnJ2Pm
        c+jQ5EMEGPm47mDf5EqOKA6wePGv5EF46KJITenPRzbB0rMxUUeEzkxIRr6qtxbP
        CBl2BJ2ystFcm70+G/5ezIJm0VvDard8y8m9O+w6BzsiK8gK1mFLma43Zn2yhBkV
        OrcQssDvqZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB2FA472E7;
        Thu, 20 Oct 2016 14:05:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D6C0472E6;
        Thu, 20 Oct 2016 14:05:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
References: <580893d5a4736_4ed37b53181837@ss1435.mail>
        <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
        <xmqqshrqhpua.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYTwsWy+oxnPKghWKGLEaO9qWZbrQOOejeEBOe0c-o0Pg@mail.gmail.com>
Date:   Thu, 20 Oct 2016 11:05:17 -0700
In-Reply-To: <CAGZ79kYTwsWy+oxnPKghWKGLEaO9qWZbrQOOejeEBOe0c-o0Pg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 20 Oct 2016 10:58:39 -0700")
Message-ID: <xmqqoa2ehp5u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2E6F1C8-96EF-11E6-8C5F-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I do it most of the time, but I did not start managing it.
> And I have been pretty lax/liberal about handing out rights to do stuff,
> because I did not want to tip on anyone's toes giving to few rights
> and thereby annoying them.

Good to know that you have been managing it; I was mostly worried
about not having anybody managing it (i.e. imagining Coverity
nominated/volunteered me as manager with everybody else as viewers)
and the new viewer requests get totally ignored by the project as
the whole.

> I see that some of these emails may be inconvenient to you, I can
> change your role to defect viewer/contributor if you prefer.

It is not a huge inconvenience to me, because any piece of e-mail
that is addressed directly to gitster@ without CC'ing to git@vger
and is not a follow-up to any earlier message goes to a separate
lowest-priority mailbox that I rarely look at.  But if it is easy
to recategorize me, please do so.

Thanks.
