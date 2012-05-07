From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH master] git p4 doc: fix formatting
Date: Mon, 07 May 2012 11:14:27 -0700
Message-ID: <7vk40n6epo.fsf@alter.siamese.dyndns.org>
References: <20120506155650.GA12106@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon May 07 20:14:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRSSB-0007eF-AU
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab2EGSOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 14:14:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462Ab2EGSOa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 14:14:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF3FE6D66;
	Mon,  7 May 2012 14:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SPjApClAl20n6jR1JaQQFzl2Kqo=; b=Bsp6sk
	92ALdN8ZKWyTbWSmg5RHWzS3JJZ2awjIz+av8yQ+VUI0BKzSdidHLTXgDeAXcb+3
	PpN0RdTqJjmuTsE+jizcQGOqLZoM09XKM+UH/2vq0csluJoIN81cnEUXzYsjV/dv
	Ybgqc8DJC5Vyhn701oJyBXPS+P5JCV2R1yCjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tjuSg+ko0bDvDEgEmEcyBsFSKYspsfq4
	9WBZXASEh0BWUdy52ozkMoeGfOnAqslYfBHma3fXwQoX48gNwyXRwHnvqk5FnyrS
	u6uv9fQvCRueZG15sfdHJOkbgNbEZ3ORpkuAOLpyp8UgmzRFNyL//X8opBYK+vKy
	7LSIWEvgjk4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6FAD6D65;
	Mon,  7 May 2012 14:14:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77F6A6D64; Mon,  7 May 2012
 14:14:29 -0400 (EDT)
In-Reply-To: <20120506155650.GA12106@padd.com> (Pete Wyckoff's message of
 "Sun, 6 May 2012 11:56:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CC71312-9870-11E1-970D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197292>

Pete Wyckoff <pw@padd.com> writes:

> Attach example sections to previous level of indenting.
>
> Fix a trailing ::
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>
> The nice git-scm.com redo made me proofread this doc.
>
> Patch on origin/master.
>
> Even though this looks like a job for maint, both hunks
> will collide there.  maint version follows.

Will apply the 'maint' one and merge it up to 'master', and will use this
as a reference to avoid mismerges.

Thanks.
