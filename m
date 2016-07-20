Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E7E1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbcGTUuz (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:50:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752722AbcGTUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:50:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD4472D565;
	Wed, 20 Jul 2016 16:50:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gZcsbpaRJ8hAcptNgTqckuka/oc=; b=dJIQc4
	Hv5AvBATSmQtlDn/x6rvs3dDFdO3O9bWBxU1+D7hd/EJP8mblcwEMq31hiVOupov
	VoE4d46x2mJEOR6ijguBb13IoFmNtrywhLJwZwBYbgsdBVpUNSOF660TpC7Y3L2M
	GOKcxOCHr6gGioliKzAEwMy44BKErtIT88p+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YXPn+C6/qF6xxPuezU17yNepfVRIXcDU
	FSssTCAWTXAJTUMk98vHH8sci3r6GJ/+pmg8ra5Yb+k0inz8PXCJIxs1iq1XMMrG
	bo3+kKOmJylegBSOCiTSNeagrhZhqC7PCc16sDlhkqYJDMrXGcn/f9YjlEq/CIc4
	QpJHPRT26rA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D428C2D564;
	Wed, 20 Jul 2016 16:50:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C5892D563;
	Wed, 20 Jul 2016 16:50:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v1 3/6] Per-file output for Porcelain Status V2
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
	<1468966258-11191-4-git-send-email-jeffhost@microsoft.com>
Date:	Wed, 20 Jul 2016 13:50:50 -0700
In-Reply-To: <1468966258-11191-4-git-send-email-jeffhost@microsoft.com> (Jeff
	Hostetler's message of "Tue, 19 Jul 2016 18:10:55 -0400")
Message-ID: <xmqqoa5sc9ud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5804912-4EBB-11E6-B9CB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

Just to avoid later headaches...  please look at your commit titles
and imagine how they will look when listed among 400+ other changes
when they are included in a future release in "git shortlog" output.

> Subject: Re: [PATCH v1 3/6] Per-file output for Porcelain Status V2

Subject: status: per-file output for --porcelain=v2

or something like that, perhaps?

> This commit sets up version 2 porcelain status and
> defines the format of detail lines.  This includes
> the usual XY and pathname fields.  It adds the various
> file modes and SHAs and the rename score.  For regular
> entries these values reflect the head, index and
> worktree. For unmerged entries these values reflect
> the stage 1, 2, and 3 values.

Also, we usually do not say "This commit does this and that".

See Documentation/SubmittingPatches for more details regarding the
above two points (and more).

