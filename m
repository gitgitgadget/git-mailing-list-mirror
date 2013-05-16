From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Wed, 15 May 2013 22:36:53 -0700
Message-ID: <7vip2j8ozu.fsf@alter.siamese.dyndns.org>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 07:37:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucqs9-0006TQ-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 07:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab3EPFg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 01:36:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab3EPFg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 01:36:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2F1B1A8ED;
	Thu, 16 May 2013 05:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VE2NEUeqeYqIPx08Vs0PDn/k9KU=; b=DRPel4
	wD5aVGVy7Uw9rI9xtilhgkaAPLShfTyGB6jl4O2I9/5wR6dddC3q/jINOcl1Yb4q
	YYM1lB6vZTOWR8buQ9WfsUg72iPKa+fAzzuo/uKAMIJRK1EBgC+Ynbr9pGeA0olC
	hPybtJcAc+E2v2WZnpZrYmhKRYkApBE/qeAaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yQ8SfnBCGQOenhX+eIriYypf3d092QNE
	xOrauDQhvL1EdgcUpr5R42F8pLnQDcZDQSR6/HMoi5/ufJ6JDClqcbhb7qqa4J1l
	rqG6ON0faVpS+6iM/tSqDCBvf7WbfQ0nNZ65N0NmEbuTY0PB7IxQ+LpWnskBH4ah
	4/a4cZ/dlvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 926531A8EC;
	Thu, 16 May 2013 05:36:55 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16FD71A8E9;
	Thu, 16 May 2013 05:36:55 +0000 (UTC)
In-Reply-To: <1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 15 May 2013 22:43:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E5761E4-BDEA-11E2-84E4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224479>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It doesn't make sense to push to the upstream branch, so create new
> configurations for the notion of 'downstream' branch, which is basically
> the branch to push to by default.

It doesn't?  That depends.

To people coming from (and people who are still using) central
shared repository workflow, pushing to anywhere other than the
upstream makes no sense.

If qualified with something like "When using a triangular workflow
to pull from one place and push to another place" in front, I can
see why having a separate upstream and downstream makes sense, and...

> The upstream branch is remote+merge, the downstream branch is
> pushremote+push.

... this is a perfect explanation of what a downsream is.
