From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RFC] grep: add color.grep.matchcontext and color.grep.matchselected
Date: Tue, 28 Oct 2014 09:50:23 -0700
Message-ID: <xmqqzjcg3zqo.fsf@gitster.dls.corp.google.com>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
	<544D3A3C.4080906@web.de> <544E8D89.3030201@web.de>
	<xmqqy4s1s44h.fsf@gitster.dls.corp.google.com>
	<CAKJhZwRShbV14=BihxiTzayR4kg3GaAPN_NFXwFZ-4kAD-QHTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 18:16:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjANh-0003y4-8a
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 18:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbaJ1RQX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 13:16:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752271AbaJ1RQV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2014 13:16:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25E6B18A01;
	Tue, 28 Oct 2014 13:16:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o4Tcyl7tbkb7
	/CRatxDzAgzcu3E=; b=l4hrKXC1NH6vTX9W1rzQwMVN1Pyh9sQfm7unhQF40iqZ
	F+toJduP/YRo6urb169fn2mu/TYYdzkoSfXx9DlVfTi/0mTWlZziYZkn8HM+BvRh
	2kVGKZxAEb/QCIPC9Wi/BHElYodl+PdMN8MVKXHEq/XhpWDzMV4URZBC48Lo5lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f0+G1L
	v+2TLvQ5kES3WJTfG+BD4jhkzmbL0dJYXvWeFLCEOucEpkplNEZjmeYvIgat6+yJ
	AqGQ9yZ2KfOdiwAVpOxHvgtAp0mYWJ2BLHdEIVk82k00TLAFOG+aBLqo0DNhh6fD
	Y7+bYFP16xvQYkBIsAbhsxbxuIYg7/EUCj4cQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B5CA18A00;
	Tue, 28 Oct 2014 13:16:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC232182DF;
	Tue, 28 Oct 2014 12:50:25 -0400 (EDT)
In-Reply-To: <CAKJhZwRShbV14=BihxiTzayR4kg3GaAPN_NFXwFZ-4kAD-QHTA@mail.gmail.com>
	(Zoltan Klinger's message of "Tue, 28 Oct 2014 10:32:23 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 83E108FE-5EC2-11E4-B87D-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> I like Ren=C3=A9's approach, too. It's more flexible, supports the ol=
d
> behaviour and it scratches my itch as well.

OK, then let's go with that one.
