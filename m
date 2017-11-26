Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5BA20954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdKZDtL (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:49:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61398 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752028AbdKZDtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:49:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B01E9F755;
        Sat, 25 Nov 2017 22:49:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ClPGMhVEQ2nwvPN7Qux2vynPoiU=; b=Q94kXo
        BqbJRBjUcx7xPav/n0AnqJH8qSkY2YWXIbK04LPAQAm/3BsJpGmauvGK25+UXqj0
        lt3KUK9zbhHTNLdAUulMAIkIv6wVAbxNIDO/ACXIEusQx0PrwwdLsemVSl9zil54
        fyWeCtujKhoPCvQHzerpsHXEh8IFU0cK3Wfuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lKjSxNzEbR5W1OmmHUp17KgX/5q3+JlP
        AzhwRh0RvNpBPsSGx3KO538V7qFHq78MnzTH0X+CYbaP/uiJrWDvuTYI2Affkxz5
        KFV6xEOWlam257PTOkifcOmCLXRcfeOuoGxed11ZGurQb/c8T14bZeMyndWX7SG5
        bBkUqz8hZiU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F3B9F754;
        Sat, 25 Nov 2017 22:49:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B86E59F753;
        Sat, 25 Nov 2017 22:49:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes: minor typo fixes in 2.15.1 draft
References: <20171125173345.17488-1-tmz@pobox.com>
        <20171125180243.GV3693@zaya.teonanacatl.net>
Date:   Sun, 26 Nov 2017 12:49:08 +0900
In-Reply-To: <20171125180243.GV3693@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Sat, 25 Nov 2017 13:02:44 -0500")
Message-ID: <xmqqk1yditsb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C25B61E0-D25C-11E7-B0BD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> It was mildly surprising that the script didn't warn or complain about
> an unknown option.  After a quick look, that seems to be due to the
> Getopt::Long pass_through option which sends unknown options to
> format-patch.

Heh, that is another reason why I recommend against letting
send-email run format-patch from within (another a lot bigger one is
that running them seprately gives you a chance to look and proofread
the output from format-patch one more time before actually sending
them out, which also allows you to update additional comments after
the three-dash lines).

