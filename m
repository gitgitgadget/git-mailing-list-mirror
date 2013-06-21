From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Fri, 21 Jun 2013 08:51:58 -0700
Message-ID: <7vk3lno40x.fsf@alter.siamese.dyndns.org>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org>
	<CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 17:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq3d9-0004yo-IH
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 17:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422989Ab3FUPwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 11:52:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161367Ab3FUPwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 11:52:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B4729452;
	Fri, 21 Jun 2013 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gfnIDCkeTNQm5n0pxBNGkqNGGH0=; b=v+Hvpr
	LDXm4LUYAj9PWkS+vWRSzfHe/6tcgCDrFmJiI7NQxoIRb2yfs6f9IhQ4a+Y8YAcs
	d07QL1gox733IuEg2B1F38cGOtmN0jZ8fxeB8xq+np/4Mi2TrLFn/PUy3DybZiZr
	k6lg3MJ85iKSbXcj22lIYc9BFkUJ9A2Lg/qAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2iAAZx2Ysxv69c4JdqWACtU8SDZ1jt/
	bfurxGCd6JFck81Z2BFYo6bORU4JnQ0xDApVbhS/eQG2zU61CCjRKrK3n4+HS+Ea
	HcIjxh7TLSVOupAM5fyNhg77ZTqztuGKAc99fN+oy21V2Kl8EcRDKOD4oEhrsDK0
	CRDR+5QF57Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CDE429451;
	Fri, 21 Jun 2013 15:52:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EF7829450;
	Fri, 21 Jun 2013 15:51:59 +0000 (UTC)
In-Reply-To: <CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 21 Jun 2013 16:35:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81F6322A-DA8A-11E2-8496-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228621>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Four topics are awaiting review (they're important to me in this order):
>
> - rr/for-each-ref-pretty at $gmane/227057.

No comment on this at this moment.

> - rr/describe-contains-all at  $gmane/228278.

This may overlap with a topic in flight (but I didn't look at it).

> - rr/mixed-case-aliases at $gmane/227959.

Personally, not just uninterested but moderately against.

> - rr/completion-word-diff at $gmane/228305.

This was missed in the noise; obviously good and will pick up.

I do not think I am the most qualified reviewer in some of the areas
they touch, I do not want to be the only one who is reviewing
patches here, and I am personally not very much interested in seeing
these topics in Git, so I've been waiting if somebody else shows
interest and starts reviewing.

Which is not happening, so perhaps nobody is interested in them?
