From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #01; Tue, 1)
Date: Wed, 02 Dec 2015 17:09:07 -0800
Message-ID: <xmqqtwo0tk24.fsf@gitster.mtv.corp.google.com>
References: <20151202002450.GA27994@sigill.intra.peff.net>
	<xmqq4mg05wmj.fsf@gitster.mtv.corp.google.com>
	<20151202223114.GA20542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 02:09:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4IOa-0007Dr-RF
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 02:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467AbbLCBJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 20:09:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754717AbbLCBJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 20:09:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63B1431C6D;
	Wed,  2 Dec 2015 20:09:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NHSbkyxJTjI8XKkP7Z7qUxk5wCo=; b=vqU3ia
	l8JGXHXY57BNxeCu+dn+GI5j/a1DLamBBNy/WtoMiQNnZ9h2EM1oElzAMIVE3q5s
	P/3/l8d+3kFH/DGsTAY1EA6nZrWwNopFPDAMtgZsdJ5owhJE0mCLmPlgZAD3U5ct
	r/Ot7lyl6zz9NmVFJVRtmHkuRjWpX/DDpQgWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCvm7dD3NcwuwYCqACF3ZdbFjabYGXuA
	NZNz0MIDxlqiR1Qsw1Tcvbn0/1fNLCHtZH7hhrd0oug7TlU4M9Y1rsjSsHONdFE7
	16a/8Vpf2DHCenbDj1CxKS4rWCtk4qew6Hs+bZcpySRbMTfAH8qZrv4eiuGIXjYo
	mXO6C2sgyDw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59E9A31C6C;
	Wed,  2 Dec 2015 20:09:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D06DE31C6B;
	Wed,  2 Dec 2015 20:09:08 -0500 (EST)
In-Reply-To: <20151202223114.GA20542@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Dec 2015 17:31:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74B34E36-995A-11E5-9018-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281942>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 02, 2015 at 02:11:32PM -0800, Junio C Hamano wrote:
>
>> I think I managed to get my working area (together with a handful of
>> new entries in the rerere database and a few merge-fix/ entries) in
>> sync with what you pushed out well enough that my automated
>> procedure would recreate the status of various branches you pushed
>> out exactly.
>> 
>> I haven't caught up with the changes in the component branches,
>> though, so it may take a few days until I start picking up new
>> topics from the list traffic.
>
> My whole workspace is at https://github.com/peff/git, if fetching that
> directly is easier. I just noticed that my refspecs were not configured
> to push up refs/merge-fix. I've just fixed that and pushed again.
>
> I'll leave it that way for a few more days, but then will probably take
> it back to my usual contributor setup (i.e., just my topics and personal
> integration branches).
>
> Let me know if there's anything else I can do to help with the handoff.

I've rebuilt 'pu' (and 'jch') with the component topics myself,
following the exact order of merges you had between master..pu, in
order to make sure that I fully made my working area in sync with
your merge resolutions, meaning that there shouldn't be any
differences between trees of the tips of integration branches.

The result has been pushed out to various places.  The push to
https://github.com/git/git/ resulted in a single 'pu' update (the
trees did not change, the merge history was rebuilt as stated in the
previous paragraph).  Other repositories, i.e.

  git://git.kernel.org/pub/scm/git/git.git/
  git://repo.or.cz/alt-git.git/
  git://git.sourceforge.jp/gitroot/git-core/git.git/
  git://git-core.git.sourceforge.net/gitroot/git-core/git-core/

received various updates to match your last integration results.

So it is OK for you to set your workspace back to your usual
contributor settings.  I can continue from here on.

Note that I haven't made any new merges, picked up any new topics or
replaced an old patch on an existing topic with a new one (yet).
Hopefully I can get to that tomorrow.

Thanks.
