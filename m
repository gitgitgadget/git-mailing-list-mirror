From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] perl/Git.pm: a bunch of fixes for Windows
Date: Sun, 24 Feb 2013 22:54:24 -0800
Message-ID: <7vsj4k289r.fsf@alter.siamese.dyndns.org>
References: <1359566583-19654-1-git-send-email-gnustavo@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Gustavo L. de M. Chaves" <gnustavo@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 07:55:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9rxj-0003Rt-OF
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289Ab3BYGyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:54:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246Ab3BYGyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:54:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B19997A8;
	Mon, 25 Feb 2013 01:54:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=fTQmCjOORlC8NQcTEDx1cvoJd+0=; b=h0EQmXNAxIOI/SUtne5u
	/L+sbxup3kpDKufpp6L/s637WbZrlI5uIc1VsKSsi9y9k/5tiRpo0TKxoEOhT/9x
	MkbfsfI1I57uYVho4BzmowOh6DjPh4uBpJmcL7tydIGLb2pIIeeKKz4vxc+2bz5M
	6rV0uBpoQ4e5s2dLV4Dp3O4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bPfoO+p9kJnLAXxUrmmIEd7+XKqEXN5+VLYoUsT2sQY96R
	WK08sfLW1By8XNLIksF+X0fO0s1l1+ZZJb2CbakxEK9x/ZCOC+FeBYfAr1g+Rhuz
	oyprQ7GHaIRVt2sK6ftC2CDKyqIz0mJTgCDzN9AL0I2sT5zE/FBAnxVm8+d38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E950897A4;
	Mon, 25 Feb 2013 01:54:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F35BF97A1; Mon, 25 Feb 2013
 01:54:29 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34155EB4-7F18-11E2-80C1-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217040>

"Gustavo L. de M. Chaves" <gnustavo@cpan.org> writes:

> ...
> While working on porting Git::Hooks to Windows I stumbled upon a few
> problems in the Git module, problems specific to the Windows
> environment. In the following sequence of patches I try to fix them.

Any comment on this from Windows folks?
