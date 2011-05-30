From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/3] diff: introduce --stat-lines to limit the stat
 lines
Date: Mon, 30 May 2011 00:36:34 -0700
Message-ID: <7vhb8cod19.fsf@alter.siamese.dyndns.org>
References: <4DC0FD3D.9010004@drmicha.warpmail.net>
 <cover.1306499600.git.git@drmicha.warpmail.net>
 <5da631c64438ec3f669f0c2b7456bcfbc371e2f5.1306499600.git.git@drmicha.warpmail.net> <7v39jzqvny.fsf@alter.siamese.dyndns.org> <4DE33BF0.7060607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 30 09:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQx1t-0001mn-FL
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 09:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab1E3Hgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 03:36:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab1E3Hgn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 03:36:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B7EC6D90;
	Mon, 30 May 2011 03:38:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZfvAIJpv6TBcNMbwOr4zP2/cU54=; b=RIDD4Q
	7Qsju9zdt9CJgRosPQAFZJy30+jOzWtJejra33bau/N0TG0cFTD580n5gKNE9px9
	fee0ubhuKtzlUmfROwT5VuipbBf+JXOIrnysd3sWUQDK4jbsf9PshPvISPzwvBPB
	gaC77wEsuJKUpfFzHhX9jHuFBCCjRKrpR0H20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQGQLq+w57QODY74fS0AEh8Jm6JlKqrV
	WRELspnIq02lEuIVGIjFOG4EEev8XUi0O935OfbknXRp7M5QQJwSGXgnuGNKSSfX
	PYGkf5pWGjvPHVrSwOjjQv98QLfVEBrIlUviMs0rn52BvAgE8jQRa4EjrUpvigaw
	H3aZzekPWNw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A34B6D8F;
	Mon, 30 May 2011 03:38:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8DE6B6D8E; Mon, 30 May 2011
 03:38:44 -0400 (EDT)
In-Reply-To: <4DE33BF0.7060607@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 30 May 2011 08:40:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA98B6E8-8A8F-11E0-9525-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174730>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> That works, thanks also for the test.
>
> Should I squash this in or go for a clearer use of "count"? (Also, I may
> have to take into account your notes about the workflow.)

I do not recall any "notes about the workflow" but if you feel it is worth
keeping, please go ahead. I've queued the fix-up as a "finishing touches"
separate commit, but the series is still in 'pu' so it is a fair game for
you to do whatever you think is the most appropriate for it.

Thanks.
