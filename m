From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2016, #04; Wed, 23)
Date: Thu, 24 Mar 2016 14:51:02 -0700
Message-ID: <xmqqfuvf7dfd.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoukc30t.fsf@gitster.mtv.corp.google.com>
	<54B6C1E1FE6A4BAEA07E97B7BA81EB01@PhilipOakley>
	<xmqqlh57am55.fsf@gitster.mtv.corp.google.com>
	<171B6E119FCF4E5CBF2831F6A7A004EA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:51:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajD9t-0006AJ-H1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbcCXVvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:51:08 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750755AbcCXVvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:51:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFEAC4D1D2;
	Thu, 24 Mar 2016 17:51:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5QAm/8rvMHNYkt+OXRZU9Y67eM4=; b=ratn24
	fTQpmQDDxns3NwXWlDdcCCiCKSBM5+U23WlkKABiwrbbNj9EPuqmII7m01e/VsCt
	ofh/jvEWaXp11LjQc67VSZ7dabJRWxzX6sQKcLG0wkDo/RJmYbm6dHs9Rr0p9fiJ
	gSXcOCOw0A3sx+WoZk1N3j+seQMxHngnzzrnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJ1qqwP7rkrsKwBvCelPQ7sWKkSKPTgU
	/sZ0FjoI2TOWGNujGWOBs+qkpOIB7P+xPaBaooDKy5QSpncgsD/6BGOYEMk7JFmR
	HOb4ODJurZvXJyyLaz2fB2Fy70/GNytlihW3aZ8aDVcD+59PyaQXbTotDC1Orq0y
	278qrLfbKPQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E62C74D1CF;
	Thu, 24 Mar 2016 17:51:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6E8B44D1CE;
	Thu, 24 Mar 2016 17:51:04 -0400 (EDT)
In-Reply-To: <171B6E119FCF4E5CBF2831F6A7A004EA@PhilipOakley> (Philip Oakley's
	message of "Thu, 24 Mar 2016 21:47:20 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81B9615C-F20A-11E5-AF0F-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289808>

"Philip Oakley" <philipoakley@iee.org> writes:

> This was just clarifying that if a variant of the bundle format (#
> V3?) was used, that it must, if the name was retained(*), still work
> as a sneakernet transfer option. In that case the user would need to
> be told, or be able to find out via (e.g.) the 'verify' sub-command,
> where the other half of the split bundle (the pack) was located so
> that both halves could be copied for sneakernet transfer.

I was sort-of expecting that users are intelligent enough to not
even imagine to use split-bundle for sneakernetting, as it would be
obvious that there is no upside for doing so.
