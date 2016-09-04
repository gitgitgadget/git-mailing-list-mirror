Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5131FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 06:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbcIDGzP (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 02:55:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50779 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750729AbcIDGzO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 02:55:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46B572E3E2;
        Sun,  4 Sep 2016 02:54:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NN6/iOTN3//iNXGTXE3Omd9M1aA=; b=p6lUGB
        KQTN3otXj0uN4jbLA+ajucV28amOTYEqzWbZmyioRJA6mpUbPfwd/C5O2KpYO6bS
        ivnR8aS3y6M1p8jypXBDrbcyc0MapKf5khJjhi9hfa73NvVPx/YeOEXuffrLy521
        SbsBVObeAmV8TL/k0fjdwF7ViJY1TGKvcrATk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v3i/bo4u9zbMv3E/UY7sh/GHNx+1yzDE
        Yupr7JM6azk5eU/ieocDpWsyJVsBNOFLuXRsLbxUvmZ8dbTU5uA8wuWFKdIYJKP/
        8eaWyv4e/RriCbx4Afk4AJQLH5YFUq+PfUC2qD7uMLg6G6ijrHQPWLE4JamwUuHq
        uW3uc2yMsk0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B5612E3E1;
        Sun,  4 Sep 2016 02:54:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADF2C2E3E0;
        Sun,  4 Sep 2016 02:54:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Satoshi Yasushima <s.yasushima@gmail.com>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/6] git-gui: The term unified for remote in Japanese
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
Date:   Sat, 03 Sep 2016 23:54:36 -0700
In-Reply-To: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com> (Satoshi
        Yasushima's message of "Sat, 3 Sep 2016 23:43:37 +0900")
Message-ID: <xmqqh99wqhn7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72AB6D58-726C-11E6-838F-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Satoshi Yasushima <s.yasushima@gmail.com> writes:

> Signed-off-by: Satoshi Yasushima <s.yasushima@gmail.com>
> ---

I couldn't quite read/parse the title, but luckily I read Japanese ;-)

You saw different Japanese words used to translate the same original
word "remote" in different message strings, and you chose one of
them and use it everywhere.  And you did the same for "blame" in
your patch 2/6.

I would have described them like so:

  Subject: git-gui: consistently use the same word for "remote" in Japanese
  Subject: git-gui: consistently use the same word for "blame" in Japanese

Thanks.

