From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: should we do another 2.3-rc for t9001-noxmailer? I'd say not
Date: Mon, 02 Feb 2015 12:52:30 -0800
Message-ID: <xmqq386ot4s1.fsf@gitster.dls.corp.google.com>
References: <xmqqr3u98d0f.fsf@gitster.dls.corp.google.com>
	<20150202203838.GA30001@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:52:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINzG-0007dw-I8
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbbBBUwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:52:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753260AbbBBUwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:52:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F44135B68;
	Mon,  2 Feb 2015 15:52:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5s3A9SJxhcu0s8xo7RxLVddAIWM=; b=f2Hy2b
	IkHsZqA/KWjPyPI4uuWlPlumRLj67Oe2xJ/7gAUkn92/A2WK0lx/i6x+V0le2Xo2
	oepX08soncVKylqxImH14/ktHuBJfUvlJ6JhxPSNPlo1jzTJq0JT0KDcInKrrt8J
	QzKGFHxytaFbvj6KpB3gp5HYsTmF5+LLoduJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g46bzOw5RELGQ9PN8PXIjkcE0JcyU4VG
	3MajQS0Yn0GKvOxX+DI1pPCAplIemQm2HIP64UxhphKVFbCsknkvUNNblb3JqLwU
	+f2QrgNGgINEEeiwKnS3Mrlq07a715Yy6qm29qh4h01Rt1zisflPAruIik66zEtu
	zbyB7eJZwD0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77A9535B67;
	Mon,  2 Feb 2015 15:52:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA09135B59;
	Mon,  2 Feb 2015 15:52:31 -0500 (EST)
In-Reply-To: <20150202203838.GA30001@peff.net> (Jeff King's message of "Mon, 2
	Feb 2015 15:38:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68D38A58-AB1D-11E4-95D6-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263289>

Jeff King <peff@peff.net> writes:

> I thought at first that we also had a regression in pruning with
> alternates, but it looks like that bug actually went into v2.2.  I still
> think we would want the fix fairly promptly, but it does not need to
> happen before v2.3 is released.

Yes, this was regression in v2.2 we did not catch X-<.  The fix
looks so obvious that it appears nothing should break, but that
tends to be the famous last words, so...
