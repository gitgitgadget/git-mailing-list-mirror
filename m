From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] remote-helpers: rename tests
Date: Wed, 29 May 2013 10:14:45 -0700
Message-ID: <7v8v2xvhbu.fsf@alter.siamese.dyndns.org>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
	<1369449507-18269-3-git-send-email-felipe.contreras@gmail.com>
	<7vmwrezx7n.fsf@alter.siamese.dyndns.org>
	<51a56ce142986_807b33e18100084@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhjxf-000593-OZ
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757777Ab3E2ROw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:14:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825Ab3E2ROu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:14:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EE3F23952;
	Wed, 29 May 2013 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JS6NWRq0e10h1kXXjDnY7HbjPWE=; b=Ozs/BN
	/L/QArUn7Ye/tbIwSA4V8IzUzk4J0vmmMCpKZ6HDY1NySFK3sXAZDUUohf15hYpv
	hNOPzcSJKpfGk20QAjQfDprcGVUSRUxjjTkomeOU8l4Vsxw+rSHY5TVaYGqjeEop
	yIq4BLp/IV5TfqJriXz2N2qbxgXSiCJ1oLW6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nE+YG2DkoL05jQsCO6iw6xokpTVVwhnh
	NR3P/9f2GS+czdmoamWgpLUQX3grVGH/GVTVsjGfssaJOEZDgEYZr3bkyeZJwAzi
	skZ6sTKGb3bxuzckKPnSm9e9EsVAgGY4xKZh/zgzx0NeapM4WQMPTMJIPzkG4nNx
	0E1rrSsgGvk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10E3123951;
	Wed, 29 May 2013 17:14:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56F3923950;
	Wed, 29 May 2013 17:14:49 +0000 (UTC)
In-Reply-To: <51a56ce142986_807b33e18100084@nysa.mail> (Felipe Contreras's
	message of "Tue, 28 May 2013 21:50:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44B7C2F2-C883-11E2-B427-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225846>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I do not see how it makes sense to copy how they deviate from us
>> back to our codebase, especially if we plan to eventually move some
>> of these tests out of contrib/ area, but even without such a plan in
>> the future.
>
> They deviate from us, we deviate from them, whatever. We are a single project,
> what more than one project does is more standard.

We are a single project, so it is better to consistently follow the
local convention established here.

If your proposal were to

 - Convert t/*.sh to end with .t intead, to change the project
   convention, and

 - Make contrib/ things also conform to that new convention.

it may make some sense to discuss the pros and cons of such a move,
but changing only contrib/ has no effect other than making it even
less consistent with the rest of the project.
