Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FE820179
	for <e@80x24.org>; Fri, 17 Jun 2016 16:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbcFQQkF (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:40:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751511AbcFQQkB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 12:40:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 052102468B;
	Fri, 17 Jun 2016 12:40:00 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PwsYtilO3FYYlpWO60pkVKkbp9E=; b=Gw2LRe
	YBxjPo0VgoaHhLU7SkUPinBUQqFIPBhC6vzwq68TEFShoupgnkzde090vbJNVqmE
	sNW7nLhr9HIevhSg3Iqgc8RaKMElP61h08dtOjx64FO7j27PMt9sFSbtwW5z6h66
	CFXnYQWPDdnrlnj0rnnvXytIEpElT7nDg5jfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dpBoy6Get9HVWK3RXPHS0HTNVaxukjnC
	OvH2B8V/wYGJMLty7GxeaAdLHQUWNonjCbv0gG5v8E4ET2vDB92SDJ9kSIPA1H9r
	CE+1R/UG7mzLXsw5dlRlnYJ2HlYocPnnvd70iCsaNVQP+x/GaJTDMZdMLF/WCkht
	70AallzJaeE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F17DE2468A;
	Fri, 17 Jun 2016 12:39:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7576124688;
	Fri, 17 Jun 2016 12:39:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Jeff King <peff@peff.net>, ZhenTian <loooseleaves@gmail.com>,
	git@vger.kernel.org
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
	<xmqqr3bx5ahp.fsf@gitster.mtv.corp.google.com>
	<171543e4-a343-c6d2-aa9a-2098db5b42ec@drmicha.warpmail.net>
Date:	Fri, 17 Jun 2016 09:39:57 -0700
In-Reply-To: <171543e4-a343-c6d2-aa9a-2098db5b42ec@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 17 Jun 2016 10:18:04 +0200")
Message-ID: <xmqq1t3v3h2a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21A4D26E-34AA-11E6-B91D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 16.06.2016 19:06:
>
>> I am not so imaginative, either. One remotely plausible use case may
>> be a project that has two classes of paths (let's call these classes
>> sensitive and others), and requires its participants to sign commits
>> that touch sensitive paths.  The user needs something finter grained
>> than per-project commit.gpgSign there.
>>  ...
>> So, I dunno, either.
>
> While I follow both of your lines of argumentation, I tend to claim that
> they imply: there is no reason to blindly sign any commit... We should
> dump that config :)

... no reason to blindly sign any commit IN SUCH A PROJECT that
wants you to selectively sign commits.

That does not lead to "we should dump that config" that all, does
it?
