From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] No diff -b/-w output for all-whitespace changes
Date: Thu, 19 Nov 2009 14:06:19 -0800
Message-ID: <7vbpiy9nl0.fsf@alter.siamese.dyndns.org>
References: <1258665144-26520-1-git-send-email-gbacon@dbresearch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Bacon <gbacon@dbresearch.net>
X-From: git-owner@vger.kernel.org Thu Nov 19 23:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBF97-0008IG-7F
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 23:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658AbZKSWGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 17:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbZKSWGV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 17:06:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbZKSWGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 17:06:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7559881ADB;
	Thu, 19 Nov 2009 17:06:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OI6EPVwJNdLAE6tdJw8+Iew2Hx0=; b=pdO2ow
	5ycS9KSYAq/X0pLjD5tRfx+eISAFfvNyP3+syXiSSH5NUTi3lL+zCUYMGXmZZrn7
	HJ1gXuMI+nXBZg+FcIP6zUNxlSRdC4mTXUAQ8QnpBUlNYB3xmLjdUR72soBXukWK
	KfGxu+CR5Cae09tnrbeeGakPz5BwrEivfKAH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=do3l6g/q/ikbqSA7TCuRLVqsroUqkTQG
	MQCpSG77hJ5YbUbjXhZM/MO8NpHjMDZc9qtz1fyMaJUE+SxAIoD7Y4yWnP2gHLNc
	55ojUiKi7B634Wp5B8lk+sN4iLhPN8kNRr6gkdeC+4BpEWEzrWjX2uU/uRtmF9bV
	CgS+vL0sVUQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54FF681ADA;
	Thu, 19 Nov 2009 17:06:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B616F81AD9; Thu, 19 Nov
 2009 17:06:20 -0500 (EST)
In-Reply-To: <1258665144-26520-1-git-send-email-gbacon@dbresearch.net> (Greg
 Bacon's message of "Thu\, 19 Nov 2009 15\:12\:24 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6476DE0-D557-11DE-90F5-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133261>

Greg Bacon <gbacon@dbresearch.net> writes:

> Change git-diff's whitespace-ignoring modes to generate
> output only if a non-empty patch results, which git-apply
> rejects.
>
> Update the tests to look for the new behavior.
>
> Signed-off-by: Greg Bacon <gbacon@dbresearch.net>

Thanks.

I didn't read the patch carefully, but I think this is the right thing to
do and is in the same sprit as jc/1.7.0-diff-whitespace-only-status topic.
