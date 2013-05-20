From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] remote-helpers: test fixes
Date: Mon, 20 May 2013 15:47:43 -0700
Message-ID: <7vd2sltgj4.fsf@alter.siamese.dyndns.org>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 00:47:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYru-0002M1-5k
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295Ab3ETWrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:47:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914Ab3ETWrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:47:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 724C520297;
	Mon, 20 May 2013 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Za+IDI2DdKW/gfO6UviLQuhQIzM=; b=nsaQVKITeFZPNbKzJ4mU
	zrHm6fDGf/59UtRCQambVHXQwWeYn3Ty28tDd/5kZYkj0OLhz8Y97AWcL0F/FLnF
	ewzGpK5o4fFY25v+yGE6PUzjFS6aCohwaZ8YoHNLt8cNjUIkYIdC0Q4JPUshCVNp
	ke1QGa0kxypQkLKHq9UTA2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fEG0vWAa34/HePbIr8P62NAWMDzwIzuRCt9LPlr+px+WUp
	VFRP4n4h1VArpARaV3f8AoPkYRFujOUNe5rlSYGr/pPCildJpMrB0oqLOsxrk8Uj
	spO1gAY7ErqYD0XV6+A+PQ1GIlL63+DsWcrKbTYD8NvBc/py+3NyyPlKKtgD4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65C3320296;
	Mon, 20 May 2013 22:47:45 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD3792028E;
	Mon, 20 May 2013 22:47:44 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 495A9AE0-C19F-11E2-B98C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224992>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Hi,
>
> I've setup a project in Travis CI for continuous integration with very good
> results, however, I had to apply a couple of fixes.
>
> I'm not sure if this is v1.8.3 material, but here they are.

Thanks; I'll queue them at the tip of fc/remote-hg to graduate soon
after 1.8.3, then.

>
> https://travis-ci.org/felipec/git/builds/7262886
>
> Felipe Contreras (2):
>   remote-helpers: tests: use python directly
>   remote-hg: tests: fix hg merge
>
>  contrib/remote-helpers/test-bzr.sh       |  2 +-
>  contrib/remote-helpers/test-hg-bidi.sh   |  2 +-
>  contrib/remote-helpers/test-hg-hg-git.sh | 11 ++++++-----
>  contrib/remote-helpers/test-hg.sh        |  2 +-
>  4 files changed, 9 insertions(+), 8 deletions(-)
