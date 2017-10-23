Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F82202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 01:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbdJWBcS (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 21:32:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61248 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932171AbdJWBcR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 21:32:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3093DAB5CC;
        Sun, 22 Oct 2017 21:32:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7QEUhrzYV8PGyQ6cUXmP4qSVLjw=; b=ivD+Dm
        frbreGfp0wJZMDKr1+qkW+da+GmwCjiDvgtK8FkslyhGcYbLRqZ/BRH73kJU1SmC
        O6B18iW1LiLJoHQzM20VD8AoFrWLe5RS7ebaPAI58JUCgGf4XuYtqXpcksVDJXwi
        oiRVVgppXhb1ffG3sp6WgpjOx7gujKm6nYmt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EJot0R/80+wPt6k+T16A9CevxTgZEoID
        Ug4WtZOEgQRJbtF5PRD4X5K8xf9NYz9KJHNl1qd0CvCzB/f9lOj5gBeCQmSku2yp
        8ux+YA+77PmAPcLgAiIm3PsoVONLRY6H5H+dOE+HfEP13FHnLni1oImGSz1Wgc3u
        c0Dq1zEidWg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28967AB5CB;
        Sun, 22 Oct 2017 21:32:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A440AB5CA;
        Sun, 22 Oct 2017 21:32:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v3 0/3] deprecate git stash save
References: <20171019183304.26748-2-t.gummerer@gmail.com>
        <20171022170409.8565-1-t.gummerer@gmail.com>
Date:   Mon, 23 Oct 2017 10:32:15 +0900
In-Reply-To: <20171022170409.8565-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 22 Oct 2017 18:04:06 +0100")
Message-ID: <xmqqpo9ed4yo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00E947AA-B792-11E7-83FB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall the result looks reasonable and get us closer to the ideal
world where nobody recalls "stash save" has ever existed ;-)

Will queue; thanks.
