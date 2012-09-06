From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: strip all inappropriate tag strings
Date: Thu, 06 Sep 2012 10:41:54 -0700
Message-ID: <7v627r3v6l.fsf@alter.siamese.dyndns.org>
References: <m2y5knjzh5.fsf@igel.home>
 <1346949413-17287-1-git-send-email-ktdreyer@ktdreyer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
	Alex Vandiver <alex@chmrr.net>
To: Ken Dreyer <ktdreyer@ktdreyer.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:42:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9g5f-0002FW-AI
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 19:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631Ab2IFRl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 13:41:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932280Ab2IFRl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 13:41:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37DE990C8;
	Thu,  6 Sep 2012 13:41:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eRC4DoxlOnWKag6BQiFIuipBPqA=; b=XLvBeA
	q6J8SHVKwDCmVfKvZL4K/GZceCrXRAejw4cr97ZMTvabYIA2QpxLbp09/qWl/W75
	tKD27/J5zM/cxCSOiz8ROJxogJmOHTEKpYvVecrD39Uq/bi/xR5WtIXEI6koejNH
	CbaYgda/jknw3H40thIk79LfQ4vO4SVgX+K6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DyJH99ttjdxkwJGcIs3+IFsVCvcSkKJA
	sVPtepxvYktOgSnOFUOU9x2XghXZXevVgMaasvb7wiZ/rgx6YfZni0UOHAmTjtD8
	dxHmA6E3/CkqS6q2PhyysF5TBDQjc8/b/aVQa51AhoVVaIITv5uIUUNO7GKuinH8
	I24CyQ3KEd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25B0190C7;
	Thu,  6 Sep 2012 13:41:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D60090C6; Thu,  6 Sep 2012
 13:41:55 -0400 (EDT)
In-Reply-To: <1346949413-17287-1-git-send-email-ktdreyer@ktdreyer.com> (Ken
 Dreyer's message of "Thu, 6 Sep 2012 10:36:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 268CF7E8-F84A-11E1-B900-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204907>

Ken Dreyer <ktdreyer@ktdreyer.com> writes:

> Thanks Andreas for catching that "ref.c" in the comments ought to be
> "refs.c". I've corrected that in this latest version of the patch.

Yeah, thanks, all.  Will queue.
