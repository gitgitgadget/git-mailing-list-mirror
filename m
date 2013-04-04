From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update pasky's email address
Date: Wed, 03 Apr 2013 23:43:59 -0700
Message-ID: <7v38v6lrrk.fsf@alter.siamese.dyndns.org>
References: <20130404015042.GA19593@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Marcin Owsiany <marcin@owsiany.pl>,
	Thomas Rast <trast@inf.ethz.ch>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 08:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNduS-0006k3-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 08:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763449Ab3DDGoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 02:44:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756012Ab3DDGoC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 02:44:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4D8811E1F;
	Thu,  4 Apr 2013 06:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4vW8BAM0xArFzozZJU5J519OW0A=; b=KJNAQZ
	laB9Ok2+p+qRhvYHA+xsh2zSSbrtohCValsBT81Dsul5kTyqitOKViWrncJsYqWL
	hTNUy3rOx2I1ot9atf8skiiFasNEIgj/5yBsS/DOqe8/jK02aRqyWPpWrKeGNnau
	jBcKNka+L5CLw5eHuHvvOnQtHvCKyT0pxLYCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HrnBHGY88BJdZBJ/c32BpTkGeqvJGhy2
	pEOHBJFdzxBJ4W2K8euDwsX3bz+WYG2v9v/4uOCyEWwwbh656mhdIAa+WJ1bCq6y
	epbGi2eXFxYRcyQDBgU2VE1U8ybM7XSajZjy7U5csaHPigD35EO6LWJ7HwuhK3ue
	Yfxm4Hdq8gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D8C611E1E;
	Thu,  4 Apr 2013 06:44:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F60011E1D; Thu,  4 Apr
 2013 06:44:01 +0000 (UTC)
In-Reply-To: <20130404015042.GA19593@dcvr.yhbt.net> (Eric Wong's message of
 "Thu, 4 Apr 2013 01:50:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08B1A05E-9CF3-11E2-BBAF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219989>

Eric Wong <normalperson@yhbt.net> writes:

> Mail to pasky@suse.cz is bouncing.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  I noticed this when I attempted to reply to Thomas's email:
>  http://mid.gmane.org/f3d238a4c6cfbc6d68f2c4fa285aefa93acf4b7d.1365027616.git.trast@inf.ethz.ch
>
>  .mailmap                                            | 1 +

Thanks, but I wonder if an entry update to .mailmap alone is
sufficient.

Especially, a change like this:

> index db6eb50..e162ec9 100644
> --- a/gitweb/static/js/blame_incremental.js
> +++ b/gitweb/static/js/blame_incremental.js
> @@ -1,5 +1,5 @@
>  // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
> -//               2007, Petr Baudis <pasky@suse.cz>
> +//               2007, Petr Baudis <pasky@ucw.cz>

makes me feel very uneasy and feels outright wrong; unless the
change by Petr in year 2007 was associated with the ucw.cz address,
not his then-current employer, that is.
