Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9043E20986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbcJDQPf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:15:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57334 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752915AbcJDQPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:15:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91DF041922;
        Tue,  4 Oct 2016 12:15:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VFYqTAwmtenOLv9+WTR8TmqsOaQ=; b=TColpe
        ZzQJyzh1UhcRdp2nRy3P7NbRYsYyl73jC+8NjmP5orha+M3Rbj7zSa3hllGrPMRk
        NC3+ZnhTXjkVB6a4QYb4CpBIauOFpQsQZQuM3r8E0oERWVhoynVLsFNv9rd72xcg
        07ISvMf5fk6d3uPoVo9SUlrcnWc8cZnAQ2YXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F+b/gdKBQFJReTIl9h00AlD16jcRxOd/
        pK5qNsTa7jrUXnMVQ7LbzlRbxg03nPzDjHrNRMaRqMX2EATCytEHjQBFgquPugv6
        +1Nj2CIwMGg2lDF/+Z0upvYWFm+CagpGbyvEgtVVZQDRPlqYK/p0UCg2xO2dfVQi
        FlO+XyRlABQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 821DA41921;
        Tue,  4 Oct 2016 12:15:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8EB041920;
        Tue,  4 Oct 2016 12:15:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
References: <20160928114348.1470-1-pclouds@gmail.com>
        <20160928114348.1470-2-pclouds@gmail.com>
        <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
        <CACsJy8D28iq3r3O_uzjyyJT--KQunAySRgUthF3FMrb1VM6XKw@mail.gmail.com>
Date:   Tue, 04 Oct 2016 09:15:30 -0700
In-Reply-To: <CACsJy8D28iq3r3O_uzjyyJT--KQunAySRgUthF3FMrb1VM6XKw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 3 Oct 2016 17:36:28 +0700")
Message-ID: <xmqqd1jgw0nx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C68432C2-8A4D-11E6-BC12-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> We don't use it internally _yet_. I need to go through all the
> external diff code and see --shift-ita should be there. The end goal
> is still changing the default behavior and getting rid of --shift-ita,

I do not agree with that endgame, and quite honestly I do not want
to waste time reviewing such a series.
