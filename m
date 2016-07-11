Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62711F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbcGKRv3 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:51:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754480AbcGKRv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:51:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B89BF2B506;
	Mon, 11 Jul 2016 13:51:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VL2+3R135gcXmW/scPgFK9Ul5bo=; b=EUN8fR
	/jGAD/x8P04rfG0tv6kutZZ7pfiezIqqcWPZaxoKiIh5XcbAxGwDnFjAsuJ0+ifo
	6rlEfDiFE171OkbChMiaRRbpz13IbqtdOTnkqooWSgjYOHuuQIsV1GOfzU9uquqd
	NxOjTF2J76zvflq9qWRU3sfEEwRbQTaX/XuCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cmClLN1/OYwqb4Z3a18Tjgxie+ZayYLt
	77zUB3p+SaJr2AgRYWgk6LYeOhTpJB8nsJab/NnQeUUKdMj0ZSktxvWVBOdZ43a/
	fZv+VJKZBET0EtfW6RBaJfZgTqwhzS1epxXB13QWezrIQ2NjDa9tiFS/pcbGD1cB
	p4mQ3p9Q/DM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B11A52B505;
	Mon, 11 Jul 2016 13:51:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 389AE2B502;
	Mon, 11 Jul 2016 13:51:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, Jacob Godserv <jacobgodserv@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christopher Layne <clayne@anodized.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Jul 2016, #03; Fri, 8)
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
	<20160709232503.GA8505@dcvr.yhbt.net>
Date:	Mon, 11 Jul 2016 10:51:25 -0700
In-Reply-To: <20160709232503.GA8505@dcvr.yhbt.net> (Eric Wong's message of
	"Sat, 9 Jul 2016 23:25:03 +0000")
Message-ID: <xmqqvb0c9i76.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1741C324-4790-11E6-9532-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> The following changes since commit cf4c2cfe52be5bd973a4838f73a35d3959ce2f43:
>
>   Second batch of topics for 2.10 (2016-06-27 10:07:08 -0700)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git master
>
> for you to fetch changes up to 2af7da9f8fb68337030630d88c19db512189babc:
>
>   git-svn: warn instead of dying when commit data is missing (2016-07-09 22:53:54 +0000)
>
> ----------------------------------------------------------------
> Christopher Layne (1):
>       git-svn: clone: Fail on missing url argument
>
> Eric Wong (1):
>       git-svn: warn instead of dying when commit data is missing
>
>  git-svn.perl    | 5 ++++-
>  perl/Git/SVN.pm | 8 ++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)

Thanks, pulled.

