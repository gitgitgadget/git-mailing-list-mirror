Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B671F855
	for <e@80x24.org>; Thu,  4 Aug 2016 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934670AbcHDXcq (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 19:32:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965161AbcHDXcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 19:32:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47C3432097;
	Thu,  4 Aug 2016 19:32:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vg9dMbj4EEnTw6LuFKQdCRqDq04=; b=oMQJWR
	+5S7a+LCw9Mc4qTcqa+s0oyb+RXBWzIk+YsdekTPjwKEcyJyhaGXOLw9iqCkVZVG
	H1WBrpPk8Jp6zOADxG/V/cePfUa1KTDR6yNXhattSGQOSXvJ2xyrErcGlVaUWIZ6
	rt9gHQJu/dIOBVGx3oHnDS1OBRu5hUBmOt/6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vzw7r6XWZ85e6bD7jY6E8BY9u7jq3mMk
	gItBd61mfCVjeKQRzZyBkaVlDgy+WshdUcClBMLrJoejYXD535+0pby5hb1ouwIp
	UFfyFAS3s8MjeSu7RxLkB3RibQBnl1/9Yivb1LOpLvZiObx9C3Dyio+QFaVSVW0v
	OUy6NtlKQ6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 416C332096;
	Thu,  4 Aug 2016 19:32:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE68832095;
	Thu,  4 Aug 2016 19:32:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	<git@vger.kernel.org>, "Marc Branchaud" <marcnarc@xiplink.com>,
	"Jeff King" <peff@peff.net>, "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
	<62BF22F2A6654F5DBB84660A7E32CFBD@PhilipOakley>
Date:	Thu, 04 Aug 2016 16:32:28 -0700
In-Reply-To: <62BF22F2A6654F5DBB84660A7E32CFBD@PhilipOakley> (Philip Oakley's
	message of "Fri, 5 Aug 2016 00:10:03 +0100")
Message-ID: <xmqqbn18yusz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B66ED9BE-5A9B-11E6-92EF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> Updates in 4/8 ("give headings") is reported to break formatting?
>> cf. <57913C97.1030001@xiplink.com>
>
> Just to say I haven't forgotten.

OK.
