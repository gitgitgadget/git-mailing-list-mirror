From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Tue, 21 Feb 2012 11:16:37 -0800
Message-ID: <7v8vjwgfoq.fsf@alter.siamese.dyndns.org>
References: <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch> <20120220143644.GA13938@do>
 <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 20:17:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzvCh-0007NU-JP
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 20:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777Ab2BUTQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 14:16:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074Ab2BUTQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 14:16:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D20168BD;
	Tue, 21 Feb 2012 14:16:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cMQX+a5kqdKuT0jyOsgBZrhAL0w=; b=G5KWpv
	sJnYvIcWLFT0aqbAc6IlLv/eN+XjmoTgMl2e5mGPQx2jjiiijvJ6jBuZ11i3xHfQ
	eMOAPsYSOTZ0XLYvCbpDTHogsL3A2kwVqoexsgy5OjYcykfJ4nuGB4k5W897dw/8
	jTLIcTxRxR+2Agw1wAaFgFA5JC2BPTXxdEm5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gty1GYk0wGPqDX5aEnmtEgCabW24/e/B
	j+G219su3UoKsn5Z6Dlte048s/Mvvr4+qgtNS1orFaUKepyHFfNnyKudztAS2wq+
	gvyP1QmexbtQZMh+66GPl5ky3h/NZHPvddiRX4g/wPkzGEXvXl7dxVuGg0OBx2Di
	GOdoazCezbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 235E568BC;
	Tue, 21 Feb 2012 14:16:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A95F68BB; Tue, 21 Feb 2012
 14:16:39 -0500 (EST)
In-Reply-To: <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 21 Feb 2012 21:45:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94B8E0EA-5CC0-11E1-A915-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191177>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I'm aware that Jeff's tackling at lower level, which retains
> cache-tree for many more cases.
>
> But this patch seems simple and safe
> to me, and in my experience this case happens quite often (or maybe I
> tend to keep my index clean). Junio, any chance this patch may get in?

I do not think we are talking about a duplicated effort here.

By definition, the change to hook into unpack_trees() and making sure we
invalidate all the necessary subtrees in the cache cannot give you a cache
tree that is more populated than what you started with.  And the train of
thought in Peff's message is to improve this invalidation---we currently
invalidate everything ;-)

Somebody has to populate the cache tree fully when we _know_ the index
matches a certain tree, and adding a call to prime_cache_tree() in
strategic places is a way to do so.  The most obvious is write-tree, but
there are a few other existing codepaths that do so.

Because prime_cache_tree() by itself is a fairly expensive operation that
reads all the trees recursively, its benefits need to be evaluated. It
should to happen only in an operation that is already heavy-weight, is
likely to have read all the trees and have many of them in-core cache, and
also relatively rarely happens compared to "git add" so that the cost can
be amortised over time, such as "reset --(hard|mixed)".

Switching branches is likely to fall into that category, but that is just
my gut feeling.  I would feel better at night if somebody did a benchmark
;-)

One thing we do not currently do anywhere that _might_ be of merit is to
make a call to cache_tree_update() instead of prime_cache_tree() when we
already know that only a very small subpart of the cache-tree is invalid
and it is cheaper to repair it by rehashing only a small portion of the
index than to re-prime the entire cache tree with prime_cache_tree().
