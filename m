From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] object: make add_object_array_with_mode a static function
Date: Mon, 20 Oct 2014 09:21:24 -0700
Message-ID: <xmqqa94qr9tn.fsf@gitster.dls.corp.google.com>
References: <5442F56B.8020205@ramsay1.demon.co.uk>
	<20141019020319.GB17908@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 18:21:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgFi7-0003dW-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 18:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbaJTQV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 12:21:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750993AbaJTQV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 12:21:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AD0F1501D;
	Mon, 20 Oct 2014 12:21:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K7wmBOxfiGAgrgKUehwKOzc4k0c=; b=JWQY2Z
	TW7xuJU2io4PXl9aF6BEQmFkm0WumJS2YTwdbqXUN5LhX27GaHL54QJa4axOdZV1
	DmIw7Il0X1Jh1DPwTq9cQ5TsmL0jPggPhyyGNuqFLp+aj7Ox+7YyTAkxVRdrssmC
	dOjBhOl76P3xunCcR83Xovus8jaKx80mtlqNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y/sIEqzVyWjX3QF9aWEmU3Su9gUfNbqe
	5O2qK62hCaZjdeJdtvowO+cdQrh0GpbZrtqN+x0AZsxk8kaLMxASwvH9QdRd72Pj
	0Jv1sObg/BIkDqiZbjpuMqT8j3mQTcmGOZ3rFJXGPxHTosp3P1mYczK5P0TVXZnJ
	NcJaGCRG/xk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 822941501C;
	Mon, 20 Oct 2014 12:21:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA7EB1501B;
	Mon, 20 Oct 2014 12:21:25 -0400 (EDT)
In-Reply-To: <20141019020319.GB17908@peff.net> (Jeff King's message of "Sat,
	18 Oct 2014 22:03:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 239A6844-5875-11E4-8AD0-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we can take your patch a step further, though, like:
>
> -- >8 --
> Subject: [PATCH] drop add_object_array_with_mode
> ...

Thanks.  I think I picked up all incrementals in this thread, but
please holler if I missed anything.
