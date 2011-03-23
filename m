From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/5]rev-list and friends: --min-parents, --max-parents
Date: Wed, 23 Mar 2011 11:06:29 -0700
Message-ID: <7voc51emoq.fsf@alter.siamese.dyndns.org>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2SSH-0005Yu-Ay
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 19:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377Ab1CWSGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 14:06:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392Ab1CWSGn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 14:06:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C27B4C5F;
	Wed, 23 Mar 2011 14:08:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V5fgJmZtanykOh5Ggvv4kTbJso0=; b=DxaSUv
	uLqqgMJwYyu/VFzr8Eji9tjbv6yjH0dDZq+HBhpfNfggH52oHi5qwZEJ8He6JOhc
	HOvv04R4Ctxs6ZWR2lqDtUQs6Dt4iar8ADq436jWB6s1n8eG4zbSAcuD9/FDd0Tj
	QSguOqnF+CM0XTeaOyaVpS3b9Ru4+S/V6Cl3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LNrW8yW8zyBcW5d3hApNJ26BYmiKWbg6
	0yfqJmZ6faUM1t88y80K0gKe2FPJnI5x3wzQaShSSFotBwPYWRA6LYuPa4S+rdKA
	FhD4MOpPn6+Q5fukFtKt7s8tIOsL0qXhBEXiDQwQ9UZINpkXTd0NerGI4gPr4Po+
	E3PD6yiyuHM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CEACA4C53;
	Wed, 23 Mar 2011 14:08:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B1A4B4C4D; Wed, 23 Mar 2011
 14:08:11 -0400 (EDT)
In-Reply-To: <cover.1300872923.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Wed, 23 Mar 2011 10:38:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8800DB6E-5578-11E0-BBC8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169861>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Compared to what is currently in pu (which is v2+eps), v3 has:
>
> 1/3 -> 1/5 unchanged
>
> 2/3 -> 2/5 unchanged
>
> 3/5 is !squash for 2/5 and introduces --no-min-parents and --no-max-parents
> as natural ways to reset the limits
>
> 3/3 -> 4/5 with a fix to the notation in documentation (spell out =<number>)
> and an additional dodecapus test
>
> 5/5 is !fixup for 4/5 and adds test, doc and completion for --no-min-parents
> and --no-max-parents

Looked good; will replace what is in 'pu' and advance the topic to 'next'.
