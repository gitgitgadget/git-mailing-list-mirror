From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with gdb
Date: Fri, 30 Oct 2015 14:53:56 -0700
Message-ID: <xmqqio5oja4r.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
	<20151026191724.GE7881@google.com>
	<alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
	<xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510301925360.31610@s15462909.onlinehome-server.info>
	<xmqqlhakky0e.fsf@gitster.mtv.corp.google.com>
	<20151030190256.GI7881@google.com>
	<20151030195611.GC5486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsHca-0004nH-QX
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 22:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759727AbbJ3VyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 17:54:00 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759701AbbJ3Vx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 17:53:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB3B4246CC;
	Fri, 30 Oct 2015 17:53:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sk3b5FOpsMuB1GU256EnylY8sg8=; b=B9F+9j
	der/BkopCJM8JcqiVOz97+6mktpwIR6PNzfwNcfLq3H41hkIYjeFuvIc759e/YXw
	ejFV8ry9G+kpof/w2X5yrTBobz6s/6torU+n7GxQpzDIIyxmpXyduFdxKzvxT8E0
	gTLMG5VpowfxfX821t7NxGaMi31s4najbgIpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tzICekGNutlQXl+PMhK02oyFXp2JtxKm
	IEwOv/it7Z/83TSZtPG8kVuzlvo8PKyfVnd+2vhcEr8k5UafisjHMLz4X9qTqF7h
	Sgb/Y4OZS2KL5Ou4f9dc7OamdFYoucMQf2aVQWKz0hKapbl27rKt7oalQua0nBss
	BPxy1RhScXM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2A91246CA;
	Fri, 30 Oct 2015 17:53:58 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28C5D246C9;
	Fri, 30 Oct 2015 17:53:58 -0400 (EDT)
In-Reply-To: <20151030195611.GC5486@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 Oct 2015 15:56:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8F46018-7F50-11E5-866A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280548>

Jeff King <peff@peff.net> writes:

> At the risk of repeating what I just said elsewhere in the thread, I
> think this patch is the best of the proposed solutions.

OK, will queue.  I agree that more could be built on top, instead of
polishing this further in place.

Thanks.
