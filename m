From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make "git checkout" automatically update submodules?
Date: Fri, 23 Oct 2015 12:11:18 -0700
Message-ID: <xmqq37x1pfhl.fsf@gitster.mtv.corp.google.com>
References: <loom.20151016T001449-848@post.gmane.org>
	<CAGZ79kYMyU5h8uQkNEpMU558FgLrNM52_aQsXud6CrBAUgFSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kannan Goundan <kannan@cakoose.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 21:11:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZphkO-0001Cx-DZ
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 21:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbbJWTLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 15:11:24 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753347AbbJWTLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 15:11:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 170C823266;
	Fri, 23 Oct 2015 15:11:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gNN3X47HoSlC2O6WWFt66xUEObA=; b=Fb9Y9b
	xdGvLTy1uYQT1v5dJ8VDGZZktQX9RsBfZe0BX+an8sZfFY2pHNZDdMM7sfTEaypk
	2r+s7SdQI39CcLjFZHWBHxvBc2vmpFzAIuNFezHVT9wsFj6zgZZoHo5Dp/cNpMXk
	2NC68aIJAobiLChcwDrnqoMcU+3sIKLZtjhN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mOE2qJCadbBbtSHp9GGtlBMgHyTgKud4
	M8X74rpGrf25WyVGeMJypwteQ5nrOxrRukNS+U8YnahUTYqb5c7EzXwHyCgP87Wg
	BeeKZROECUR/7F3H1xDWTo4CJrYz+UqpGyvXBKNpoYYzCElqYUe0S20rWrJazBT1
	2sSU+MA9NSU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09EFD23265;
	Fri, 23 Oct 2015 15:11:20 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 50B4623261;
	Fri, 23 Oct 2015 15:11:19 -0400 (EDT)
In-Reply-To: <CAGZ79kYMyU5h8uQkNEpMU558FgLrNM52_aQsXud6CrBAUgFSNA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 23 Oct 2015 10:20:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D7624CBE-79B9-11E5-90F0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280107>

Stefan Beller <sbeller@google.com> writes:

> Checkout [1]. There are lots of good patches, but hard to find.
> (Including, but not limited to a recursive git checkout enhancement!)
> ...
> [1] https://github.com/jlehmann/git-submod-enhancements/wiki

Yes, Jens is not just one of the people who have been working on
harder, and thinking longer about, submodules than anybody else, but
also has demonstrated that he has good taste and balanced view on
the design of the subsystem over time, whose technical judgment we
can trust.

Not all the changes listed on the page may necessarily be good as-is
(e.g. some may help only a subset of users while hurting others,
like the "recursively check-out everything unconditionally" that
trigerred this thread), but the page has a good collection to remind
anybody, who designs a coherent whole, of issues that need to be
taken into account.

Thanks for a pointer to an excellent starting page.
