From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Tue, 04 Nov 2014 12:56:12 -0800
Message-ID: <xmqqk33aptw3.fsf@gitster.dls.corp.google.com>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz>
	<xmqqegtkrtt9.fsf@gitster.dls.corp.google.com>
	<5457E7DF.5070500@web.de>
	<xmqqbnooq863.fsf@gitster.dls.corp.google.com>
	<87k33bao7w.fsf@steelpick.2x.cz>
	<xmqq7fzbriew.fsf@gitster.dls.corp.google.com>
	<54593572.3080805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Sojka <sojkam1@fel.cvut.cz>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 04 21:56:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xll9H-0002Y5-7z
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 21:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbaKDU4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Nov 2014 15:56:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751447AbaKDU4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2014 15:56:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF1391BE7A;
	Tue,  4 Nov 2014 15:56:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Xdz7SyV2s17E
	WXf+rU26OyBM3kg=; b=AZr/dkorhvXIwOKhFPxSZg8C+uPkM5yWbN9bqmuCawn3
	D7X5NNKI5zu+FzYbUfKQEnGb6M35/7oxKGXXMCJ31DxQOtdFJb6T74Dp2RmrGQ8v
	7dCC7L99bSFpoTL7kSrpYIw2ltcLwXtLjyaSMjXmbTvLxMXCzpLTJNbCq91tqbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q5rUmf
	VJxPnkZu/oX2w1m7W8F83wrKvenwbrruX8JV3gfxpX0c9B5Fz79+5oh43/zE4HwJ
	iyYS06crwrPL2jTbAlpsma07Lg1DANZf7Ve6pMoshgGWdzqwIJQzxAlSSFtxNIZH
	IVNSvSfh57I4Gu9fg1fEmW6iK1VtR2RLdprec=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB5831BE79;
	Tue,  4 Nov 2014 15:56:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41D5E1BE78;
	Tue,  4 Nov 2014 15:56:13 -0500 (EST)
In-Reply-To: <54593572.3080805@web.de> (Jens Lehmann's message of "Tue, 04 Nov
	2014 21:22:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 03008FE0-6465-11E4-B5DA-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So I believe that gitmodules.txt should describe all =C4=87onfig
> options that can be provided by upstream (and e.g. mention that
> the 'url' and 'update' values are copied into .git/config on
> init), while all settings that can be overridden locally should
> be documented in config.txt (which will be a subset of those
> documented in gitmodules.txt).

Right; thanks.
