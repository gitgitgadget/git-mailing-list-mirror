Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F031F89D
	for <e@80x24.org>; Mon, 24 Jul 2017 07:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbdGXHCa (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 03:02:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56544 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751832AbdGXHC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 03:02:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43A8A89B09;
        Mon, 24 Jul 2017 03:02:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wOvjHYdaMPdP
        Pw8xnm7uqLUW0go=; b=r0lmWQ3yfPQGLs4lMaAM7d6dvw2Z5v/Sf3EA5Pf6ncgo
        9R9JfgTa3m/06YQcNLzsqmh4a7XdSqm5TpSB7tjCGrfWFCIoVuRhZUyoUSewcQT/
        Sq4DxIV98+TKGidl8wVbg28y+qJD2AOKnljZRdOlepm01GiC3A7KwOpii8SGt/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eZiYGJ
        GkmQMulQmJ+2r624r1M8eWtsgwRDa5Srl1HKEaoLAnjqKsPS3ExaS8CEqpUG2IXz
        xJfnif/hTY6PSLHGY9+IDzM5R+gAtYqFt1+zomRwGWhuofcSAIeCCio1SCASbAxe
        fUdci/xYalmwJie+MRiVivkfR25y2NONCK8XY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39D7A89B06;
        Mon, 24 Jul 2017 03:02:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92C3089B05;
        Mon, 24 Jul 2017 03:02:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     lukaszgryglicki <lukaszgryglicki@o2.pl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] merge: add a --signoff flag.
References: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
        <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
        <FE86ED74-D646-4CA8-B931-26BC12B030CB@o2.pl>
Date:   Mon, 24 Jul 2017 00:02:26 -0700
In-Reply-To: <FE86ED74-D646-4CA8-B931-26BC12B030CB@o2.pl>
        (lukaszgryglicki@o2.pl's message of "Mon, 24 Jul 2017 08:14:01 +0200")
Message-ID: <xmqqk22ye2rh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D935D6A-703E-11E7-8F2E-61520C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lukaszgryglicki <lukaszgryglicki@o2.pl> writes:

> Hi, what is the state of this patch?

I was expecting you to respond to =C3=86var's <87tw2sbnyl.fsf@gmail.com>
to explain how your new version addresses his concerns, or him to
respond to your new patch to say that it addresses his concerns
adequately.  I think neither has happened, so the topic is still in
limbo, I guess...

