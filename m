Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392FA1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 17:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbcFPRGr (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 13:06:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754839AbcFPRGq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 13:06:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BA10723CAC;
	Thu, 16 Jun 2016 13:06:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JNCfh9h0to+2HD/TFh3psJa68d0=; b=kuHrbl
	x5c6E/Wkyd2cmzuZfy+mjEGJboibsPD6Htg+niDICL2i+UBdKkd1CB947MuywXYx
	pWTFkWxx8w9buRtGoos51f4xXte2drnnXDe3xRpNR3uPWUficCXVN+c22Iuo026I
	9pFN0+9Tffd9EY3iv0RdNIrlzpBOKPG5Hxlqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VRuL1pPKi4b1FJ4VIFAU5NsrX6udfC5W
	OIh+Mlu/kCcrHia8VnLyxZBxixk+M0bDlkiOWahUSyoEqfVZNWwRoSXSi+EyDH/v
	J1P7U6JsXD1vhuAC6BHaLDVGQZ6gRQda8n0KPOBpugR6KBp91heZGmCwmRAQZCVh
	YLs6+8KVKGc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B28B823CAB;
	Thu, 16 Jun 2016 13:06:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B3B623CAA;
	Thu, 16 Jun 2016 13:06:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	ZhenTian <loooseleaves@gmail.com>, git@vger.kernel.org
Subject: Re: I lost my commit signature
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
	<20160614075824.GB12563@sigill.intra.peff.net>
	<CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
	<20160614081854.GA13457@sigill.intra.peff.net>
	<CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
	<20160614094121.GA13971@sigill.intra.peff.net>
	<e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
	<CAGrdoOoxphU0tRjV22yduXrhmOSyCc_zVnhuO9fFA6UPRd9WiA@mail.gmail.com>
	<20160615043450.GA3975@sigill.intra.peff.net>
	<be771366-00a7-6c20-2623-5fa54b8e19b7@drmicha.warpmail.net>
	<20160616073410.GA651@sigill.intra.peff.net>
Date:	Thu, 16 Jun 2016 10:06:42 -0700
In-Reply-To: <20160616073410.GA651@sigill.intra.peff.net> (Jeff King's message
	of "Thu, 16 Jun 2016 03:34:10 -0400")
Message-ID: <xmqqr3bx5ahp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3BE43D6-33E4-11E6-A360-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But why does somebody run "commit -S" for a single commit, but not all
> the time? Is it because that commit is special? Or is that particular
> moment special? One implies that it's important for the signature to be
> retained during a rebase, and one does not.
>
> So I dunno. I would not be opposed to such a feature, but I'm having
> trouble figuring out why it would be useful (though for the most part, I
> do not see why anything but per-project commit.gpgSign config is
> particularly useful. Maybe I just lack imagination).

I am not so imaginative, either. One remotely plausible use case may
be a project that has two classes of paths (let's call these classes
sensitive and others), and requires its participants to sign commits
that touch sensitive paths.  The user needs something finter grained
than per-project commit.gpgSign there.

But even in such a case, the fact that an original commit is with a
signature should not be a good indication that the rewritten version
of that commit in the new history still touches the sensitive paths
that required the original to be signed (i.e. the history the user
is rebasing onto may already have the necessary changes to these
paths).

So, I dunno, either.
