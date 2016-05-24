From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix link to parent diff with pathinfo
Date: Tue, 24 May 2016 11:39:11 -0700
Message-ID: <xmqqtwhn47xs.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvo225fg.fsf@gitster.mtv.corp.google.com>
	<1462579902-18907-1-git-send-email-rbraun@sceen.net>
	<xmqq37p75nif.fsf@gitster.mtv.corp.google.com>
	<20160524182623.GA8562@shattrath>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Richard Braun <rbraun@sceen.net>
X-From: git-owner@vger.kernel.org Tue May 24 20:39:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HEe-00027t-1o
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbcEXSjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 14:39:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072AbcEXSjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 14:39:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 415F31E3F0;
	Tue, 24 May 2016 14:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pMztfiontgLg9BVMRS7F88jCLLA=; b=w9wzyd
	a6/IwglJTMf+ExbJL5zocDPBd6xv7zKyEJ92UDAEpYLVE+OdQq0I5CUKLS27BJ++
	KGaUsHKihXz4pTGvMIiAG2WUjxgzwwL3DKkg6zfLo9yatADla77oS+K61x1/HWtR
	PTGVK4RFmm3XHqe3gD0yP5KonbO8/VnFAC1AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fdnpjUPrucqWtf7Y9uQE4rjeAPoKDZd4
	mHhcxy/Q4Nxi13l6Uh18C6cx5dymQqjetfuuXlFhFF+4R8NR6h4/eXRTsjqPJaeV
	oih2TwbItwyP8NxQlSRTRomJ2q+DmFxZVDw1wp3JG41q1ohANBGo1sEmRPU1LNPE
	3f5MyX+RMQs=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 388691E3EF;
	Tue, 24 May 2016 14:39:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE5451E3EE;
	Tue, 24 May 2016 14:39:12 -0400 (EDT)
In-Reply-To: <20160524182623.GA8562@shattrath> (Richard Braun's message of
	"Tue, 24 May 2016 20:26:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF63DDDE-21DE-11E6-99EA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295516>

Richard Braun <rbraun@sceen.net> writes:

> On Tue, May 24, 2016 at 11:17:28AM -0700, Junio C Hamano wrote:
>> Pinging...
>
> Hum, see [1].
>
> Tell me if I need to resend.

Sorry, check the "To:" field of the message you are responding to.
The ping was not meant to (and was not addressed to) you.  It asked
for comments from an area expert.
