Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D2D1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 19:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbcGLT3s (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 15:29:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751193AbcGLT3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 15:29:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C73872A807;
	Tue, 12 Jul 2016 15:29:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ITFG2AwRmn5tHD6xECpGiR5Cstk=; b=jKthwk
	/bbxM8s41K58GF/lJnVXRzcV5FjaL+uMsJd0CHgWH4eNzKw+bYTcKemxMDZ2Ebld
	8DQ8aCXokZkcrpQevej6FIyHgNiWX5/HrbAcLxBhlpZKt6d2Ji0MS/0IZuUWySzo
	p7iDYulvH6kZj+7oZWqOnpWvqU0jUkixp90sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K8tJj+tKtq8aB62mbkYq3KZtFp2CSLBn
	CSpNgH6iSJD4CZ0MgjFtGXYvtVxxvWycS8vL06wqoKny7aeTWLgdiAms7QvrmR3z
	zawVlLtHsV6tiPQDVpo7nwK+bsK8qnyzqS6AnsNDuUE8Er0tsQocQfBkQ1Y/pMbG
	bWp+Fn17Vrs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFABE2A806;
	Tue, 12 Jul 2016 15:29:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46CD12A805;
	Tue, 12 Jul 2016 15:29:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] Name for A..B ranges?
References: <20160630202509.4472-1-philipoakley@iee.org>
	<20160711202518.532-1-philipoakley@iee.org>
Date:	Tue, 12 Jul 2016 12:29:44 -0700
In-Reply-To: <20160711202518.532-1-philipoakley@iee.org> (Philip Oakley's
	message of "Mon, 11 Jul 2016 21:25:10 +0100")
Message-ID: <xmqqinwa4puf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDC85F3E-4866-11E6-99B8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> This is the re-roll of the po/range-doc (2016-07-01) 3 commits and its
> follow on patch.
>
> The series has gained additional patches following the discussions
> ($gmane/298790).
>
> The original first 3 patches are unchanged, though 2/8 has been inserted
> to name the Left and Right ranges.
>
> The extra four patches carefully tease out the clarification of
> reachability. Reachability is defined relative the ancestry chain thus
> (hopefully) avoiding misunderstandings.
>
> The final patch updates the summary examples, and the tricky (for the
> untutored reader) two dots case of a linear development where r1..r2
> excludes r1 itself.
>
> The patches can be squashed together if required.

Looked mostly sensible, except for a few things mentioned in the
reviews by Marc (to which I mostly agree with).

Thanks.

