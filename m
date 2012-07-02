From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incorrect v1.7.10.4 tag on github?
Date: Mon, 02 Jul 2012 14:00:57 -0700
Message-ID: <7v7gulzxme.fsf@alter.siamese.dyndns.org>
References: <77A5E1CD-836A-4747-9E62-42C25C0D8B7D@sfu.ca>
 <20120615182534.GB14843@sigill.intra.peff.net>
 <7vvcis9ylx.fsf@alter.siamese.dyndns.org>
 <CAPBPrnspD3uC6_wd7nqMUVgHSt4Frwy8UaYL6fU73kJKX6=XWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Graham Ballantyne <grahamb@sfu.ca>,
	git@vger.kernel.org
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:01:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slnk5-0002vE-1k
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 23:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab2GBVBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 17:01:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754Ab2GBVBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 17:01:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C80C9A6D;
	Mon,  2 Jul 2012 17:01:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+KdQEi7B8IxBJbHlh1ZtsAUKdo=; b=QlUrO0
	dLQL19Vr67drBaG+z3uRjfIM15E7WuHheWE4xc+m5lGOlq6LblAdE7DeXWNkBnoV
	VEij5hkIvT/gmwB7nfvjwf0VAck8ZvlCqFYoLhN0gXr5/IYW986xnJ5y/4Ntxz8/
	dVGnFwjYQ2VQ6KXqFsZAooXD4/a3eD9PrdJkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LcAveJa4TQG0pygxqjFu3j7AHr/4Swhl
	4fkDGO+LYVovrEQ47WluJc+go3IKuSkBmbtVvK/qGo4qJqZlJA5eBOLHlDbwaTeU
	fYJgJdFjDJKFyvwpAVjKeALy9ncx0+TaOPwrkThfiH/sGmutFLVCP1UktCtadjhb
	BTT9Q4rtcgE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A8909A6C;
	Mon,  2 Jul 2012 17:01:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FCDB9A6B; Mon,  2 Jul 2012
 17:00:59 -0400 (EDT)
In-Reply-To: <CAPBPrnspD3uC6_wd7nqMUVgHSt4Frwy8UaYL6fU73kJKX6=XWQ@mail.gmail.com> (Dan
 Johnson's message of "Mon, 2 Jul 2012 15:52:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 067963BE-C489-11E1-951F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200861>

Dan Johnson <computerdruid@gmail.com> writes:

> Junio,
> I just noticed that the download buttons (for tarballs) on gitscm.com
> all point to the github tag list ( https://github.com/git/git/tags )
> instead of the location pointed to by your [ANNOUNCE] message (
> http://code.google.com/p/git-core/downloads/list )

Thanks for noticing, but what GitHub does is outside my control.
Luckily I see Peff is in the loop so this will hopefully be resolved
shortly ;-).

> If you do something special as part of releasing these tarballs, is
> this something that should be corrected?

I do not do anything special other than "make dist", but obviously
anybody's "list of tags" that drive "git archive" won't run it, so
it is a wrong thing to point at, regardless of who hosts it.
