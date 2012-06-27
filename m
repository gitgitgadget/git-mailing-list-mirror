From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add test case for rebase of empty commit
Date: Wed, 27 Jun 2012 14:02:34 -0700
Message-ID: <7vr4t079jp.fsf@alter.siamese.dyndns.org>
References: <1340814121-23813-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:02:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzNq-0003cV-R6
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099Ab2F0VCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:02:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab2F0VCi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:02:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6080199D4;
	Wed, 27 Jun 2012 17:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I0FpqbtOggUnx/49qQzjbNuj0qA=; b=AalYZ7
	/iMiAo9mmidtZmuIu1er756zgHwqVrlla74wI2zbrfsM8pE5m4DVI5ptWuYVeUrS
	zTlnuA29Vedj6nL6MZiE/zNjuOYCKD4g7QYc83QZIDUQhDEu+zh0B1LsdqdJ3cYE
	vDsKWlDcDeTZo6FLiPPH1TWaU+LYs375z2Wyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Levvr2buLiC0ZX9raJ84D45KkbkrOvR8
	mKkx74CJXHRbyvQvozV1eyv/WQG6dpU6+rnS1P7RGV+Wp7fisPp+Vc0gOyjM00P9
	MpfsxA5UgALOaq+VTi0WB63H66C5LIaRtyq7r+qsxEJHiQ8SbidBNlRvOWmq+QQg
	M5YcXFuyrBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5603499D3;
	Wed, 27 Jun 2012 17:02:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB8E299D1; Wed, 27 Jun 2012
 17:02:35 -0400 (EDT)
In-Reply-To: <1340814121-23813-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Wed, 27 Jun 2012 09:22:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BDA3680-C09B-11E1-B74E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200752>

Thanks.

We recently had a topic to add an option to allow rebase to carry
empty commits forward, but I notice that it only had tests for the
component cherry-pick to keep empty or redundant commits, so it may
not be a bad idea to add tests for that series to the same t3401
after this commit (Neil Horman CC'ed).
