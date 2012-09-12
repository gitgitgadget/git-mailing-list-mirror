From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Rename 'tagcontents' to 'cached_tagcontent'
Date: Wed, 12 Sep 2012 02:25:28 -0700
Message-ID: <7v8vcffv93.fsf@alter.siamese.dyndns.org>
References: <1347130993-69863-1-git-send-email-davvid@gmail.com>
 <1347133996-70908-1-git-send-email-davvid@gmail.com>
 <7v392ru6ex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Tim McCormack <cortex@brainonfire.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Sep 12 11:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBjCV-0006yc-7R
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 11:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782Ab2ILJZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 05:25:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463Ab2ILJZa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 05:25:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57D3D8070;
	Wed, 12 Sep 2012 05:25:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wstQ2jDmJawDlYODucwghu4Q1NU=; b=G6idtB
	eHXoIlIRunk+vkEblGInbLtluhN2jU1kY97xdywLlM5sBlPDKdHnv/WcrBDnUpla
	Uj2O11UrajhAPLtcNqgnIOdj+LzKy9BCgjzPR7PkTCriKsOvWMugvtNYv6k1VtnO
	HQ6Ugakc4UDyGWtnAFwZbESWmOZExNNEkCeGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uH5fWzyrRMEfOHZVmqNTwDPlG0Up0QAU
	RXQ0Ftb3PYMSwwHYJq+ZIViQWtgSSI8nK0EWmmTrIQjYTsmIr3GLuUmhpWmSPGA9
	LvXe92k6189AX5xx4uPkGaBNUpcXyqNB3oTZbsLmeg2uUlsUd7ale15BGX9xT9a4
	HzZ/fnH/hS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 458D7806F;
	Wed, 12 Sep 2012 05:25:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B69E806E; Wed, 12 Sep 2012
 05:25:29 -0400 (EDT)
In-Reply-To: <7v392ru6ex.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 08 Sep 2012 22:11:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB3983C2-FCBB-11E1-AA08-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205272>

Junio C Hamano <gitster@pobox.com> writes:

> I've applied these two, on top of Paul's master branch at
>
>     git://ozlabs.org/~paulus/gitk.git
>
> and tentatively queued in 'pu', but I would prefer to see it
> eyeballed by and queued in his tree first.
>
> Thanks.

Pinging Paul...

The following changes since commit a135f214e371311f13807da637d492fd9642a2e3:

  gitk: Avoid Meta1-F5 (2012-04-25 13:44:31 +1000)

are available in the git repository at:

  git://github.com/gitster/git da/gitk-reload-tag-contents

for you to fetch changes up to 587277fea3bf3bfc4302480178bd88a277a69f05:

  gitk: Rename 'tagcontents' to 'cached_tagcontent' (2012-09-08 20:25:09 -0700)

----------------------------------------------------------------
David Aguilar (2):
      gitk: Teach "Reread references" to reload tags
      gitk: Rename 'tagcontents' to 'cached_tagcontent'

 gitk | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Thanks.
