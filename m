From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] VCS helpers
Date: Fri, 04 Sep 2009 00:04:28 -0700
Message-ID: <7v63bz198j.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0909032213120.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:12:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjSyH-00021u-KD
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 09:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933093AbZIDHGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 03:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933201AbZIDHGH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 03:06:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933191AbZIDHEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 03:04:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A69084318B;
	Fri,  4 Sep 2009 03:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=10FsSXs6wPNyXgbJXW0DaD+3PoE=; b=uwl2KOaR9yolrzdJgd+fyIq
	PmDHjqS7l1z4axBV7aLHGdluWuNERjrIkoTqAdn27RI/uEAVTvyr+1OeOzBSASWD
	mwACQzsS7ZWZKox8fbDAXMmFxigQXDTUb1zblPT3SdaPsAHf/sUz5AxhEXp4Xhqd
	xjBgxWElGoKamVlMPo7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KpiuJNfQX/aEsnOjEnjirEnjbmgmPjeYbMbs0M4pY8IPxZf/4
	nG0XypxfcxPpJ3/Cp8+mKIwEhikT3b9qlLAmrFxd7pN8rkEnaIpCZsQPjDgTSd9R
	N8oKMr6F50MX/dA/Uh5DhPeSvoIZkYBBGaOt3xLyGoYEnoUmvMvP74EyEg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 740F64318A;
	Fri,  4 Sep 2009 03:04:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE5ED43189; Fri,  4 Sep 2009
 03:04:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 352A65E6-9921-11DE-AF46-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127688>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This is the next version of the db/vcs-helper series in pu.

Thanks.

> The first patch is new, a rework of the remote-curl build to produce
> "remote-curl" and call it as a special case for the sorts of URLs that
> we accept as indicating something that it now handled by this helper.
>
> The series is rebased onto current next, with some conflicts resolved.

Because the theme of the topic does not have anything to do with fixing
the deepening of shallow clones nor giving an extended error message from
non-fast-forward git-push, I queued the series after reverse-rebasing onto
old db/vcs-helper~8, in order to keep the topic branch pure, instead of
merging unrelated topics from maint, master or next into it.  The result
merged in 'pu' obviously has to match what you expected by applying the
patches on top of 'next', and I am reasonably sure it does.

> Two patches have been dropped: a memory leak fix for code that was
> removed entirely by the first patch, and the "mark" helper capability,
> which is not needed (I believe) due to the "option" fast-import command.

Johan's cvs-helper series were depending on the previous iteration of this
series, but I thought it is being rerolled, so I'd drop it from pu for now.
