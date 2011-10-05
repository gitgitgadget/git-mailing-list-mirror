From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 66 patches and counting
Date: Wed, 05 Oct 2011 14:36:01 -0700
Message-ID: <7vty7n5dfi.fsf@alter.siamese.dyndns.org>
References: <4E8CCC55.9070408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:36:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZ8O-00016x-0K
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab1JEVgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:36:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab1JEVgE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:36:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C1D562A8;
	Wed,  5 Oct 2011 17:36:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=am8oNKdPzwZxT5Vktcd+LiYIyRE=; b=M+QB4z
	bc1/tJwn9DhfuNdEEpEyUNU/50lS0TJ93t3mITe3RlhwShV4bLs5NZbaw88JJnp4
	55PbYv7Fk5OdAEoCtOGxVnFHMaMDU+H3sYX0Nx+GaunqnP1Us4GLWs1tPFmZ/iyh
	xomXYfFUO5ExOaCAjqdshan6BpJUTl7vg+cv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mbrTUVShoEsm+UfNBneOtxbiFNOp11+8
	i+nvWeOGCSERc2ZUuaKzSZ6//Rv27ObUxvzfhmCwBcEgltRdQ3Vb0ZYAzUaZLzR0
	26yycBtaGjWurcVVBZBxp99FnxPu/M6OZQxBtphCwxzoIi7J2M9NNgUzxby5lpEc
	WhPdo24FzWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8337F62A7;
	Wed,  5 Oct 2011 17:36:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3C6062A6; Wed,  5 Oct 2011
 17:36:02 -0400 (EDT)
In-Reply-To: <4E8CCC55.9070408@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 05 Oct 2011 23:29:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0641C522-EF9A-11E0-AD52-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182888>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> When I'm done, is it OK to dump a patch series like that on the git
> mailing list?

Bits and pieces that are of digestable sizes. 

I would wait sending anything large-ish (like more than 10 patches) before
'next' is rewound, which is the sign the cycle is in full swing.

> Is it pointless because nobody will review them anyway?

Bits and pieces that are of digestable sizes. Especially given:

> I like to make changes in the smallest irreducible steps

each step in your series should make sense by itself already (otherwise
you would have rebase-i'ed them to collapse too-small pieces into one that
makes sense standalone on top of the earlier steps).

> Is a big pile of changes like this welcome in any form?

Bits and pieces that are of digestable sizes.
