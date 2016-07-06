Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28582070C
	for <e@80x24.org>; Wed,  6 Jul 2016 17:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336AbcGFR5L (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 13:57:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754981AbcGFR5J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 13:57:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A62A282C9;
	Wed,  6 Jul 2016 13:56:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fQpyRZw/zG/B
	T2kW1wcuRwuuTUQ=; b=XcL3Dl40Ll3Ic1EABBnl0e7rbIZTAzlzS4Ecebh2pikQ
	OYfrx/H5eRvCWp6Uu2++gBEd+qskH8jV5828G8es6grkIxX78gjIWnGvEwmO/UqF
	C3UeX75REJ8djttVIZ0QuSjJZezBXupNo9YfeoM4sh311ohu1UYzBmbJpHF5RHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=askZq0
	/HYhKoxh0ntIBu/fEDByWPgA1GunP1qc491tbP7yEUoiAQewPAChdOD1miTI5X9Y
	JzC5UXfjwWg21da80W8N5wKxMrZB7P5cb/rTSlDfz9zBMNNTAenr/9fkTme1dYXV
	jqt7cfsI3+SN3h5VJIA9W1YRydvKdOvX4n9QA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 31CD9282C7;
	Wed,  6 Jul 2016 13:56:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF4EF282C6;
	Wed,  6 Jul 2016 13:56:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	David Turner <novalis@novalis.org>
Cc:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Subject: Re: [PATCH v14 21/21] mailmap: use main email address for dturner
References: <1467612324-23556-1-git-send-email-novalis@novalis.org>
	<1467612324-23556-2-git-send-email-novalis@novalis.org>
Date:	Wed, 06 Jul 2016 10:56:16 -0700
In-Reply-To: <1467612324-23556-2-git-send-email-novalis@novalis.org> (David
	Turner's message of "Mon, 4 Jul 2016 02:05:24 -0400")
Message-ID: <xmqq4m82tzun.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F0EE24BA-43A2-11E6-ACA1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> Signed-off-by: David Turner <novalis@novalis.org>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index e5b4126..edcae89 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -46,6 +46,7 @@ David D. Kilzer <ddkilzer@kilzer.net>
>  David Kågedal <davidk@lysator.liu.se>
>  David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
>  David S. Miller <davem@davemloft.net>
> +David Turner <novalis@novalis.org> <dturner@twopensource.com>
>  Deskin Miller <deskinm@umich.edu>
>  Dirk Süsserott <newsletter@dirk.my1.cc>
>  Eric Blake <eblake@redhat.com> <ebb9@byu.net>

Let me take this separately and directly to the 'master', not as
part of this series.

Not that I am rejecting the remainder of the series, though.

Thanks.
