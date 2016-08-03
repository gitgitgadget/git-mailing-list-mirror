Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BEC41F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363AbcHCXQL (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:16:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932168AbcHCXQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:16:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 699FA329CF;
	Wed,  3 Aug 2016 19:14:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OvId4DZMH7NDtah5nBnj3vS2o3k=; b=o4VUnh
	ICEJAwQgRPX5prvcbm0Gbbd2lfCnRLbrguTykfgqxe86rYSUuB9AEmKbmOquCsGE
	0oyWMx7J5s9KUIfgNX9R3t9rRykmxUKwAUWoxPu0Pb2qO/UJmCBTcMLMsoZQyFTX
	bCUdgfWDJcsIN1w0rB/SpscuXY4Z1bk/hqT3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nP5LWeNd42lBznIApOECTWMqL8TOgHTf
	QwKJqKIpw8m5SmLjx84YkRJCYa4a0PmyaRVX+U2DZanM0ojHpTMduKvB9+l6xeg9
	oi94cNT6Wk3mgU7mblImyr/IJA0Nk5VIsYct2oaYrAJhVsJnG/DoYyLVxHh1xBM2
	QeM1n8y+amo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61CC2329CE;
	Wed,  3 Aug 2016 19:14:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8774329CC;
	Wed,  3 Aug 2016 19:14:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com
Subject: Re: [PATCHv4 6/7] submodule update: allow '.' for branch value
References: <20160803204404.3356-1-sbeller@google.com>
	<20160803204404.3356-3-sbeller@google.com>
Date:	Wed, 03 Aug 2016 16:14:35 -0700
In-Reply-To: <20160803204404.3356-3-sbeller@google.com> (Stefan Beller's
	message of "Wed, 3 Aug 2016 13:44:04 -0700")
Message-ID: <xmqq4m7178dg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BEE9310-59D0-11E6-8D68-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Gerrit has a "superproject subscription" feature[1], that triggers a
> commit in a superproject that is subscribed to its submodules.
> Conceptually this Gerrit feature can be done on the client side with
> Git via (except for raciness, error handling etc):

This would replace 7/7 not 6/7 obviously ;-)

Thanks.
