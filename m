From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 09:54:10 -0800
Message-ID: <7vvccdhhod.fsf@alter.siamese.dyndns.org>
References: <50C22B15.1030607@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 18:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th286-00073w-OE
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 18:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423574Ab2LGRyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 12:54:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423536Ab2LGRyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 12:54:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1278C876C;
	Fri,  7 Dec 2012 12:54:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iEzhXbpJS5VuEM84FUCVRhvyZiQ=; b=pxLMww
	AwmQ9mYEg9abjbjI0OF2YIIx9oCJeTp+9dk1uVUaYc7TkQRsCQrEYG8ZCSzLkeqV
	AHGfYmdWKpbwukwLnFHnxTCWXhDRf6z8QdbZHp1Y9phHGtgmIPHHdqYxeX4bxMEy
	/l7gbJ+EJiOaJlnLYFWLD+NmqLRJOw2MTYNN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GdsyGMWAE+eZZEftVx/Ir8OLYiP3cAIU
	CaKgj+aY+1MSYCCTIeFuLW6UHZAauYnaTsdmVG4nP63KtIA8AMO26oGt1tSQWH9J
	6sH5Ju1uOLLnZzhErWE9kvAdhrBcRVt2/X1YsPI2SsDDU1aCWZfcnjmR+u1Lqsyn
	mHexQmSXszI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F41E6876B;
	Fri,  7 Dec 2012 12:54:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FE738769; Fri,  7 Dec 2012
 12:54:12 -0500 (EST)
In-Reply-To: <50C22B15.1030607@xiplink.com> (Marc Branchaud's message of
 "Fri, 07 Dec 2012 12:44:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BC4C828-4097-11E2-A8C4-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211183>

Marc Branchaud <marcnarc@xiplink.com> writes:

> This is with git 1.8.0.1 on all the machines involved.
>
> One of our build machines is having trouble with "git submodule":
> ...
> Any ideas?

How and why is the IFS set differently only on one of your build
machines?
