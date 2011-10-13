From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] struct ref_list: document name member
Date: Thu, 13 Oct 2011 11:37:44 -0700
Message-ID: <7vr52g4u13.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <1318492715-5931-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 13 20:37:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQAC-00072T-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab1JMShr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:37:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699Ab1JMShq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:37:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70BED3265;
	Thu, 13 Oct 2011 14:37:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uyp+U3Afewj4C5awNlqzlO8jJis=; b=IGH/Lc
	Ztu1xtQj5GW1Lxbqgp+WSJRMo5cPQvHjtOTYcIjy4jTSDBkqInSL2RfxvvpUDX2U
	AtshaJeqH16UDDIhsGXh8gc/cOLnleqrMFd8wl5Ucv14t4+sAEfiNyh82PH0/gN+
	wRA9yZILh3QaJaqsIQJ6vU/8sr2lwcjt3GB6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h2BwTdMRILciBuDGAx9SfH8rw/kJbAHW
	/NyOnjpxOZdXXioWJZ66WIHZc58ooVRONYib4r1Wk/d92/XkML0vJni7MCwJz4d6
	X2LJmrE7kOD9L7PdbL9/KBZNF4kC90U+vhsuQdRcRnz4Eu7ILweGpbHrhLpC3p2Q
	CRSZvLW2Axw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6894C3264;
	Thu, 13 Oct 2011 14:37:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC3E73262; Thu, 13 Oct 2011
 14:37:45 -0400 (EDT)
In-Reply-To: <1318492715-5931-3-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Thu, 13 Oct 2011 09:58:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71A77E48-F5CA-11E0-90B2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183509>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 409314d..e4e4bcd 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -12,6 +12,7 @@ struct ref_entry {
>  	unsigned char flag; /* ISSYMREF? ISPACKED? */
>  	unsigned char sha1[20];
>  	unsigned char peeled[20];
> +	/* The full name of the reference (e.g., "refs/heads/master"): */
>  	char name[FLEX_ARRAY];
>  };

Thanks. Needs retitling the patch, though.
