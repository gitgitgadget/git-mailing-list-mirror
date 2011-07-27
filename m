From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] Disallow the empty string as an attribute name
Date: Wed, 27 Jul 2011 13:20:36 -0700
Message-ID: <7vlivjo479.fsf@alter.siamese.dyndns.org>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
 <1311689582-3116-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 27 22:32:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmAlw-0004H6-Pl
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 22:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab1G0Ub7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 16:31:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072Ab1G0Ub4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 16:31:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E493B4B;
	Wed, 27 Jul 2011 16:31:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=+ZlieFcz0JFT9rsHWA0waJMP6GQ=; b=R5cBMTDKCRIcIwkHAZKn
	YW4QSjtUhgrNjVyS2HN+1zsFsLZ82umYTwm6vBbzmXqy5pTC6XRyJXk7JYTSYbMn
	DxduqAWl4XXTkICnDYCOfhHwx8vRfv9SYKEZPdZZ+vCZVTGQVMT1JibzHVkci+FA
	r4U/SU6AHZJSUmoUhZftQjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Plr537+Hk7kdbJUw/EjPAhHcahZjz0NihXTjLkvvkw40Ef
	C7jLbv930t8FMfKWohfe0g114sSRFbYktLw8wJKjWeINuoxB4t2c7kDqTkmnaCIH
	FZhPs/OtPQcwjNpzuEEhxRc6fnPdm1mPxJDmNviGPBbQuyuVI95TLFDZpULLs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD49D3B4A;
	Wed, 27 Jul 2011 16:31:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57E733B49; Wed, 27 Jul 2011
 16:31:55 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77F82D24-B88F-11E0-A9CF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177996>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Previously, it was possible to have a line like "file.txt =foo" in a
> .gitattribute file, after which an invocation like "git check-attr ''
> -- file.txt" would succeed.  This patch disallows both constructs.

Good. Very much appreciated.

> Currently it is possible to use the empty string as an attribute name.

Yeah, even I wouldn't call it a regression to disallow this ;-).
