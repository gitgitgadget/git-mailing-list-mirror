Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F04620193
	for <e@80x24.org>; Fri, 28 Oct 2016 02:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbcJ1CyK (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 22:54:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51250 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751207AbcJ1CyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 22:54:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E98884B234;
        Thu, 27 Oct 2016 22:54:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JJ5rnT62/vwA4ULqgQLVL42MDA4=; b=u1eHh6
        YJQXeGRhufQFvS4jCrIvm0KvvUVK2TNNh+TwjPTHG5MIO5RsD6pSRZa1FpSC5EyO
        gZP8FF4SZFlddfGGX3EiZ5dmPCMma3QKD2f/J+OD/gHQhiIHE3KaDBxX2jhS5RRr
        YdV5qJDvfCRL0U2BRPZJphOPth7wtlrOFTcdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZC2f5+9ncLX5BYscZ8uytz9hK4Ftgs48
        HG4enCx8dwRyB5Gscq79XKYJ1brW/CsKQEz/OEo3a7JTn1KY+StC0XyjZwCePEAn
        r+f5RtQdV1SL6RJD17m/jsvR8qJ9/jQGb2Mg1IMRVFTgCBq1r/W0wZrrRgdZqG2t
        /uFyouqT30o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0F894B233;
        Thu, 27 Oct 2016 22:54:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C4194B231;
        Thu, 27 Oct 2016 22:54:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Aaron Pelly <aaron@pelly.co>, git@vger.kernel.org
Subject: Re: Expanding Includes in .gitignore
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
        <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
        <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
        <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
        <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
Date:   Thu, 27 Oct 2016 19:54:05 -0700
In-Reply-To: <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 27 Oct 2016 17:07:53 -0400")
Message-ID: <xmqqwpgt2ng2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB3B5916-9CB9-11E6-8D22-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, as I said elsewhere, I'm not convinced this feature is all that
> helpful for in-repository .gitignore files, and I think it does
> introduce compatibility complications. People with older git will not
> respect your .gitignore.d files. Whereas $GIT_DIR/info is purely a local
> matter.

As I do not see the point of making in-tree .gitignore to a forest
of .gitignore.d/ at all, compatibility complications is not worth
even thinking about, I would have to say.

Thanks.



