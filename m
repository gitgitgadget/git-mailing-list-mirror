Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC792034E
	for <e@80x24.org>; Wed, 20 Jul 2016 22:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbcGTWWI (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 18:22:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751656AbcGTWWH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 18:22:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60C372E364;
	Wed, 20 Jul 2016 18:22:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U0m2jthwPS5nUovZJylXk/Dh56M=; b=W36FWe
	8F7UWKsFxoGeuGSjnPJt6JdbVJCbGJZ8C0mOqGj+rJdq4wPD6Ab/hk4ZQH9glVVG
	xTChkwWuL4c+gubCq/9G5KubV9Z9Ah7WGiKF+b6I5fuANz49hR5WSSc/uLwzcs7j
	KZD6Jz4Gv88ulBisz7w6fiFDskRK99PxdtR3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MHfrdZLK9IOXMxylkswtVNW+0zZHtH9L
	nzJ4Wi/YYosm2C50z/rVTo2Q1ieYS/MCNBe8/UwG4tPYsxMUa0TuOLjid/qL9sSo
	9MpZrUdo/H7VXLCllePX4OYR/Pyg+5rscQij37olfZEX81FN81IgpOFnq2eLG5y+
	zmffw600uC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58C132E360;
	Wed, 20 Jul 2016 18:22:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D95112E35F;
	Wed, 20 Jul 2016 18:22:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 0/8] Name for A..B ranges?
References: <20160711202518.532-1-philipoakley@iee.org>
	<20160720211007.5520-1-philipoakley@iee.org>
Date:	Wed, 20 Jul 2016 15:22:02 -0700
In-Reply-To: <20160720211007.5520-1-philipoakley@iee.org> (Philip Oakley's
	message of "Wed, 20 Jul 2016 22:09:59 +0100")
Message-ID: <xmqq4m7kc5md.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 635FE2D8-4EC8-11E6-AB69-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> No change in the number of patches. Interdiff below.
>
> The patches carefully tease out the clarification of
> reachability. Reachability is defined relative the ancestry chain thus
> (hopefully) avoiding misunderstandings.
>
> The final patch updates the summary examples, and the tricky (for the
> untutored reader) two dots case of a linear development where r1..r2
> excludes r1 itself.

All looked sensible and each focused on a single issue and fixing it
well.  Done very nicely.

Thanks.  Will (re)queue, wait for a few days for further comments
and let's merge it to 'next'.

