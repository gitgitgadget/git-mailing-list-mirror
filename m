From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] test: git-stash conflict sets up rerere
Date: Thu, 16 Aug 2012 15:00:08 -0700
Message-ID: <7vehn6zedz.fsf@alter.siamese.dyndns.org>
References: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
 <1341693962-17090-1-git-send-email-hordp@cisco.com>
 <1341693962-17090-2-git-send-email-hordp@cisco.com>
 <7v8vetmzgz.fsf@alter.siamese.dyndns.org>
 <CABURp0rrTvQcjHLsVwXC5hfBOuRmFG4AzSj6ZQwM=MXn0FAUCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 00:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2872-0002vx-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab2HPWAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 18:00:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab2HPWAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 18:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5504F9B4F;
	Thu, 16 Aug 2012 18:00:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Am9DOBMFaUbclVIrhjLV9Z1VMqY=; b=pa3/2I
	vELgNdVKvFgw0lQAeMfMTifROFYJmAOxgewAcx0mj8IQNLr02yf8NrAGmmhotsY+
	om06uIPs7ZpfX0ucTppUCw7yQz1MagbShY9ZcIsvzLRPklwhAnX6vad9vWIU9gUP
	/JG5IORLTmZtsL7GjhRyz1Qr+O/94pp+gssRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kI1OBsC7jUYw0i9sHtWQn/GaOIr2NUhW
	v7wrSW5Y2hOm/f52BdVaBosFhuNasoM5q1n9xZcF9FaeAneQogq2xo8rp2M1M9Z1
	MAGDMvYwtUG1cMQ3BEjY01TTmlL2KtG7cft8ggeNV6YB4LbibAhn8Qz29azzLgkp
	mLd1vvFvBZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4197B9B4E;
	Thu, 16 Aug 2012 18:00:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDA8A9B49; Thu, 16 Aug 2012
 18:00:09 -0400 (EDT)
In-Reply-To: <CABURp0rrTvQcjHLsVwXC5hfBOuRmFG4AzSj6ZQwM=MXn0FAUCQ@mail.gmail.com> (Phil
 Hord's message of "Mon, 9 Jul 2012 10:41:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF23452E-E7ED-11E1-A051-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> So, the next roll will remove the tests for MERGE_RR and will be more
> explicit about the potential for mergetool confusion and/or the fact
> that it is not explicitly tested here.
>
> I'll wait a little longer for any further comments.

Mild ping to a seemingly stalled topic.
