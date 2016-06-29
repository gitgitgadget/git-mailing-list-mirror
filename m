Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10F620FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 18:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbcF2SHT (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 14:07:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752497AbcF2SGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 14:06:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E88E726558;
	Wed, 29 Jun 2016 14:06:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O18Hjacif3tdTePvekDhXTC9Bro=; b=sRLhOx
	Sq7PkMqskPk2UJDtANdetBkC7i0rgyjxqCrMDLr54MSj2PQGo35d4v4LkQOpUg/A
	ttSWB+tpbYJrMKN7TpCgISktvCFHLZ/xyAeeWz0Zr4+1RR1Y/GTJFITD56VzGch5
	Y4+5dYlTtg9BnpLlYD41gfXWj9wCchGF5mXGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RFjouHRX3OX6EMJ5eB1l0dA5H6GpwPSV
	Q6NbTd4DGg5tiQWUTfriNgVgRVVyW6M2rUYDtPvckN9LXCFDZl1qbrSknrdkw9Vh
	HBXmNv1KVjXYoKOFFweakMgqY43la0/CibASHB7gYCJWcMVywVBLfoemwopZHeLQ
	pNRpJtDB66A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF79826556;
	Wed, 29 Jun 2016 14:06:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6751826555;
	Wed, 29 Jun 2016 14:06:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/2] t3404: fix another typo
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
	<2ad336745e1b2a610b20b7cfba169bd3e042c178.1467210629.git.johannes.schindelin@gmx.de>
	<xmqqlh1o584u.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606291729200.12947@virtualbox>
Date:	Wed, 29 Jun 2016 11:06:48 -0700
In-Reply-To: <alpine.DEB.2.20.1606291729200.12947@virtualbox> (Johannes
	Schindelin's message of "Wed, 29 Jun 2016 17:31:17 +0200 (CEST)")
Message-ID: <xmqqh9cb50p3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40908DC0-3E24-11E6-B78A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 29 Jun 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > The past tense of "to run" is "run", not "ran".
>> 
>> Actually, past tense of the verb "to run" is "ran" ;-) The reason
>> why this patch is still correct is because this is writing in
>> passive voice, where you want "be + past participle", and the past
>> participle of the verb "to run" is "run".
>
> Embarrassing! ;-)
>
> Well, I shall fix up the commit message thusly:
>
>     t3404: fix another typo
>
>     The passive form of "to run" is "run", not "ran".

If your convention of referring to a verb is to show its infinitive
form, i.e. "to run", then you would probably want to say

	The passive from of "to run" is "to be run", not "to be
	ran".

But I think we do not need any of this if we just retitled it to

	Subject: t3404: fix a grammo (commands are ran -> commands are run)

without any body.



