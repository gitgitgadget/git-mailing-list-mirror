Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3252070D
	for <e@80x24.org>; Thu,  7 Jul 2016 16:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbcGGQDW (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 12:03:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110AbcGGQDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 12:03:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8289828C1D;
	Thu,  7 Jul 2016 12:03:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2h8sYXHyQu7iseAlqGiPET6ZGGw=; b=ZkQRd7
	pkdsrXsrFIUF4pkrVjoR/jTS70Xec+6duA7DQprAp+LP5gz9iLqM19SL5Xdz2P0P
	zyz/NYRKhYwW0pOqhUhu2bP+fElznsWWrvHXaM47feaF496FmE/js01u8Nx/qZes
	a5s24AB4Y8DEnJnxRTQWqNNW/76WpuhhWea+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ErHfW9fd+GBmL/7q/pZlImo9XFT3lDL5
	iTBrN31IuIutUzC6690hnYRUTBEToCaics9uGnZ8wpnLt8S+3TR0j8QcSbZ3151L
	nEWSRvmfrhXQ45x56H9gIB3DU6heTnRRAnA2bRS5tbY4tc4fbjb6Rkxz6meXXpmf
	qbybSFogIw4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 797D228C1C;
	Thu,  7 Jul 2016 12:03:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFBA728C19;
	Thu,  7 Jul 2016 12:03:13 -0400 (EDT)
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
	<xmqqmvltqxjs.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607071753370.6426@virtualbox>
Date:	Thu, 07 Jul 2016 09:03:11 -0700
In-Reply-To: <alpine.DEB.2.20.1607071753370.6426@virtualbox> (Johannes
	Schindelin's message of "Thu, 7 Jul 2016 17:54:21 +0200 (CEST)")
Message-ID: <xmqqa8htqvuo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F5D1588-445C-11E6-9E9E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 7 Jul 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >> I doubt this kind fo distraction is desirable in the middle of a
>> >> seriously heavy series like this one.  As a standalone clean-up to
>> >> turn these directly to "their" that everybody would agree on and can
>> >> be merged down quickly to 'master' that does not have to keep the
>> >> body of the main topic waiting for the dust to settle might be a
>> >> better approach.
>> >>  ...
>> > I am really curious, though. Has it not been our practice to encourage
>> > preparatory patches like white-space or const fixes as part of patch
>> > series that touch a certain part of the code that needed fixing?
>> 
>> Yes, isn't that "preparatory clean-up" what I said "might be a
>> better approach"?
>
> What I meant by "preparatory clean-up" is a patch in the patch series,
> just as I had it.
>
> Now it is a separate patch "series".

The main thing I had trouble with was to have it in the middle at
11/17.  Since I do not have time to reorder other people's patches,
every time you reroll the main series, this step will need to be
looked at together with others.  Having it near the beginning as
preparatory clean-up, or even better a separate series that is an
uncontroversial preparatory clean-up that the main topic depends on,
is what I meant.

You build the main "series" on top of what 'master' would have when
the separate one that "does not have to keep the body of the main
topic waiting" gets merged.  Because the separate one would be
something "everybody would agree on and can be merged down quickly",
that will not slow the main topic down.


