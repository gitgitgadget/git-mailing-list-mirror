Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B4D2036B
	for <e@80x24.org>; Wed,  4 Oct 2017 04:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdJDEFG (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 00:05:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56123 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750779AbdJDEFF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 00:05:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7928994F61;
        Wed,  4 Oct 2017 00:05:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7vueu4iv/uBNcjnChDFtua+M88s=; b=nfoDne
        PaNMgqrOyBBnJmZwdLxRQfZ6fzPqIuBxq2Z7LwnNEjoMNSDl+KPt6ZSYgs6zB5Kf
        4TkiDLZBBvmT2mgs4ZODAjUH9CfxubeArQD28wv0pI+8ZzGHwCqghSK/821w5tCF
        zmUTHgasfHqYPPjFrupWB99Q9Lb+XAwYffFpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LkVJzIB59YINwM/La4wyBNY8pPBnSzgu
        faTctaXjDVBD3QrQBbrWzaUq4WuKhX/ZzhcaCE/gUKZfaQc0Cj5x/cgerhkJogwQ
        hgKq6LdOFSHQr6oQqgq7Ipj6jdHvG4JwPBlmFh89q56JY8xlnxD1vpV5AFEtVNEp
        /44LXuk8UsY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4769B94F60;
        Wed,  4 Oct 2017 00:05:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 273F694F59;
        Wed,  4 Oct 2017 00:05:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nathan PAYRE <second.payre@gmail.com>
Cc:     git@vger.kernel.org, matthieu.moy@univ-lyon1.fr,
        timothee.albertin@etu.univ-lyon1.fr,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr
Subject: Re: new contributors presentation
References: <CAGb4CBUrozoz9iS5pd57VrnV2e6jkSn7N=POdeUFSkvvpPDSZg@mail.gmail.com>
Date:   Wed, 04 Oct 2017 13:05:00 +0900
In-Reply-To: <CAGb4CBUrozoz9iS5pd57VrnV2e6jkSn7N=POdeUFSkvvpPDSZg@mail.gmail.com>
        (Nathan PAYRE's message of "Mon, 2 Oct 2017 13:43:59 +0200")
Message-ID: <xmqq60bvfthv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32BDB5E6-A8B9-11E7-937E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nathan PAYRE <second.payre@gmail.com> writes:

> Hi all,
> me and my two other partner (Daniel and Timothee) have make the choice
> to contribute to gitHub for a university project supervised by Mattieu
> Moy.

First things first.  I suspect that you are trying to contribute to
the Git project (GitHub is totally a different animal, even though
they benefit greatly from our presence, and we theirs).

And if you are dipping your toes to the Git project's development
community, then, "Welcome!" ;-).

> The principal project is to improve the git-send-email function, for
> example we will try to implement the possibility to answer to a email
> by keeping the recipient list or quote properly the email body!
> Do you think that it's will be usefull ?

I do not know about others, but I cannot quite tell what you are
propsing from that three-line description to tell if it would be
useful or not.  Let's wait to hear more from you guys.
