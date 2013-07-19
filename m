From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] treewalk.c: Rename variable ret to cb_bits and remove some dead lines.
Date: Fri, 19 Jul 2013 15:28:57 -0700
Message-ID: <7vsizatc9i.fsf@alter.siamese.dyndns.org>
References: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
	<7vli52wh8n.fsf@alter.siamese.dyndns.org>
	<51E9A0D0.3090701@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 00:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0JAf-0002Qe-TH
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 00:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776Ab3GSW3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 18:29:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33392 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab3GSW27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 18:28:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F73632033;
	Fri, 19 Jul 2013 22:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X6NPJbUicszJs0oRm50nIgddaSg=; b=YTLx5a
	gZHQYfRR8nMYNLS2iEX31RgCzm8CU6WIQq3C4AH+7aUGs4cJ+bqLtTsaqCm0h49b
	grNbYftO6SHDakTq8O90wX00bVmu+maxnDdMu5CstsGIguWKMZQ9ae40uhTC5mxq
	c3IySRFRwROlijAY/N9J6TSxnVQJTwJvtISE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sFB84KURMUidps0dpNWbhE20cxwtj1uR
	B7sbwQ04QAJZgvBqQQWvDz6WWrrwf/1RxX7TsHXv5J3QX1IPdRfne8R9XNXs6JaO
	XacMshCzFjTigieMVVFpTT5iqfAvivpEX4kZ9Ndv3Ani4qY5F76CoTzsYTpuIMB3
	gYYYQDNv1r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76FD632032;
	Fri, 19 Jul 2013 22:28:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEB8632030;
	Fri, 19 Jul 2013 22:28:58 +0000 (UTC)
In-Reply-To: <51E9A0D0.3090701@googlemail.com> (Stefan Beller's message of
	"Fri, 19 Jul 2013 22:25:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AFE135C-F0C2-11E2-9506-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230853>

Stefan Beller <stefanbeller@googlemail.com> writes:

> So is there any up-to-date task list for beginning contributors?

I am fairly bad at keeping track of small things incrementally, as
it is often quicker to do them myself if/when I were so inclined,
but there are too many of them and a day does not have enough number
of seconds X-<.

These days, I tend to scan the mailing list backlog in batch every
once in a while.

  http://git-blame.blogspot.com/search?q=leftover+bits

may show some of them.

Thanks for asking and volunteering.
