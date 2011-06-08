From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote
 helpers
Date: Wed, 08 Jun 2011 16:19:29 -0700
Message-ID: <7vk4cv29oe.fsf@alter.siamese.dyndns.org>
References: <20110607171838.GA21685@sigill.intra.peff.net>
 <20110607172030.GC22111@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUS2S-0003n4-Dg
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 01:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab1FHXTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 19:19:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab1FHXTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 19:19:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 054076E2B;
	Wed,  8 Jun 2011 19:21:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r0t/7QYiN+XJFlHUS7mZlUwvTnw=; b=ocxSAO
	33BFezKNQhyJMJC12fgrw/kUbxnf0avpUze1WxfFpepAJlXs/cW9Yc1hZF+huz7y
	OOeGrjXaH6xHL4w3u4Sy/kIG7qoi1Vn2NXJDjzMCjfFXnwgxbCGDSophcIyrt1g6
	L+8h21jl4CM49i9b5kN4GDi+AOZAvw91Hj49Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOWE/b8k/1SoNLL3pLLuvF4wMTDZQ6qr
	2jqw8v6dtWuojb47zN31IGWMQ17i87l4Qe1at4mPsdNYHcQBmH4qu9yZDpGst5xL
	pJq3xqDA5hOm9kmTyldwt0RUiUP2rr7FG+hh5W+jBhlE3i0hkwcE2rYMVOFv8JQG
	id8WTIYhFHY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CF556E28;
	Wed,  8 Jun 2011 19:21:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0F686E27; Wed,  8 Jun 2011
 19:21:40 -0400 (EDT)
In-Reply-To: <20110607172030.GC22111@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Jun 2011 13:20:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 155341F2-9226-11E0-BAC2-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175472>

Jeff King <peff@peff.net> writes:

> The third test demonstrates a bug in git's side of the
> helper code when the upstream has added new refs without us.

without us knowing, you mean?
