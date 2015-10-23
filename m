From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make "git checkout" automatically update submodules?
Date: Fri, 23 Oct 2015 10:15:48 -0700
Message-ID: <xmqqk2qdpku3.fsf@gitster.mtv.corp.google.com>
References: <loom.20151016T001449-848@post.gmane.org>
	<xmqq7fmnhg4x.fsf@gitster.mtv.corp.google.com>
	<loom.20151023T013752-72@post.gmane.org>
	<xmqq37x2qqzf.fsf@gitster.mtv.corp.google.com>
	<loom.20151023T044009-172@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kannan Goundan <kannan@cakoose.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 19:16:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpfwy-000107-4d
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 19:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbbJWRPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 13:15:54 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751139AbbJWRPy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 13:15:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AA4F243C5;
	Fri, 23 Oct 2015 13:15:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rC8g8mHWB6ODNDHXXEVFcHl1fNg=; b=r6yY++
	7dt8ZNaOacNZG8ZwKfl9V9U5q3RmH0QvLvOn/4nPZ75WjFCdPLzNQkndaudLkKy6
	8+D/64matiBJgVKZGAQ3DDXQC0gtnow+KD5qGWproPK33msROK59fAkDMU0DwWSz
	R02bdjScaXZIWHAb5t6xJaKZXcjQ1YetfJ7Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eeG8sx4gPTDVAzO+nuCy2ILLTOcaVfbh
	F4mDfR/BiIH9ezPO+yHDYlXuhSHmrb1nnat7UtBvhoo8uqyC7Vc+pvJhNTYn2I5q
	TD+OxFyjmeRgCQBKFffaLbPYFtV3g5knVo1KxAenMteIxkgcNGUm2UgXqb8KCLxH
	z5D3VOGlefY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02641243C4;
	Fri, 23 Oct 2015 13:15:53 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1AF98243C3;
	Fri, 23 Oct 2015 13:15:52 -0400 (EDT)
In-Reply-To: <loom.20151023T044009-172@post.gmane.org> (Kannan Goundan's
	message of "Fri, 23 Oct 2015 03:46:47 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6661A1E-79A9-11E5-8A5A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280100>

Kannan Goundan <kannan@cakoose.com> writes:

> I think the way I described it ("sponsoring a feature") doesn't really
> reflect how I was imagining it.  In my head, it looked like this:
> ...
> I could try doing that myself, but someone familiar with the Git
> codebase/community/history would be better at it (and probably be easier for
> you guys to work with :-)
>
> I guess I'm just wondering if there are people who meet those qualifications
> and are interested in going through those steps for pay.  Or maybe there's a
> company that does this, like the old Cygnus Solutions?
>
> In particular, I don't expect anything to change about the project's
> development process.

In other words, the sponsoring entity is paying for effort and not
for result--money does not buy inclusion.

That may be workable from the project's point of view; I however
wonder if that is workable from the sponsor's point of view.  Things
that may be problematic inside the sponsoring entity (i.e. between
those with money and those who interact with the hired person)
include:

 - Does the hired person really meet the right qualifications?

 - Did the hired person make a good faith effort?

 - Was it the right time to start the topic, or was the codebase too
   much in flux at the moment to accept work in that area?

But these are problems between the sponsor and the hired person and
do not concern us ;-)
