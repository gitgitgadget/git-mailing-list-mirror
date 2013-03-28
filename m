From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t5520 (pull): use test_config where appropriate
Date: Thu, 28 Mar 2013 07:50:57 -0700
Message-ID: <7vy5d7wpbi.fsf@alter.siamese.dyndns.org>
References: <7v4nfz1ndo.fsf@alter.siamese.dyndns.org>
 <1364474419-22796-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 15:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEAr-00009O-B3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 15:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314Ab3C1OvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 10:51:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756158Ab3C1Ou7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 10:50:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42B01A510;
	Thu, 28 Mar 2013 10:50:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xIcnui+P+jnzxP0k6GpgUUmK75k=; b=aTmEzU
	YV244Qa1dQQdQlkY9iP+JW1xxt7ngPJR4zJIX8Kk3yOX7Way2Ezspn9ohuZvBs16
	j+4o4EAd6t5jX7nWDHUNv0lziOTAS6A95sEzxIKAo8+UZMdtkbsQo2qDITca7hZS
	NpS7xYE1CaKOwFTLBWZhKmKZwu01HU+GFYbjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KLy3CVd30LL81g+DOwxP8dyhv/QwzmSg
	WYvH0hZ/cBUTO44MXDgZREbpORqIho562sHYj+SlDvC12VSCVUf16v5iTgetpHG2
	OojXeBbF4Bk8754BFUxsj4VFWuiCc6fMTHstpk8AUHCBhmtKJiHka7GVkP0v+eea
	UvSOxVY7vAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38D30A50F;
	Thu, 28 Mar 2013 10:50:59 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5202A50E; Thu, 28 Mar 2013
 10:50:58 -0400 (EDT)
In-Reply-To: <1364474419-22796-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 28 Mar 2013 18:10:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6DB1528-97B6-11E2-933E-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219402>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Configuration from test_config does not last beyond the end of the
> current test assertion, making each test easier to think about in
> isolation.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Removed first hunk, as per Junio's comment.

Thanks, but doesn't yd/use-test-config-unconfig topic already
address this?
