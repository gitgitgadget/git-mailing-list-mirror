Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9416E1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 02:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390685AbfJQCy3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 22:54:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55322 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbfJQCy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 22:54:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9AEF888B8;
        Wed, 16 Oct 2019 22:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x7n4hXnTNU4I6N/OsWXHOseberE=; b=fyS+dG
        /v+7WPdNRxrRmA96f/phwAc9Vv8fsvYVFus1QLZDTwL4L9c8Ka/933q98nDdvtkF
        bTWjUwI9bCDsDbpARepcyj7sdOvPei/XP2ftweGqUTA/dmoWh3/X4NflkPwb4YZn
        16lOAWNyikwY2qR2GCoBAB2lLopHRzPVVM7x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lK3BWUWiaTxPYJUt/3LubhuwXuppSMet
        P/dDqmOpTsyDCG333OFKHse1pGOimt3UTOkawro96bcmSUD1kjHJ/MuitupaNqVi
        1rGd2T5V26V/fdRtn1eW9YA92cDOvlzfvNKxiLrLi3EQ3OE+dmFi597gdYfLof4V
        MZ7D03qje14=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A148A888B7;
        Wed, 16 Oct 2019 22:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D53CA888B6;
        Wed, 16 Oct 2019 22:54:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>,
        GitList <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2] Doc: Bundle file usage
References: <7vzk4mj38g.fsf@alter.siamese.dyndns.org>
        <20191016095737.1588-1-philipoakley@iee.email>
        <20191016210957.GA28981@sigill.intra.peff.net>
Date:   Thu, 17 Oct 2019 11:54:23 +0900
In-Reply-To: <20191016210957.GA28981@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 16 Oct 2019 17:09:57 -0400")
Message-ID: <xmqqk19484kg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E0A831C-F089-11E9-BD24-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Maybe:
>
>   'git fetch', 'git pull', and 'git clone'
>
> ? Given the repetition below, though:

... including this one, I think you covered everything I wanted to
say on the patch already.  Thanks.

