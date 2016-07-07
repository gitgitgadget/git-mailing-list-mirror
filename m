Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A975D2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 15:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbcGGP0h (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 11:26:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752896AbcGGP0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 11:26:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 711D428659;
	Thu,  7 Jul 2016 11:26:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6bP6/vK61u4+ZPSl46GUqCXNSUw=; b=mllTKw
	mONmuSZ93AniCuY0DEVOWEDr51NzNXigca2iUGngum9fQq9teJtrq4qH7L0Ie2JD
	gvdgVuxKuenk1akOYdCOa80tCb9BXqe5K/hBDhMQfUHYDpCLKtfnr3gCK/bq8x9t
	H7KhfmyozCUj2zYIYdO4VUhRKKPzUxLbjBYQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lrn/wEx9JFt9WHGFp4owag1zyxWwpT2A
	8iatb3MI7AKz/IvRI1x7eNIy0x7a42IPRo24ZFjRpJqpDsdlX6I6tuHNlTBGrzP/
	XTTJunZ63/nv3296xBFT3OijlcCoHPc915QPPFDUYrOWZZVeo0qpgH1ffpwhHTGE
	UBuQmdVyqyA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6664A28658;
	Thu,  7 Jul 2016 11:26:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5CE028656;
	Thu,  7 Jul 2016 11:26:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/17] am: counteract gender bias
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<cover.1467717729.git.johannes.schindelin@gmx.de>
	<ea23faf258b6e62e770879362869f49eea4db869.1467717730.git.johannes.schindelin@gmx.de>
	<xmqq1t36sbqt.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607071323440.6426@virtualbox>
Date:	Thu, 07 Jul 2016 08:26:31 -0700
In-Reply-To: <alpine.DEB.2.20.1607071323440.6426@virtualbox> (Johannes
	Schindelin's message of "Thu, 7 Jul 2016 13:30:36 +0200 (CEST)")
Message-ID: <xmqqmvltqxjs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30001EE2-4457-11E6-B51F-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I doubt this kind fo distraction is desirable in the middle of a
>> seriously heavy series like this one.  As a standalone clean-up to
>> turn these directly to "their" that everybody would agree on and can
>> be merged down quickly to 'master' that does not have to keep the
>> body of the main topic waiting for the dust to settle might be a
>> better approach.
>>  ...
> I am really curious, though. Has it not been our practice to encourage
> preparatory patches like white-space or const fixes as part of patch
> series that touch a certain part of the code that needed fixing?

Yes, isn't that "preparatory clean-up" what I said "might be a
better approach"?
