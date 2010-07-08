From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/6] Add additional testcases for D/F conflicts
Date: Thu, 08 Jul 2010 09:03:30 -0700
Message-ID: <7vaaq2q7u5.fsf@alter.siamese.dyndns.org>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
 <1278480034-22939-2-git-send-email-newren@gmail.com>
 <7vocejt25d.fsf@alter.siamese.dyndns.org>
 <AANLkTinVyfWEqJqZgpiXv0hvMLELLb-UThi-0W2izGQc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 18:03:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWtZl-00073D-3P
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 18:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908Ab0GHQDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 12:03:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab0GHQDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 12:03:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 626BDC2B46;
	Thu,  8 Jul 2010 12:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SA2W95/Tvtn863sBnG/IL4KTtwM=; b=kVIYky
	vYN++XzaT0QvgUDAEZSpSVtkx8erdtSflPyeWpIsmbnMXW97gOD1MJME5pTfNxH3
	XCa7Vph7OAJeibuSDmMXQpHZkrcLl8ZlqrdK0rawjPqhwN4wN4ZcnFVOqxN9g0a1
	el44gh+uu1PXYAbZ7KKzUmoPcnrq+znwxd8qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o3UL4s/7drcN4kaxPFRSb8wGIi7x1UBT
	3vTvJCdRGL+7F+meKo7hQIe+TlCGxYsfFAdsasUCiLz3aQ6UKSHYRzv3NjsXwOf9
	EKzEhkxXySoRe8UA9WxnNhcfqoOLvRFwrynpTveo7nnrUXI5US7IlQO/w3xh2ViB
	jTu2e1xjGRQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 163DAC2B3D;
	Thu,  8 Jul 2010 12:03:37 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DDABC2B38; Thu,  8 Jul
 2010 12:03:32 -0400 (EDT)
In-Reply-To: <AANLkTinVyfWEqJqZgpiXv0hvMLELLb-UThi-0W2izGQc@mail.gmail.com>
 (Elijah Newren's message of "Wed\, 7 Jul 2010 21\:07\:53 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E00DB64-8AAA-11DF-B948-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150584>

Elijah Newren <newren@gmail.com> writes:

> I'd be happy to make these and the other changes you suggested, but I
> notice that you've already done so in pu with Fixup commits for this
> and the other patches.  Should I squash those in for a resend of the
> series?

Yes, please; patches being in 'pu' does not have much more weight than
them being in the mailing list archive.  The patches should have warts
these separate "fixup" patches had to correct removed before they advance.

Thanks.
