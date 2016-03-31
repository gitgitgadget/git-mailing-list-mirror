From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/4] Some cleanups
Date: Thu, 31 Mar 2016 13:11:15 -0700
Message-ID: <xmqq60w2mmqk.fsf@gitster.mtv.corp.google.com>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
	<20160331191252.GB5013@sigill.intra.peff.net>
	<xmqqio02mokp.fsf@gitster.mtv.corp.google.com>
	<20160331193333.GD5013@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:11:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aliw6-0006lw-Rr
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbcCaULT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:11:19 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752260AbcCaULS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 16:11:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD2ED527A7;
	Thu, 31 Mar 2016 16:11:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Wd2QGB+qXiN9GZfs0odq+JEhKU=; b=O/v1IW
	aiFkHXrMOVLp/Nedy/huQ5XP9K+Q26Fjjg1XSSOVVzEJ9MaRQrJZMitNzAIWsWgn
	XNbkd3yhKnnqfVKWpJM4n5cFXRZC+6OMwAIWj+ozR3OSrf1Y7S6y4lqnd5hka3IZ
	YlppSqVtI1eapVAkHPV5IbAnfXWZNZhui51g8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mE1zj3Vq8uCIISiCQCO+c8fCf4UKYOXN
	FLYXi1GH4YrSUKR/K4IYRoeLvpGMvn69p/SIdMiL308mKytnctjMJPk4sc0LBZr4
	omuTwf7FHa5JzN2HtuotQUC+Oa41zgc4jCQMiJXOnbSWN+/s6D5vTQbLf3q0zQsG
	/lhOpHjKJjI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5A17527A6;
	Thu, 31 Mar 2016 16:11:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1A693527A5;
	Thu, 31 Mar 2016 16:11:17 -0400 (EDT)
In-Reply-To: <20160331193333.GD5013@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Mar 2016 15:33:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B9E0E880-F77C-11E5-8EE4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290460>

Jeff King <peff@peff.net> writes:

> Well, by polish up, I meant "write a commit message for". :)
>
> The patch itself looked fine to me.

I'll throw it in my "leftover bits" list.  After queuing 2/4, it now
needs a trivial adjustment to the patch text, which would be a good
spice for a new contributor who is looking for something a bit more
than "somebody did all the work and I can just resend it".
