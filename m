From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 15:38:27 -0700
Message-ID: <xmqqmw37cn18.fsf@gitster.dls.corp.google.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
	<CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
	<xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaDnRiUQ6=3gVvsPrkSzkNbACRvgQBSo8gmpRZ8bka84g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Schneider <thosch97@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:38:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ5Yp-00081M-Dh
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 23:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbbCTWib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 18:38:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751196AbbCTWia (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 18:38:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56D1542268;
	Fri, 20 Mar 2015 18:38:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xm25ftUk6ZLfmJ2iuKxWSFS58i8=; b=FoUA1/
	L16V+K62BoCOjAVRfTmcwFv6CqW6GAjnOSba9VEhTB/w8H3BqAu64nfPt1Si+Gpx
	rAxqSiAqSY9d4GP+y0Z2BXR1sRah67ysFvjYmsu1yf0cA5855QJLzNE4hhpn+SZf
	0WAqqgmRFRfJbKKAzAi9V9JCwL/yaEl5vsvd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uq7JdJ42SAz7ZgdgyakcAL2JY3xDWv7y
	fyH1RldrfBe+L6ugUMOB6ij6CBpd29LlRWIv3Yg5ptGt2zvkVInQi0vWJ5dHEmKz
	dYfF3Q0XxVCBl4a09fE7HF7eyUNiX00vtrK7QcboHKKaIOXPephPMg5DI3zy+B9O
	ZHwOn/05+8c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E4F242267;
	Fri, 20 Mar 2015 18:38:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B553D42266;
	Fri, 20 Mar 2015 18:38:28 -0400 (EDT)
In-Reply-To: <CAGZ79kaDnRiUQ6=3gVvsPrkSzkNbACRvgQBSo8gmpRZ8bka84g@mail.gmail.com>
	(Stefan Beller's message of "Fri, 20 Mar 2015 15:19:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D43643C8-CF51-11E4-96D8-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265976>

Stefan Beller <sbeller@google.com> writes:

> Thomas referencing reading the man page offline, made me wonder
> why you wouldn't read the man pages itself as they can also be
> carried around offline. But the striking point is "on an iPad", which
> doesn't offer you the convenience of a shell etc, but pdf is fine to read
> there. Also you can add comments to pdfs more easily that html pages
> I'd guess.
>
> So the patch makes sense to me now. It's just a use case I'm personally
> not interested in for now, but I don't oppose it as is.

Well, my comment was not about opposing to it, but was about
questioning the usefulness of it, iow, who would
benefit from having this patch in my tree?

I didn't see (and I still do not quite see) why people would want to
have separate pdf files for all the subcommands (instead of say an
.epub or .pdf that binds all the man pages and perhaps user-manual,
just like we do for .texi/.info).
