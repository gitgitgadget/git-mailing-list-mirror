Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6BC1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 18:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbcHQSgV (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 14:36:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752652AbcHQSgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 14:36:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A22F3660E;
	Wed, 17 Aug 2016 14:36:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P6rUvp/Vj3HvSPdeH61Lc/XAACs=; b=RTPa5d
	Wby0XObwLC7Cw6HxVmbGguw8aFWtXPmfuDD6doFQQlg/QIC/jzKiOHT1IMgTGr9V
	ZdABuwyQVMkxfzHJHfK3wXuizNyLHg5oU+y6jswJxuORhDOZsUPH0W0XazkuFh3n
	WAKYQpJwGvAsepaB7lMBqLnH7qHIRWF3aii6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jPA4ECaz2jCIrqC+cx2L3oWIiu5N9NkS
	em3iBgeTJPplRbHLxe39oRY5uR9q7WrieGafJNRAieKd/oEiNVdZUmA2TahkG9CU
	MtJFJ8HxNn0qJzlrFtjHyj/5MVBwJqI48ZrIPfqqS8uZxFiVNj7oncmirE6Kiswg
	sbUIW1cVOhc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FFEF3660D;
	Wed, 17 Aug 2016 14:36:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D52B3660C;
	Wed, 17 Aug 2016 14:36:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-multimail: update to release 1.4.0
References: <20160817064116.18399-1-Matthieu.Moy@imag.fr>
Date:	Wed, 17 Aug 2016 11:36:17 -0700
In-Reply-To: <20160817064116.18399-1-Matthieu.Moy@imag.fr> (Matthieu Moy's
	message of "Wed, 17 Aug 2016 08:41:16 +0200")
Message-ID: <xmqq4m6j9ra6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D586452-64A9-11E6-8800-E86612518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks.  Will directly take it to 'master'.
