From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] misc cleanups to path functions
Date: Tue, 04 Sep 2012 12:24:12 -0700
Message-ID: <7v627ta8wz.fsf@alter.siamese.dyndns.org>
References: <50463981.2020701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:24:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yjX-0006Ma-9a
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625Ab2IDTYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:24:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757582Ab2IDTYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:24:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF67F82EE;
	Tue,  4 Sep 2012 15:24:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=43Xkfe26G0Bw41TZ5zAqYGjhFAc=; b=U6AimE
	25RZpomtsebd3A8VgqoP6uvaqZC2XN+mWx0pyXUf/CjnaLsAP0aNR1Yh+ur2dzux
	sifJuwT7j+RgankWjzq+mX/JeHOotu44uxQUdyS8OZdk0J4GY4hf0kSVFBt8+GeQ
	286EIhuneOKM7mxAny8PcCGuKTW+lZzMZ7AQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aCuXJBeLCJE0UNyImpbytpUXriqlrAaj
	YPFvWDobaCG+BFuaz38rP+Mb7MKNk0aYYt/layzI9oUYT92vYnFJqyJQdaXiAx7S
	N65+DJCak15Y/MURc/tDI3iFvZWkMLYTML0UhfdJa6qhAJqMXcbxURp8qdIyDApS
	tRxlWOtjG4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCECD82ED;
	Tue,  4 Sep 2012 15:24:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32BE182EC; Tue,  4 Sep 2012
 15:24:14 -0400 (EDT)
In-Reply-To: <50463981.2020701@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 04 Sep 2012 18:25:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CA201F4-F6C6-11E1-B1F8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204778>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> These patches are from another unfinished branch. However, this
> time I can't remember why it's unfinished! ;-)

That scares me.  Perhaps you found some hard-to-debug problem but
didn't have time to follow it through, or something?

;-)

Thanks.

>
> ATB,
> Ramsay Jones
>
> Ramsay Jones (5):
>   path.c: Remove the 'git_' prefix from a file scope function
>   path.c: Don't discard the return value of vsnpath()
>   path.c: Use vsnpath() in the implementation of git_path()
>   Call git_pathdup() rather than xstrdup(git_path("..."))
>   Call mkpathdup() rather than xstrdup(mkpath(...))
>
>  bisect.c          |  2 +-
>  builtin/add.c     |  3 ++-
>  builtin/branch.c  |  2 +-
>  builtin/clone.c   |  4 ++--
>  builtin/prune.c   |  2 +-
>  merge-recursive.c | 13 +++++++------
>  path.c            | 28 ++++++++++------------------
>  7 files changed, 24 insertions(+), 30 deletions(-)
