From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Ready #2
Date: Tue, 21 Feb 2012 00:44:31 -0800
Message-ID: <7v4nukinio.fsf@alter.siamese.dyndns.org>
References: <877gztmfwy.fsf@smith.obbligato.org>
 <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net>
 <87sjicpsr1.fsf@smith.obbligato.org> <87ty2ro1zf.fsf@smith.obbligato.org>
 <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org>
 <87ehtowxu7.fsf@smith.obbligato.org>
 <7vwr7gitjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: greened@obbligato.org (David A. Greene)
X-From: git-owner@vger.kernel.org Tue Feb 21 09:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzlKx-0001yO-SL
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 09:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab2BUIof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 03:44:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2BUIoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 03:44:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F4C2F4E;
	Tue, 21 Feb 2012 03:44:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fPbL4qHAeGgwENAZCsePFiqQmIM=; b=l2uIrv
	BqA+qBHI2HttEoYF8hyaUZOqUlHd/mstDjcCWxg5xULRSJYp0Gm+eJ3aX29im8TY
	5IlpKOF43tOfy7DWdaLzaXWZzQCwk9oaNemBhWFIx5mRiSFxsysGhGcYAS+1+emO
	6CkyyjKfmM2VhXe1hp8pZkhdjPIPhxbS+ZfyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixRkeIaG153keEOeGJz4dImVq9LPvB7T
	p4GvspOgjI5Dxjg2oa/Fko83iKXTK5JcH11YGBmxBbOCNIIjhl25wMfjGmjWZVF2
	8fICVMflKt2wXFdM/ROyCPNoCDtxL8ZV6tcZhyT1iwf1l+ttTmz9t0rphAV2n+y/
	LdJKXYaOGJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87EF32F4D;
	Tue, 21 Feb 2012 03:44:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEE2C2F4C; Tue, 21 Feb 2012
 03:44:32 -0500 (EST)
In-Reply-To: <7vwr7gitjl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 20 Feb 2012 22:34:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46A2A8D0-5C68-11E1-A7F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191141>

Junio C Hamano <gitster@pobox.com> writes:

> greened@obbligato.org (David A. Greene) writes:
>
>> Ok, but we will preserve the history via the subtree merge, yes?
>
> I'll comment on just this part, but a short answer is "no, I do not think
> so".
> ...
> I was saying that the history up to the current state, littered with these
> commits that are not "logical progression" but merely "a snapshot of
> then-current state" may not be worth preserving, with or without better
> messages.
>
> Rewriting the entire history to make it a logical progression just for the
> sake of history is obviously not worth the effort.

Having said all that, my preference is not so strong to out-right veto
doing a true merge; I wouldn't lose sleep if we end up merging the tip of
your subtree branch with all the history behind it as-is.

BUT.

Even though I freely admit that I was the guilty one who came up with
"merge -s subtree", and Linus's "gitk merge" was the original sin, having
a subtree merge like gitk, git-gui and gitweb in the history is not
without downsides.

The most problematic one that we regularly suffer from is that the
commands in the log family cannot work well across a subtree merge with
pathspec limiting, e.g. "git log git-gui/po", and we have to resort to
something like:

    $ cd git-gui/po &&
      git rev-list --parents HEAD . |
      while read commit parent
      do
        git log --pretty=short $parent..$commit^2 -- :/po
      done | git shortlog -n -e

to achieve what should be a simple "git shortlog -n -e git-gui/po".  I
suspect that a subtree merge may also lead bisection into uninteresting
tangents as it joins otherwise disjoint history.

If we still have an active upstream that grows its history in a separate
repository, like gitk and git-gui do, we cannot avoid a subtree merge in
order to continue merging from them.  Because you seem to be taking over
and are going to maintain it as part of git.git proper, eventually aiming
to move it out of contrib/, it's just that I do not think it is worth the
trouble.
