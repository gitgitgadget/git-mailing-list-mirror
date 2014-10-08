From: Junio C Hamano <gitster@pobox.com>
Subject: Re: configure names for temporary files
Date: Wed, 08 Oct 2014 10:25:34 -0700
Message-ID: <xmqqtx3ebhip.fsf@gitster.dls.corp.google.com>
References: <CALpL35mjtg9ge321Vz_kS1wzbYz+z9H5R3L8FcpVSNO3AtZzVA@mail.gmail.com>
	<20141008082228.GA78852@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sergio Ferrero <sferrero@ensoftcorp.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 19:25:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbuzn-0002m3-2T
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 19:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbaJHRZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 13:25:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62283 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750858AbaJHRZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 13:25:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CFDB14C9A;
	Wed,  8 Oct 2014 13:25:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P1fNC6EofbA/E06aLFzOTWyP+as=; b=ZmXPul
	vpS9PfreKVGpD/mrbhBGRbPeO1UenExlC94uCRNyM3QgZ7MSJ79Dh2muBdNL2XMk
	gmSUDb9nZ3hI/1Tx7HBmlJhkxFHAbiWM4eBYv9xJr4QL0Yu3XZyApFflc32O2DHW
	dzUIliyHFrF8NL9GbniIOtYT17VoEUybXiv0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DeMS8YT/PNsyQ4OuNJaGnR5cndCUpvKT
	bOTWf+31xnGjExdtn3ReVo7fxwQNdFnQVSfMNDLiIFqWIL4OdYs/dru4NpwDTlw1
	EHkfbMA9DRmSDsiQAmfyV2tUYezcv/BxvQMrhX8jhvJbexd006TMiUc7vhcXgKHK
	WJwdOBWl9Tk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7762B14C99;
	Wed,  8 Oct 2014 13:25:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F38C614C93;
	Wed,  8 Oct 2014 13:25:35 -0400 (EDT)
In-Reply-To: <20141008082228.GA78852@gmail.com> (David Aguilar's message of
	"Wed, 8 Oct 2014 01:22:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D72EF40-4F10-11E4-AC74-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> In any case, it might be worth adjusting mergetool to use a more
> conservative path (underscores instead of dots) since there
> doesn't seem to be much downside to doing so.

Hopefully there won't be tools that reject paths with "_" in them
;-)
