From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree
Date: Thu, 05 Jan 2012 07:53:36 -0800
Message-ID: <7vboqino1r.fsf@alter.siamese.dyndns.org>
References: <nngaa638nwf.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Greene <dag@cray.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 16:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RipdQ-0001AC-Sl
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 16:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591Ab2AEPxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 10:53:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886Ab2AEPxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 10:53:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D55A2523F;
	Thu,  5 Jan 2012 10:53:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XmRhJP4SjqfIcIaPocsSeiUReAc=; b=QbuasQ
	ra2g3p5cqnvn0kOeN0GC86Z91jDm9hD9eUdt+w6eq2Cr68WzqDrNZZ9hcUlc846+
	I1dqZGUZD9toCi4Rr+8mfX3A3/83o1gxQqcN9pl3FRRM2Kto85Yaao3iOman0t5Z
	+Wy1haczFfwfb4Hu2tHsUKB49Wtv2LowjgHik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WUCfYPlXYR73U9mBJizoKEODGjxwcvTA
	iIqB8jKMPimTBnMaecatwTyfELCkI20a49NDVKaTvWBGoNn7uDlkF9XA73xfitYu
	6AFd5/r2jSaafTbp8+ZZH2uLazU4HhMu3WHzfkEbSWcVp8GsISmFTGxNVq7QgVGl
	S2Ix4tjiFtk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC8A1523D;
	Thu,  5 Jan 2012 10:53:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64F9D523A; Thu,  5 Jan 2012
 10:53:38 -0500 (EST)
In-Reply-To: <nngaa638nwf.fsf@transit.us.cray.com> (David Greene's message of
 "Wed, 04 Jan 2012 09:53:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6EBC0BFE-37B5-11E1-A008-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187985>

David Greene <dag@cray.com> writes:

> How does the git community want the patch presented?  Right now it's one
> monolithic thing.  I understand that isn't ideal but I don't think
> incorporating the entire GitHub master history is necessarily the best
> idea either.

It depends on the longer term vision of how the result of this submission
will evolve and more importantly, where you fit in the piture.

One possible answer you could give us might go like this:

    The longer term vision is for "git subtree" to become, and be
    developed further as, an integral part of the core git suite.

    I have been an active contributor to the "git subtree" project for
    quite some time, and am very familiar with the code. Avery has been
    too busy to properly take care of the maintenance of "git subtree",
    and expected to be so for the foreseeable future. I will address any
    issue raised during the initial review and will be taking over its
    maintenance and further development.

    My plan is to put this first to contrib/ area, keep it there for a few
    release cycles while ironing out remaining kinks in the code, and
    eventually make it one of the "git" subcommands. Avery's external tree
    will cease to exist as future development will happen in-tree in the
    git repository.

Your answer might differ, of course, but the point is that we would need
to weigh pros and cons between inclusion of it in the git repository and
keeping it in Avery's repository and have him and his contributors
maintain, enhance and distribute it from there, and it largely depends on
the nature of the submission. Is it a "throw it over the wall" dump of a
large code of unknown quality that we need to clean up first without
knowing the vision of how "git subtree" should evolve by original author
and/or people who have been actively developing it?
