From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t0027: Add tests for get_stream_filter()
Date: Tue, 26 Jan 2016 22:34:19 -0800
Message-ID: <xmqqio2fa5uc.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1453622143-22038-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Wed Jan 27 07:34:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOJgQ-0006Ly-Bl
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 07:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbcA0GeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 01:34:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753589AbcA0GeV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 01:34:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE0153205F;
	Wed, 27 Jan 2016 01:34:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rWaBjbCX6wQo
	ZKaovA8QhVwkyNg=; b=ikscaelJhheRq6JkCI2/9MUGFhs1t7Ep3iBT6RvigtPV
	AuLnjkomgtShKwFW8GnrVx5pVM5eVk1TxKvEOWladmxYIL+T9nxNSBBaD56yVzxe
	Kf5LIOZO7RrqLiadC/AM7PjPSwFnx6yn29rMr1Rt7HicZyT1V2MnJu8QfCTfLv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Tnz3/X
	98orW3ScRCa6IqF8k3QYS8+8yUsorWsdjPT51jMzqbl43E6U/5gjwSwf0/5Jf8yd
	FyFdYmVyIFjnv5++gC3mGNay/YA0aWMXv/4QKcN4m9NYOIPy3GhTq9ZLC5Wxliua
	tMDaRZj37PjfO72xQtVtD80x86lbykR2eWXPo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C67F73205E;
	Wed, 27 Jan 2016 01:34:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 463C53205D;
	Wed, 27 Jan 2016 01:34:20 -0500 (EST)
In-Reply-To: <1453622143-22038-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Sun, 24 Jan 2016 08:55:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF23E8F6-C4BF-11E5-B479-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284871>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When a filter is configured, a different code-path is used in
> convert.c and entry.c via get_stream_filter(), but there are no test =
cases yet.
>
> Add tests for the filter API by configuring the ident filter.
> The result of the SHA1 conversion is not checked, this is already
> done in other TC.
>
> Add a parameter to checkout_files() in t0027.
> While changing the signature, add another parameter for the eol=3D at=
tribute.
> This is currently unused, tests for e.g.
> "* text=3Dauto eol=3Dlf" will be added in a separate commit.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> - This needs to go on top of  tb/ls-files-eol

With missing "separate commit", I am having a hard time to decide if
this is something I should pick up at this moment, or I should wait
until that separate commit materializes.  What is your intention?

Thanks.
